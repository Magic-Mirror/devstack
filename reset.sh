sudo ip link set docker0 down
sudo brctl delbr docker0
sudo pkill -f neutron
sudo pkill -f ovs
sudo pkill -f dnsmasq
rm -rf /opt/stack/opendaylight
rm -rf /opt/stack/data
