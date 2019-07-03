pragma solidity ^0.5.0;

import "./IERC20.sol";

contract DegreeVerification {

  address payable public owner;

  struct Degree{
    string name;
    string surname;
    string grade;
    bool isValue;
  }

  mapping(string => Degree) degrees;

  event DegreeExists(string afm, bool exists);

  event DegreeDetails(string afm, string name, string surname, string grade);

  event DegreeAdded(string afm, bool added);

  constructor() public{
    owner = msg.sender;
  }

  function addDegree(string memory _afm ,string memory _name, string memory _surname, string memory _grade, address _tokenAddress) public returns(bool){
    require(queryERC20Balance(_tokenAddress) != 0, "To add a Degree you have to own UniToken!");
    degrees[_afm] = Degree(_name, _surname, _grade, true);
    emit DegreeAdded(_afm, true);
  }

  function checkIfDegreeExists(string memory _afm, address _tokenAddress) public{
    require(getERC20Allowance(_tokenAddress) >= 5, "You have to allowed at least 5 VT!");
    sendERC20(_tokenAddress, 5);
    if(degrees[_afm].isValue)
        emit DegreeExists(_afm, true);
    else
        emit DegreeExists(_afm, false);

  }

  function getDegreeDetails(string memory _afm, address _tokenAddress) public{
    require(getERC20Allowance(_tokenAddress) >= 10, "You have to allowed at least 10 VT!");
    sendERC20(_tokenAddress, 10);
    if(degrees[_afm].isValue){
        Degree memory degree = degrees[_afm];
        emit DegreeDetails(_afm, degree.name, degree.surname, degree.grade);
    }else{
        emit DegreeExists(_afm, false);
    }
  }

  function queryERC20Balance(address _tokenAddress) view internal returns (uint) {
    return IERC20(_tokenAddress).balanceOf(msg.sender);
  }

  function sendERC20(address _tokenAddress, uint256 _value) internal returns (bool){
    IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _value);
    return true;
  }

  function getERC20Allowance(address _tokenAddress) view internal returns (uint256){
      return IERC20(_tokenAddress).allowance(msg.sender, address(this));
  }

}
