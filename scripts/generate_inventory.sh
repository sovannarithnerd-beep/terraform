#!/bin/bash
set -euo pipefail

# Ensure Terraform root
cd "$(dirname "$0")/.."

TF_OUTPUT_JSON="./scripts/outputs.json"

if [ ! -f "$TF_OUTPUT_JSON" ]; then
    echo "[INFO] Generating Terraform outputs..."
    terraform output -json > "$TF_OUTPUT_JSON"
fi

# Use correct Terraform output keys
PRIVATE_IPS=$(jq -r '.k8s_private_ips.value[]?' "$TF_OUTPUT_JSON")
PUBLIC_IPS=$(jq -r '.k8s_public_ips.value[]?' "$TF_OUTPUT_JSON")

if [ -z "$PRIVATE_IPS" ] || [ -z "$PUBLIC_IPS" ]; then
    echo "[ERROR] Terraform outputs are empty. Run 'terraform apply' first."
    exit 1
fi

INVENTORY_DIR="./inventory/mycluster"
mkdir -p "$INVENTORY_DIR"
INVENTORY_FILE="$INVENTORY_DIR/hosts.ini"

echo "[INFO] Writing Kubespray inventory to $INVENTORY_FILE"
cat <<EOF > "$INVENTORY_FILE"
[all]
EOF

i=1
for ip in $PRIVATE_IPS; do
    echo "node$i ansible_host=${ip} ip=${ip}" >> "$INVENTORY_FILE"
    ((i++))
done

# Define HA groups
cat <<EOF >> "$INVENTORY_FILE"

[kube_control_plane]
node1
node2
node3

[etcd]
node1
node2
node3

[kube_node]
node1
node2
node3

[k8s_cluster:children]
kube_control_plane
kube_node
EOF

echo "[SUCCESS] Inventory generated successfully!"
echo "📁 File: $INVENTORY_FILE"
echo
cat "$INVENTORY_FILE"
