const CashUSDV2 = artifacts.require("CashUSDV2");
const CashUSD = artifacts.require("CashUSD");

const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

module.exports = async function (deployer) {
  await deployer.deploy(CashUSDV2, "CashUSD", "CUS");
  const existing = await CashUSD.deployed();
  const instance = await upgradeProxy(existing.address, CashUSDV2, { deployer });
  console.log("CashUSDV2 upgraded at:", instance.address);
};