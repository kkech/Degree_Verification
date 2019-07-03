const VerifTokenERC20 = artifacts.require("./VerifTokenERC20.sol");

module.exports = function(deployer) {
  deployer.deploy(VerifTokenERC20);
};
