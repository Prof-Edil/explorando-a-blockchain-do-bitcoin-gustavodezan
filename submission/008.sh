# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

raw=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 true)
redeem_script=$(echo "$raw" | jq -r '.vin[0].txinwitness[-1]')
decoded_script=$(bitcoin-cli decodescript "$redeem_script")
pubkey_hex=$(echo "$decoded_script" | jq -r '.asm' | awk '{for(i=1;i<=NF;i++) if (length($i) == 66 || length($i) == 130) print $i}' | head -n 1)
echo "$pubkey_hex"