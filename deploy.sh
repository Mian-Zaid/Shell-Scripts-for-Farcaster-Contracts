#!/bin/bash

clear

# REMEMBER TO DO A "cp .env.prod .env" first.

export SENDER=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
PATH_TO_CONTRACTS="../script/"

# Uncomment the following block to deploy L1

echo "------Deploying L1------"
forge script \
    "${PATH_TO_CONTRACTS}DeployL1.s.sol" \
    --rpc-url http://127.0.0.1:8545 \
    --unlocked \
    --broadcast \
    --sender $SENDER

echo
echo
echo "------Deploying L2------"
forge script \
    "${PATH_TO_CONTRACTS}DeployL2.s.sol" \
    --rpc-url http://127.0.0.1:8545 \
    --unlocked \
    --broadcast \
    --sender $SENDER

echo
echo "------Deploying Upgrade L2------"
forge script \
    "${PATH_TO_CONTRACTS}UpgradeL2.s.sol" \
    --rpc-url http://127.0.0.1:8545 \
    --unlocked \
    --broadcast \
    --sender $SENDER


echo "------Deploying Storage Registry ------"
forge script \
    "${PATH_TO_CONTRACTS}StorageRegistry.s.sol" \
    --rpc-url http://127.0.0.1:8545 \
    --unlocked \
    --broadcast \
    --sender $SENDER

# Uncomment the following blocks to deploy other contracts
: << 'COMMENT'

echo "------Deploying Local Deploy ------"
forge script \
    "${PATH_TO_CONTRACTS}LocalDeploy.s.sol" \
    --rpc-url http://127.0.0.1:8545 \
    --unlocked \
    --broadcast \
    --sender $SENDER


COMMENT
