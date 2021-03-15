#!/usr/bin/env bash
#
# Loads a list of AWS ip ranges and pulls out the health check related ips
# and makes a kernel ipset which can be used with iptables.
#

aws_ips=$(curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r '.prefixes[] | select(.service == "ROUTE53_HEALTHCHECKS").ip_prefix?')

ipset create aws_health hash:net

for ip in $aws_ips
do
  ipset add aws_health $ip
done

ipset list
