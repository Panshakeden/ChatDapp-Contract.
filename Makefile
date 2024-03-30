include .env

deploy:
	forge create --rpc-url ${RPC_URL} \
    --private-key ${PRIVATE_KEY} \
    --etherscan-api-key ${ETHERSCAN_API_KEY} \
    --verify \
    src/ENS.sol:ENS

deployChat:
	forge create --rpc-url ${RPC_URL} \
    --constructor-args $(ensAddress)\
    --private-key ${PRIVATE_KEY} \
    --etherscan-api-key ${ETHERSCAN_API_KEY} \
    --verify \
    src/ChatAppilcation.sol:ChatAppilcation