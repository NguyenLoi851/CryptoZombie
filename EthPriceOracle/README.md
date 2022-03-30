This project uses Truffle to compile and deploy our smart contracts to Loom Testnet to demo about fetching data from oracle.

Steps to do:
1. npm init -y (yes for all setting in file package.json)
2. npm i truffle openzeppelin-solidity loom-js loom-truffle-provider bn.js axios
3. mkdir oracle && cd oracle && npx truffle init && cd ..
4. mkdir caller && cd caller && npx truffle init && cd ..
5. Create caller contract, oracle contract and respective interface
6. Create file utils/common.js (this file is used to connect your Dapp to blockchain network)
7. Create file EthPriceOracle.js to fetch the Eth price from Binance API
8. Create 2 private keys for caller contract and oracle contract through file scripts/gen-key
9. Generate private key for 2 contracts: 
 - oracle: "node scripts/gen-key.js oracle/oracle_private_key"
 - caller: "node scripts/gen-key.js caller/caller_private_key"
10. Configure Truffe for 2 contracts through file truffe-config.js
11. Create the migration files
12. Change field "scripts" in file package.json to make it easier when typing to deploy contracts
13. npm run deploy:all
14. Start oracle: "node EthPriceOracle.js"
15. Start client: "node Client.js" and it will returns Eth/USD price
