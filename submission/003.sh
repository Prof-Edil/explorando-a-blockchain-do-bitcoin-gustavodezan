# How many new outputs were created by block 123,456?

#!/bin/bash

bhash=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_230 -rpcpassword=DzFoWDIBKWcq getblockhash 123456)
blockdata=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_230 -rpcpassword=DzFoWDIBKWcq getblock $bhash)
# echo "$blockdata" | jq -r '.nTx'

txids=$(echo "$blockdata" | jq -r '.tx[]')

total_outputs=0

for txid in $txids; do
    txdata=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_230 -rpcpassword=DzFoWDIBKWcq getrawtransaction "$txid" 1)

    num_outputs=$(echo "$txdata" | jq '.vout | length')

    total_outputs=$((total_outputs + num_outputs))
done

echo $total_outputs