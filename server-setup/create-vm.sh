availability_zones=("trUa:US-ASHBURN-AD-1" "trUa:US-ASHBURN-AD-2" "trUa:US-ASHBURN-AD-3")
n=0

until [ "$n" -ge 10080 ]; do
  for current_zone in "${availability_zones[@]}"; do
    sed -i "s/availability_domain = \".*\"/availability_domain = \"$current_zone\"/" main.tf
    terraform apply -auto-approve && break 2
    echo "Attempt - $n with zone $current_zone"
    sleep 2
  done
  sleep 20
  n=$((n + 1))
done
