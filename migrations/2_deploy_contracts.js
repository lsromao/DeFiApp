const TokenFarm = artifacts.require('TokenFarm')
const DappToken = artifacts.require('DappToken')
const DaiToken = artifacts.require('DaiToken')

module.exports = async function(deployer, network, accounts) {
  //Deply Mock DAI Token
  await deployer.deploy(DaiToken)
  const daiToken = await DaiToken.deployed()

  //Deply Rondinha  Token
  await deployer.deploy(DappToken)
  const dappToken = await DappToken.deployed()

  //Deploy Token Farm 
  await deployer.deploy(TokenFarm, dappToken.address, daiToken.address)
  const tokenFarm = await TokenFarm.deployed()

  // Transfer all tokens to TokenFarm (1 million)
  await dappToken.transfer(tokenFarm.address, '1000000000000000000000000')

  // Transfer 100 Mock DAI tokens to investor
  await daiToken.transfer(accounts[1], '100000000000000000000')

};
