# How many new outputs were created by block 123,456?

#!/bin/bash

bhash=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_230 -rpcpassword=DzFoWDIBKWcq getblockhash 123456)
blockdata=$(bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_230 -rpcpassword=DzFoWDIBKWcq getblock $bhash)
result=$(echo "$blockdata" | jq '.nTx')
echo $result