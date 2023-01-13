#! /bin/bash

RenewedGenesis=$(curl -X POST http://rpc.vara-network.io/jsonrpc -H 'Content-Type: application/json' -d '[ { "id": 1, "jsonrpc": "2.0", "method": "chain_getBlockHash", "params": [0]}]'  | jq -r '.[].result');
RenewedSpecVersion=$(curl -X POST http://rpc.vara-network.io/jsonrpc -H 'Content-Type: application/json' -d '[ { "id": 1, "jsonrpc": "2.0", "method": "state_getRuntimeVersion", "params": []}]'  | jq -r '.[].result.specVersion');

originalgenesis=$(sed '1!d' spec.info)
originalspecVersion=$(sed '2!d' spec.info)

echo $originalgenesis
echo $originalspecVersion

NewValue="$RenewedGenesis\n$RenewedSpecVersion"

if [ "$originalspecVersion" -ne "$RenewedSpecVersion" ] || [ "$originalgenesis" != "$RenewedGenesis" ]
  then echo "They're not equal" && echo -e "$NewValue"  > spec.info
fi
