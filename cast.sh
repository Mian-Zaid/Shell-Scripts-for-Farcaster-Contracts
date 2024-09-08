#!/bin/sh
clear


# ID registry params
ID_REGISTRY_OWNER_ADDRESS=0x53c6dA835c777AD11159198FBe11f95E5eE6B692

# Key registry params
KEY_REGISTRY_OWNER_ADDRESS=0x53c6dA835c777AD11159198FBe11f95E5eE6B692


# ID registry params
# ID_REGISTRY_OWNER_ADDRESS=0x53c6dA835c777AD11159198FBe11f95E5eE6B692

# Key registry params
# KEY_REGISTRY_OWNER_ADDRESS=0x2D93c2F74b2C4697f9ea85D0450148AA45D4D5a2

# Metadata validator params
METADATA_VALIDATOR_OWNER_ADDRESS=0x53c6dA835c777AD11159198FBe11f95E5eE6B692

# Bundler params
BUNDLER_TRUSTED_CALLER_ADDRESS=0x2D93c2F74b2C4697f9ea85D0450148AA45D4D5a2
BUNDLER_OWNER_ADDRESS=0x53c6dA835c777AD11159198FBe11f95E5eE6B692

# Recovery proxy params
RECOVERY_PROXY_OWNER_ADDRESS=0xFFE52568Fb0E7038Ef289677288BB704E5c9E82e


OWNER_ADDR=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

RECOVERY_ADDR=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
FROM_ADDR=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

ID_REGISTRY_ADDR=0xbb7292b96a61d50295a856ad8e1abed9f07c8138
STORAGE_REGISTRY_ADDR=0x62356f85c1388cc4a9857151f4e09795c4fe9955
ID_GATEWAY_ADDR=0x5d70accaf9f52a914be4fe1ec45cfccd356fc7cb
KEY_REGISTRY_ADDR=0x575e23442b66a91680d489f9c50771baea738ab8
KEY_GATEWAY_ADDR=0xf3b7500a660ef8812d7b7fa857d607be1a8e96ee
SignedKeyRequestValidator_ADDR=0xf47cb0634f2a081c45f0d91c8bd0d68ea3e237a2
BUNDLER_ADDR=0x521155e610daff0ace94ae0a359284481edb0cd7
RECOVERY_PROXY_ADDR=0xe4b8bc8f0b55027f559028eacd6793ab72396011

EXTRA_STORAGE=500

RPC_URL=http://127.0.0.1:8545/



# Function to print a line divider
print_line_divider() {
    # Define color codes
    COLOR_GREEN="\033[0;32m"
    COLOR_RESET="\033[0m"  # Reset to default color

    # Get the length parameter, default to 60 if not provided
    local length=${1:-80}

    # Print the line divider with the color
    printf '\n%b\n' "${COLOR_GREEN}$(printf '%*s' "$length" | tr ' ' '=')${COLOR_RESET}"
}



# Define the function to get the balance of an Ethereum wallet
get_wallet_balance() {
    
    COLOR_RED="\033[0;31m"
    COLOR_RESET="\033[0m"  # Reset to default color


    # Call the `eth_getBalance` JSON-RPC method to get the balance
    local response=$(cast balance \
        "$FROM_ADDR" \
        --rpc-url "$RPC_URL")

    # Print the response
    echo
    echo -e "Wallet Balance of $FROM_ADDR (in wei):${COLOR_RED} $response ${COLOR_RESET}"

    return 0
}

get_wallet_balance "${FROM_ADDR}" "$RPC_URL"



# Function to get the owner of ID Registry Contract
get_contract_owner_of_Id_registry(){
        
        print_line_divider

        local response=$(cast call\
                "${ID_REGISTRY_ADDR}"    \
                "owner()(address)"              \
                --rpc-url "$RPC_URL")
        
        echo
        echo "The Owner of Id Registry contract is: $response"
}

get_contract_owner_of_Id_registry
get_wallet_balance


# Function to get the owner of ID Gateway Contract
get_contract_owner_of_Id_gateway(){
        
        print_line_divider

        local response=$(cast call\
                "${ID_GATEWAY_ADDR}"    \
                "owner()(address)"              \
                --rpc-url "$RPC_URL")
        
        echo
        echo "The Owner of Id Gateway contract is: $response"
}

get_contract_owner_of_Id_gateway
get_wallet_balance

