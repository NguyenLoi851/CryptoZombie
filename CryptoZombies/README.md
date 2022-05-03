This project demo how to compile and deploy smart contracts to blockchain (Ropsten testnet) by Truffle

Steps to do:
1. npm install -g truffle
2. truffle init 
(contracts, migrations, test folders will be created automatically, file Migrations.sol keeps track of changes of your code.)
3. npm install truffle truffle-hdwallet-provider
4. Create contracts
5. Test contracts (truffle test)
6. truffle compile
(build folder will be created automatically)
7. Create file in migrations folder to deploy 
8. Config truffle (config provider, mnemonic, network, infura)
9. truffle migrate --network ropsten (truffle deploy = truffle migrate)

***Deploy to dev network of truffle***

9.1. truffle develop

(10 accounts, 10 addresses, mnemonic will be supplied automatically)

10.1. compile

11.1. test

12.1. migrate (or deploy)

13.1. ".exit" to end truffle(develop)
