const CashUSD = artifacts.require("CashUSD");
const CashUSDV2 = artifacts.require("CashUSDV2");

module.exports = async function (deployer) {
  const cashUSD = await CashUSD.deployed();
  await deployer.deploy(CashUSDV2, "Cash USD V2", "CUSD2");
  const cashUSDV2 = await CashUSDV2.deployed();
  await cashUSD.upgrade(cashUSDV2.address);
  await cashUSDV2.upgradeFrom(cashUSD.address, cashUSD.totalSupply());
  await cashUSD.close();
};
