source openrc heat service
neutron router-create rtr
neutron router-gateway-set rtr public
neutron net-create net_mgmt
neutron subnet-create --gateway=11.0.0.1 --name subnet_net_mgmt net_mgmt 11.0.0.0/24 --enable-dhcp --dns-nameserver 8.8.8.8
neutron router-interface-add rtr subnet_net_mgmt
IMAGE=$(nova image-list | grep 'cirros.*uec\s' | tail -1 | awk '{print $2}')
echo $IMAGE
NETID=$(neutron net-list | grep -w net_mgmt | awk '{print $2}')
echo $NETID
sudo ip route add 11.0.0.0/24 dev br-int
openstack image create sfc --public --file sfc_cloud.qcow2
openstack flavor create custom --ram 1000 --disk 5 --public
tacker vnfd-create --vnfd-file sfc-random/test-vnfd.yaml
tacker vnf-create --name testVNF1 --vnfd-name test-vnfd
