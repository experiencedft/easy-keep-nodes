#!/bin/bash

echo ""
echo ""
echo "*** Welcome to the KEEP ECDSA v1.0.0 testnet client install guide ***"
echo "*** Setup everything to run a testnet node without any complexity ***"
echo ""
echo ""

while true; do 
    read -rep $'Do you wish to create a keep-ecdsa folder which will contain all relevant subfolders and files ? Y/N \n' yn
    case $yn in 
        [Yy]* ) 
        mkdir -p $HOME/keep-ecdsa/config 
        mkdir -p $HOME/keep-ecdsa/keystore
        mkdir -p $HOME/keep-ecdsa/persistence; break;;
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

cd $HOME/keep-ecdsa/config
touch config.toml 

echo "*** Configuring config.toml file ***"

cat <<CONFIG >>$HOME/keep-ecdsa/config/config.toml

# Connection details of ethereum blockchain.
[ethereum]
  URL = "wss://ropsten.infura.io/ws/v3/$INFURA_PROJECT_ID"
  URLRPC = "https://ropsten.infura.io/v3/$INFURA_PROJECT_ID"


[ethereum.account]
  Address = "$ETH_WALLET"
  KeyFile = "/mnt/keep-ecdsa/keystore/keep_wallet.json"


# This address might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-ecdsa/blob/master/docs/run-keep-ecdsa.adoc
[ethereum.ContractAddresses]
  BondedECDSAKeepFactory = "0x17caddf97a1d1123efb7b233cb16c76c31a96e02"


# This addresses might change and need to be replaced from time to time
# if it does, the new contract address will be listed here:
# https://github.com/keep-network/keep-ecdsa/blob/master/docs/run-keep-ecdsa.adoc
# Addresses of applications approved by the operator.
[SanctionedApplications]
  Addresses = [
    "0x2b70907b5c44897030ea1369591ddcd23c5d85d6",
]

[Storage]
  DataDir = "/mnt/keep-ecdsa/persistence"
  
[LibP2P]
  Peers = ["/dns4/testnet.keep-client.hashd.dev/tcp/3920/ipfs/16Uiu2HAmJsBiNVFNxsJ27NSQEByv39B1M7AKx5FrAc1htqYhHGhU",
  "/ip4/3.23.88.229/tcp/3919/ipfs/16Uiu2HAmEZpkf1Td8rSBMmgPoa66si2kJLb83Rd2eztJ6f5oLvhp",
  "/dns4/ecdsa-0.test.keep.network/tcp/3919/ipfs/16Uiu2HAmCcfVpHwfBKNFbQuhvGuFXHVLQ65gB4sJm7HyrcZuLttH",    
  "/dns4/ecdsa-1.test.keep.network/tcp/3919/ipfs/16Uiu2HAm3eJtyFKAttzJ85NLMromHuRg4yyum3CREMf6CHBBV6KY"]
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
    read -rep $'Please manually transfer your keep_wallet.json file into the keep-ecdsa/keystore folder. Once this is done, press Y. \n' yn
    case $yn in 
        [Yy]* ) echo "Thank you."; break;;
        * ) echo "You need to transfer your keep_wallet.json file and press Y.";;
    esac
done 

echo ""
echo ""

echo "*** Congratulations, you're all set up to run a v1.0.0 ECDSA testnet node ***"
echo "*** Please download the run_testnet_ecdsa_1-0-0.sh script to run the node ***"