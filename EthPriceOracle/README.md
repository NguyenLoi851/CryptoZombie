This project uses Truffle to compile and deploy our smart contracts to Loom Testnet to demo about fetching data from oracle.

Steps to do:
1. npm init -y (yes for all setting in file package.json)
2. npm i truffle openzeppelin-solidity loom-js loom-truffle-provider bn.js axios
3. mkdir oracle && cd oracle && npx truffle init && cd ..
4. mkdir caller && cd caller && npx truffle init && cd ..