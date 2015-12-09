#!/bin/sh

# Install packages
tdnf install -y tzdata

# DHCP settings
rm /etc/systemd/network/10-dhcp-en.network
cat <<EOF > /etc/systemd/network/10-dhcp.network
[Match]
Name=eth*

[Network]
DHCP=v4

[DHCP]
RequestBroadcast=true
EOF

# SSH settings
echo "UseDNS no" >> /etc/ssh/sshd_config

# Timezone setting
ln -sf /usr/share/zoneinfo/Japan /etc/localtime

# Disable iptables
systemctl stop iptables
systemctl disable iptables

# Enable timesync via vmtoolsd
vmware-toolbox-cmd timesync enable

# Enable Docker to start at runtime
systemctl enable docker

# Clean up
cat /dev/null > /var/log/lastlog
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/btmp
