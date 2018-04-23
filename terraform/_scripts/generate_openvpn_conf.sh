#!/bin/sh

# NOTE: relies on 'http://subnet.im' subnet calculator api
# http://subnet.im/api.html

# usage: generate_openvpn_config $output_file_path $hostname
#    ex: generate_openvpn_config "$(pwd)/openvpn.conf" "vpn.stevenaldinger.com" "crypto"
# creating configmap: kubectl create configmap vpn-conf --from-file=openvpn.conf=$(pwd)/openvpn.conf --namespace=vpn
generate_openvpn_config () {
  output_file_path="$1"
  hostname="$2"
  cluster_name="$3"

  if [ -z "$output_file_path" ] || [ -z "$hostname" ]
  then
    echo "Error, you need to specify both output_file_path and hostname."
    return 1
  fi

  # looks like -> 'servicesIpv4Cidr: 10.7.240.0/20'
  services_cidr_string=$(gcloud container clusters describe $cluster_name | grep -i servicesIpv4Cidr)

  # get everything after the space
  services_cidr=${services_cidr_string#* }

  # {
  #   "ip": "10.7.240.0",
  #   "netmask": "255.255.240.0"
  # }
  services_ip_and_netmask=$(curl http://subnet.im/$services_cidr | jq '{ ip: .ip, netmask: .netmask }')

  services_ip=$(echo "$services_ip_and_netmask" | jq -r '.ip')

  services_netmask=$(echo "$services_ip_and_netmask" | jq -r '.netmask')

  kube_dns_cluster_ip=$(kubectl get svc/kube-dns -n kube-system -o jsonpath='{.spec.clusterIP}')

  cat > $output_file_path <<EOF
server 192.168.255.0 255.255.255.0
verb 3
key /etc/openvpn/pki/private/$hostname.key
ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/$hostname.crt
dh /etc/openvpn/pki/dh.pem
tls-auth /etc/openvpn/pki/ta.key
key-direction 0
keepalive 10 60
persist-key
persist-tun

proto udp
# Rely on Docker to do port mapping, internally always 1194
port 1194
dev tun0
status /tmp/openvpn-status.log

user nobody
group nogroup

### Route Configurations Below
route 192.168.254.0 255.255.255.0

# https://www.tunnelsup.com/subnet-calculator/

# > gcloud container clusters describe development | grep -i cidr
# clusterIpv4Cidr: 10.48.0.0/14
# nodeIpv4CidrSize: 24
# servicesIpv4Cidr: $services_cidr

# not sure if there's an advantage to doing it this way
# over no-pull + route
# https://support.hidemyass.com/hc/en-us/articles/202720536-Using-VPN-for-specific-websites-IPs-only
# cluster services cidr: 10.51.240.0/20
push "route $services_ip $services_netmask vpn_gateway"

### Push Configurations Below
push block-outside-dns
# kubectl --namespace=kube-system get service kube-dns -o jsonpath='{.spec.clusterIP}'
push dhcp-option DNS $kube_dns_cluster_ip

push dhcp-option DOMAIN svc.cluster.local
push dhcp-option DOMAIN-NAME cluster.local
push dhcp-option DOMAIN-SEARCH cluster.local svc.cluster.local default.svc.cluster.local
EOF
}

generate_openvpn_config "$1" "$2" "$3"

exit 0
