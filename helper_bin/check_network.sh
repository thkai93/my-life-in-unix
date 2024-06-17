#!/bin/bash

# List all network services
network_services=$(networksetup -listallnetworkservices | tail -n +2)

echo "Network Services and IP Addresses:"

# Loop through each network service and display its IP address
while IFS= read -r service; do
    # Get the IPv4 address
    ipv4_address=$(networksetup -getinfo "$service" | grep "IP address" | awk '{print $3}')
    
    # Get the IPv6 address
    ipv6_address=$(networksetup -getinfo "$service" | grep "IPv6 IP address" | awk '{print $4}')
    
    # Print the service name and its IP addresses
    echo "Service: $service"
    echo "  IPv4 Address: ${ipv4_address:-None}"
    echo "  IPv6 Address: ${ipv6_address:-None}"
    echo
done <<< "$network_services"


