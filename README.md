# Easy Keep Nodes
 A collection of scripts aimed to simplify the setup of Keep nodes for non-developers using the official Docker images.

 ## Prerequisites 

 These scripts have been tested for Ubuntu on WSL and should work with a native Ubuntu distribution. In order to use these scripts, you first need to: 

 - Create an Infura account and project
 - Create an Ethereum wallet with a keystore that you will rename as ``keep_wallet.json`` 
 - Import your Ethereum walllet to Metamask
 - Authorize the Keep contracts on the appropriate Keep dashboard (testnet or mainnet)

 If you are unfamiliar with these steps, you can seek help on the official [Keep Discord](https://discord.com/invite/wYezN7v). 

 ## How to use?

First you need to be clear on what kind of node (ECDSA or Random Beacon) and which node version you wish to run on which Ethereum network (testnet or mainnet). For example, if you wish to run a testnet ECDSA 1.0.0 node, the relevant scripts are those suffixed with ``testnet_ECDSA_1-0-0``. In the following, I will assume this is the node you wish to run as they are the only scripts available as of now. More will be added later.

**IMPORTANT:** download the scripts as they are and do not copy paste their contents into local files to avoid any formatting issue.

1. Download the ``setup_testnet_ECDSA_1-0-0.sh`` and ``run_testnet_ECDSA_1-0-0.sh`` scripts.
2. Move both the scripts to your HOME directory.
3. To make sure these scripts are executable, run the commands ``chmod +x setup_testnet_ECDSA_1-0-0.sh`` and ``chmod +x run_testnet_ECDSA_1-0-0.sh`` from your HOME directory.
4. Run the command ``source ./setup_testnet_ECDSA_1-0-0.sh`` and follow the instructions in the command line interface.
5. Run the command ``bash run_testnet_ECDSA_1-0-0.sh``.

This is it. 

To check that your node started, you can run the command ``docker ps -a`` to see if the Docker image is running.

To check on the status of your node and whether it is connecting to peers and executing protocol instructions, run ``docker logs ecdsa --since 10m -f`` (different command for different kinds of nodes, ask on Discord if unsure).