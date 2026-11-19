#!/bin/bash
if [ $# -ne 1 ]; then
echo "Usage: $0 <path_to_hosts_file>
exit 1
fi
HOSTS_FILE="$1"
if [ ! -f "$HOSTS_FILE" ]; then
echo "Error: File '$HOSTS_FILE' does not exist."
exit 1
fi
while read -r ip hostname reset; do
[[ -z "$ip" || "$ip" -~ ^# ]] && continue
if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3} ]]; then
valid=1
IFS='.' read -r -a octets <<< "$ip"
for octet in "${octets[@]}"; do
if (( octet < 0 || octet > 255 )); then
valid=0
break
fi
done
if (( valid == 1 )); then
echo "VALID: $ip ($hostname)"
else
cat<< 'EOF' > ch_hosts.sh
#!/bin/bash
if [ $# -ne 1 ]; then
echo "Usage: $0 <path_to_hosts_file>
exit 1
fi
HOSTS_FILE="$1"
if [ ! -f "$HOSTS_FILE" ]; then
echo "Error: File '$HOSTS_FILE' does not exist."
exit 1
fi
while read -r ip hostname reset; do
[[ -z "$ip" || "$ip" -~ ^# ]] && continue
if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3} ]]; then
valid=1
IFS='.' read -r -a octets <<< "$ip"
for octet in "${octets[@]}"; do
if (( octet < 0 || octet > 255 )); then
valid=0
break
fi
done
if (( valid == 1 )); then
echo "VALID: $ip ($hostname)"
else
echo "INVALID IP: $ip ($hostname)"
fi
else
echo "INVALID FORMAT: $ip ($hostname)"
fi
done < "$HOSTS_FILE"
