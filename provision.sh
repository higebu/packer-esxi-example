#!/bin/sh -e

esxcli system settings advanced set -o /Net/GuestIPHack -i 1
esxcli network vswitch standard policy security set -p yes -v vSwitch0
esxcli network vswitch standard portgroup policy security set -o yes -p "VM Network"
esxcli software vib install -v http://download3.vmware.com/software/vmw-tools/esxui/esxui-signed.vib
