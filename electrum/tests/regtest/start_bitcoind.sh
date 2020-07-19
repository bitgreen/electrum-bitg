#!/usr/bin/env bash
export HOME=~
set -eux pipefail
mkdir -p ~/.bitgreen
cat > ~/.bitgreen/bitgreen.conf <<EOF
regtest=1
txindex=1
printtoconsole=1
rpcuser=doggman
rpcpassword=donkey
rpcallowip=127.0.0.1
zmqpubrawblock=tcp://127.0.0.1:28332
zmqpubrawtx=tcp://127.0.0.1:28333
fallbackfee=0.0002
[regtest]
rpcbind=0.0.0.0
rpcport=19332
EOF
rm -rf ~/.bitgreen/regtest
screen -S bitgreend -X quit || true
screen -S bitgreend -m -d bitgreend -regtest
sleep 6
addr=$(bitgreen-cli getnewaddress)
bitgreen-cli generatetoaddress 150 $addr > /dev/null
