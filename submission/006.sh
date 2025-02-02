# Which tx in block 257,343 spends the coinbase output of block 256,128?
blockhash_256128=$(bitcoin-cli getblockhash 256128)
coinbase_txid=$(bitcoin-cli getblock $blockhash_256128 | jq -r '.tx[0]')

blockhash_257343=$(bitcoin-cli getblockhash 257343)
txids=$(bitcoin-cli getblock $blockhash_257343 | jq -r '.tx[]')

for txid in $txids; do
    inputs=$(bitcoin-cli getrawtransaction $txid true | jq -r '.vin[].txid')
    for input in $inputs; do
        if [ "$input" == "$coinbase_txid" ]; then
            echo $txid
            exit 0
        fi
    done
done
