echo "deploy begin....."

TF_CMD=node_modules/.bin/truffle-flattener

echo "" >  ./deployments/ERC908Full.full.sol
cat  ./scripts/head.sol >  ./deployments/ERC908Full.full.sol
$TF_CMD ./contracts/ERC908Full.sol >>  ./deployments/ERC908Full.full.sol 


echo "" >  ./deployments/ERC908Usership.full.sol
cat  ./scripts/head.sol >  ./deployments/ERC908Usership.full.sol
$TF_CMD ./contracts/ERC908Usership.sol >>  ./deployments/ERC908Usership.full.sol 


echo "" >  ./deployments/ERC908Combinable.full.sol
cat  ./scripts/head.sol >  ./deployments/ERC908Combinable.full.sol
$TF_CMD ./contracts/ERC908Combinable.sol >>  ./deployments/ERC908Combinable.full.sol 



echo "" >  ./deployments/ERC908Metadata.full.sol
cat  ./scripts/head.sol >  ./deployments/ERC908Metadata.full.sol
$TF_CMD ./contracts/ERC908Metadata.sol >>  ./deployments/ERC908Metadata.full.sol 


echo "" >  ./deployments/ERC908Enumerable.full.sol
cat  ./scripts/head.sol >  ./deployments/ERC908Enumerable.full.sol
$TF_CMD ./contracts/ERC908Enumerable.sol >>  ./deployments/ERC908Enumerable.full.sol 



echo "" >  ./deployments/ERC908.full.sol
cat  ./scripts/head.sol >  ./deployments/ERC908.full.sol
$TF_CMD ./contracts/ERC908.sol >>  ./deployments/ERC908.full.sol 


echo "deploy end....."