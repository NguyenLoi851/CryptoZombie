const CallerContract = artifacts.require('CallerContract')

export default function (deployer) {
  deployer.deploy(CallerContract)
}