const UniTokenERC20 = artifacts.require("./UniTokenERC20.sol");

module.exports = function(deployer) {
  deployer.deploy(UniTokenERC20);
};
