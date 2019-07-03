var DegreeVerification = artifacts.require("DegreeVerification.sol");

contract('DegreeVerification', function(accounts){
  var degreeInstance;

  it('initializes the contract with the correct values', function(){
    return DegreeVerification.deployed().then(function(instance){
      degreeInstance = instance;
      return degreeInstance.owner();
    }).then(function(owner) {
      assert.equal(owner, accounts[0], 'owner is correct');
    });
  })
})
