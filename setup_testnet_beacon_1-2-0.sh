#!/bin/bash

echo ""
echo ""
echo "*** Welcome to the KEEP Random Beacon v1.2.0 testnet client install guide ***"
echo "*** Setup everything to run a testnet node without any complexity ***"
echo ""
echo ""

while true; do 
    read -rep $'Do you wish to create a keep-client folder which will contain all relevant subfolders and files ? Y/N \n' yn
    case $yn in 
        [Yy]* ) 
        mkdir -p $HOME/keep-client/config 
        mkdir -p $HOME/keep-client/keystore
        mkdir -p $HOME/keep-client/persistence; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done 

echo ""
echo ""

echo "*** We will now configure some environment variables ***"
echo "***  and make sure they remain after server restart  ***"

echo ""
echo ""

varIP=$(curl -s ipecho.net/plain)
export SERVER_IP=$varIP

read -rep $'Please enter your Infura project ID \n' infura 
export INFURA_PROJECT_ID=$infura

echo ""

read -rep $'Please enter your Ethereum wallet address \n' address 
export ETH_WALLET=$address

echo ""

read -rep $'Please enter your Ethereum wallet password. BE CAREFUL. \n' pw
export KEEP_CLIENT_ETHEREUM_PASSWORD=$pw

cat <<EOF >>$HOME/.bashrc

## Setup some environment variables
export SERVER_IP=$varIP
# Change with your ID from Infura.
export INFURA_PROJECT_ID=$infura
# Change with your ETH Wallet.
export ETH_WALLET=$address
# Enter the password in which you encrypted your wallet file with
export KEEP_CLIENT_ETHEREUM_PASSWORD=$pw

EOF

echo ""
echo ""

cd $HOME/keep-client/config
touch config.toml 

echo "*** Configuring config.toml file ***"

cat <<CONFIG >>$HOME/keep-client/config/config.toml

# Connection details of ethereum blockchain.
[ethereum]
  URL = "wss://ropsten.infura.io/ws/v3/$INFURA_PROJECT_ID"
  URLRPC = "https://ropsten.infura.io/v3/$INFURA_PROJECT_ID"


[ethereum.account]
  Address = "$ETH_WALLET"
  KeyFile = "/mnt/keep-client/keystore/keep_wallet.json"


# This address might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-client/blob/master/docs/run-keep-client.adoc
[ethereum.ContractAddresses]
  KeepRandomBeaconOperator = "0x440626169759ad6598cd53558F0982b84A28Ad7a"
  TokenStaking = "0xEb2bA3f065081B6459A6784ba8b34A1DfeCc183A"
  KeepRandomBeaconService = "0xF9AEdd99357514d9D1AE389A65a4bd270cBCb56c"


# This addresses might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-client/blob/master/docs/run-keep-client.adoc
# Addresses of applications approved by the operator.
[SanctionedApplications]
  Addresses = [
    "0x2b70907b5c44897030ea1369591ddcd23c5d85d6",
]

[Storage]
  DataDir = "/mnt/keep-client/persistence"
  
[LibP2P]
  Peers = ["/dns4/testnet.keep-client.hashd.dev/tcp/3919/ipfs/16Uiu2HAmJsBiNVFNxsJ27NSQEByv39B1M7AKx5FrAc1htqYhHGhU",
"/dns4/testnet2.keep-client.hashd.dev/tcp/3919/ipfs/16Uiu2HAmAV3sNGXTpdZCguUEd5QqMmg13WZ5dBTtjbhYeQmTHwgM"]
Port = 3919

 # Override the node’s default addresses announced in the network
 AnnouncedAddresses = ["/ip4/$SERVER_IP/tcp/5678"]

[TSS]
# Timeout for TSS protocol pre-parameters generation. The value
# should be provided based on resources available on the machine running the client.
# This is an optional parameter, if not provided timeout for TSS protocol
# pre-parameters generation will be set to .
  PreParamsGenerationTimeout = "2m30s"
CONFIG

echo "*** Done ***"

echo ""
echo ""


while true; do 
    read -rep $'Please manually transfer your keep_wallet.json file into the keep-client/keystore folder. Once this is done, press Y. \n' yn
    case $yn in 
        [Yy]* ) echo "Thank you."; break;;
        * ) echo "You need to transfer your keep_wallet.json file and press Y.";;
    esac
done 

echo ""
echo ""

echo "*** Congratulations, you're all set up to run a v1.2.0 Random Beacon testnet node ***"
echo "*** Please download the run_testnet_beacon_1-2-0.sh script to run the node ***"