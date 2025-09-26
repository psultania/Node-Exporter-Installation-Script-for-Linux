#!/bin/sh
# -----------------------------------------------------------------------------
# Linux Node Exporter Installation Script
# Version: v1.0.0
# Credits and Author: Prashant Sultania (https://github.com/psultania)
# -----------------------------------------------------------------------------
#script for auto installation of node exporter
#download node exporter
echo "Open the NodeExporter URL (https://github.com/prometheus/node_exporter/releases), identify the version and paste it below" ;
echo "For example 2.41.0" ;
echo "Which node_exporter version ?" ;
read -r NodeVersion ;
echo "Version "$NodeVersion" NODE EXPORTER for Linux --- Downloaded starting"
wget https://github.com/prometheus/node_exporter/releases/download/v"$NodeVersion"/node_exporter-"$NodeVersion".linux-amd64.tar.gz ;
tar xvfz node_exporter-"$NodeVersion".linux-amd64.tar.gz
ln -s node_exporter-"$NodeVersion".linux-amd64 current

#create system script
echo "*****************creating system script***********" ;
#cd /etc/systemd/system
#sudo vi alm-node.service


#echo "Put the IP Address below:" ;
#echo "what is th IP Address ?" ;
#read -r ipaddress ;
host=`hostname -I | awk '{ print $1 }'`
echo "$host" ;

#echo "Writes a systemd unit file"
cat << EOF > /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target


[Service]
User=service_account_name
Group=service_group_name
ExecStart=/opt/platform/nodeexporter/current/node_exporter --web.listen-address="$host:9100"


[Install]
WantedBy=default.target

EOF

chmod a+x /etc/systemd/system/node_exporter.service

echo "**********Node Exporter installed successfully**********"

# node_exporter in systemctl
sudo systemctl daemon-reload
sudo systemctl status node_exporter.service
sudo systemctl start node_exporter.service
sudo systemctl status node_exporter.service

