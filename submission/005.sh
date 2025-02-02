# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

raw_transaction=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 true)
# echo $raw_transaction
pubkeys=$(echo $raw_transaction | jq -r '.vin[].txinwitness[1]')
# echo "Public Keys: $pubkeys"

pubkeys_json=$(echo "$pubkeys" | jq -R -s -c 'split("\n") | map(select(length > 0))')

# Create 1-of-4 multisig P2SH address -> recebe um json com as pubkeys
multisig=$(bitcoin-cli createmultisig 1 "$pubkeys_json")

echo $multisig #| jq