# Define the function to get the paused status of the contract
get_paused_status_of_Id_gateway() {
    local response=$(cast call \
        "${ID_GATEWAY_ADDR}" \
        "paused()(bool)" \
        --rpc-url "$RPC_URL")
        

     echo "$response"

}

# Define the function to UnPause the contract
unpause_Id_gateway_contract(){
        
        print_line_divider

    # Get the paused status
    local ps
    ps=$(get_paused_status_of_Id_gateway)

    # Trim any potential leading or trailing whitespace
    ps=$(echo "$ps" | xargs)

    # Use the paused status in a conditional statement
    if [ "$ps" = "true" ]; then
        echo
        echo "The contract is paused!!!"
        
        echo
        echo "Unpausing Id_gateway_contract..."
        cast send \
            "${ID_GATEWAY_ADDR}" \
            "unpause()" \
            --from "${OWNER_ADDR}" \
            --private-key "${PRIVATE_KEY}" \
            --gas-limit 100000 \
            --rpc-url "$RPC_URL"

    else
        echo
        echo "The ID_GATEWAY contract is not paused!!!"
    fi
}

unpause_Id_gateway_contract
get_wallet_balance


# Define the function to get the paused status of the contract
get_paused_status_of_Id_registry() {
    local response=$(cast call \
        "${ID_REGISTRY_ADDR}" \
        "paused()(bool)" \
        --rpc-url "$RPC_URL")
        
    # Output the response without any extra characters
    echo "$response"
}

# Define the function to UnPause the contract
unpause_Id_registry_contract(){
        
    print_line_divider

    # Get the paused status
    local ps
    ps=$(get_paused_status_of_Id_registry)

    # Trim any potential leading or trailing whitespace
    ps=$(echo "$ps" | xargs)

    # Use the paused status in a conditional statement
        if [ "$ps" = "true" ]; then
                echo
                echo "The contract is paused!!!"
                
                echo
                echo "Unpausing Id_registry_contract..."
                cast send \
                "${ID_REGISTRY_ADDR}" \
                "unpause()" \
                --from "${OWNER_ADDR}" \
                --private-key "${PRIVATE_KEY}" \
                --gas-limit 100000 \
                --rpc-url "$RPC_URL"

        else
                echo
                echo "The ID_REGISTRY contract is not paused!!!"
        fi
}

unpause_Id_registry_contract
get_wallet_balance


# Define function to get the single Unit Price
get_single_unit_price(){
        print_line_divider

        echo
        echo "Sending request to get the Storage price for Single Unit"

        local response=$(cast call \
                "${ID_GATEWAY_ADDR}" \
                "price()(uint256)"  \
                --from "${FROM_ADDR}" \
                --private-key "${PRIVATE_KEY}" \
                --rpc-url "$RPC_URL")

        echo
        echo "The Storage Price is: $response"
}

get_single_unit_price
get_wallet_balance


# Define the function to get the Register FID using ID gateway
register_fid_using_id_gateway_contract(){

        print_line_divider


        echo
        echo "Sending transaction to register FID with ID Gateway"

        # Save the transaction response in a variable
        response=$(cast send \
        "${ID_GATEWAY_ADDR}" \
        "register(address)(uint256,uint256)" \
        "${RECOVERY_ADDR}" \
        --gas-limit 29999999 \
        --gas-price 7000 \
        --priority-gas-price 1 \
        --value 1000000000000000000 \
        --from "${FROM_ADDR}" \
        --private-key "${PRIVATE_KEY}" \
        --rpc-url "$RPC_URL" \
        -- --broadcast)

        # Print the response
        echo
        echo "Transaction Response: $response"


}

register_fid_using_id_gateway_contract
get_wallet_balance



# Define the function to get the Register FID using ID Registry
register_fid_using_id_registry_contract(){

        print_line_divider


        echo
        echo "Sending transaction to register FID with ID Registry"

        response=$(cast send \
                "${ID_REGISTRY_ADDR}"                \
                "register(address,address)(uint256)" \
                "${RECOVERY_ADDR}"                   \
                "${FROM_ADDR}"                       \
                --gas-limit 7000000                  \
                --gas-price 70000                  \
                --priority-gas-price 1 \
                --value  1000000000000000000         \
                --from "${FROM_ADDR}"                \
                --private-key "${PRIVATE_KEY}"       \
                --rpc-url "$RPC_URL"     \
                -- --broadcast)


        # Print the response
        echo
        echo "Transaction Response: $response"

}


register_fid_using_id_registry_contract
get_wallet_balance



# 1 ETH = 1000000000000000000 wei
