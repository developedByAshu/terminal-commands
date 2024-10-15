#!/bin/bash
#
# Launcher needed since AWS doesn't release an updated client for VPN for updated versions of Ubuntu
# Instruction taken from https://repost.aws/questions/QUNJeF_ja_Suykous7EvfX5Q/aws-client-vpn-on-ubuntu-22-04
 
# Mandatory step for Ubuntu versions 22.04 and 24.04 is to install libssl 1.1, not available in Ubuntu repo since 22.04
# wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
# sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb
 
# Then download the client and install it - possible troubleshooting needed
# https://docs.aws.amazon.com/vpn/latest/clientvpn-user/client-vpn-connect-linux.html
# https://docs.aws.amazon.com/vpn/latest/clientvpn-user/linux-troubleshooting.html (usually steps 1 and 2 are enough)
 
# Check .bashrc
if [[ $(cat ~/.bashrc | grep -c "export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1") -ne 1 ]]; then
	echo "export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 line is missing in your .bashrc file, add it"
	exit 1
fi
 
# Check /etc/systemd/system/awsvpnclient.service
if [ -f /etc/systemd/system/awsvpnclient.service ]; then
	if [[ $(cat /etc/systemd/system/awsvpnclient.service | grep -c DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1) -ne 1 ]]; then
        echo "Environment=DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 line is missing in"
	echo "/etc/systemd/system/awsvpnclient.service file, please add it after User=root"
        exit 1
        fi
fi
 
# Launch the client from here, icon won't work and don't rely on UI after connection


# Run the command in a sub-shell
(
    /opt/awsvpnclient/AWS\ VPN\ Client %u &
)

# Exit the parent shell
exit

# =================== Previous Code ===================
# Run the command in the background
# /opt/awsvpnclient/AWS\ VPN\ Client %u &

# Disown the process so it's not tied to the shell
# disown

# Exit the terminal
# exit
