const EthPriceOracle = artifacts.require('EthPriceOracle')

export default function (deployer) {
  deployer.deploy(EthPriceOracle)
}