HOSTS_FILE="$HOME/etc/hosts"
while read -r ip hostname rest; do
[[ -z "$ip" || "$ip" =~ ^# ]] && continue
if [[ "$ip" =~ ^ ([0-9]{1,3}\.){3}[0-9]{1,3} ]]; then
valid=1
IFS='.' read -r -a octets <<< "$ip"
for octet in "${octets[@]}"; do
if (( octet < 0 || octet > 255 )); then
valid=0
break
fi
done
if (( valid==1 )); then
echo "VALID: $ip ($hostname)"
else
echo "INVALID IP: $ip ($hostname)"
fi
else
echo "INVALID FORMAT: $ip ($hostname)"
fi
done <"$HOSTS_FILE"
