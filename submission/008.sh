# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
raw=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 true)
pubkey_hex=$(echo $raw | jq -r '.vin[0].txinwitness[-1]')
bitcoin-cli decodescript $pubkey_hex | jq -r '.segwit.address'