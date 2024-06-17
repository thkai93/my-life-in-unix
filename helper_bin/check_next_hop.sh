#!/bin/bash

echo "Gathering network details..."

# List all network services
network_services=$(networksetup -listallnetworkservices | tail -n +2)

echo "Network Services and Details:"

# Loop through each network service and display its details
while IFS= read -r service; do
    # Get the device name associated with the service
    device=$(networksetup -getinfo "$service" | grep "Device" | awk '{print $2}')
    
    # Get the IPv4 address
    ipv4_address=$(networksetup -getinfo "$service" | grep "IP address" | awk '{print $3}')
    
    # Get the IPv6 address
    ipv6_address=$(networksetup -getinfo "$service" | grep "IPv6 IP address" | awk '{print $4}')
    
    # Get the next hop (default gateway) for the service
    next_hop=$(netstat -rn | grep -w "$device" | grep default | awk '{print $2}')
    
    # Print the service name and its details
    echo "Service: $service"
    echo "  Device: ${device:-None}"
    echo "  IPv4 Address: ${ipv4_address:-None}"
    echo "  IPv6 Address: ${ipv6_address:-None}"
    echo "  Next Hop Address: ${next_hop:-None}"
    echo
done <<< "$network_services"

echo "Default Routes and Next Hop Addresses:"

# Display the routing table and filter for default routes
default_routes=$(netstat -rn | grep default)

# Loop through each default route and display the next hop address
while IFS= read -r route; do
    # Split the route information into an array
    route_info=($route)
    
    # Get the network interface
    interface=${route_info[5]}
    
    # Get the next hop address (gateway)
    next_hop=${route_info[1]}
    
    # Print the interface and next hop address
    echo "Interface: $interface"
    echo "  Next Hop Address: $next_hop"
    echo
done <<< "$default_routes"

