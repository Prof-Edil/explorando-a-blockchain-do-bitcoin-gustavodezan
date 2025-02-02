# Only one single output remains unspent from block 123,321. What address was it sent to?

blockhash=$(bitcoin-cli getblockhash 123321)
txids=$(bitcoin-cli getblock "$blockhash" | jq -r '.tx[]')

for txid in $txids; do
    raw_tx=$(bitcoin-cli getrawtransaction "$txid" true)
    vout_count=$(echo "$raw_tx" | jq '.vout | length')

    for ((i=0; i<vout_count; i++)); do
        scriptPubKey=$(echo "$raw_tx" | jq -r ".vout[$i].scriptPubKey")
        address=$(echo "$scriptPubKey" | jq -r '.address // empty')
        is_unspent=$(bitcoin-cli gettxout "$txid" "$i")

        if [ "$is_unspent" != "null" ] && [ -n "$address" ]; then
            echo "$address"
            exit 0
        fi
    done
done
