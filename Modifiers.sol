pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  //original code
  /*
  event SetPurpose(address sender, string purpose);

  string public purpose = "Building Unstoppable Apps!!!";

  constructor() payable {
    // what should we do on deploy?
  }

  function setPurpose(string memory newPurpose) public {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      emit SetPurpose(msg.sender, purpose);
  }

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}

  */
   struct User {
      string name;
      uint256 age;
  }
  
  mapping (address => uint256) public balance;
  mapping (address => User) public userDetail;

  address public owner;

  uint256 private fee = 2;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
      require(msg.sender == owner, "Not owner");
     _;
  }

  modifier zeroBalance() {
      require(balance[msg.sender] > 0, "Balance is zero");
     _;
  }

  modifier validValue(uint256 _amount) {
      require(_amount > fee, "Amount to small");
     _;
  }

  function withdraw() public onlyOwner {
    balance[msg.sender] = 0;
  }

  function addFund(uint256 _amount) public onlyOwner zeroBalance validValue(_amount){
    uint256 _newAmount = balance[msg.sender] + _amount;
    deposit(_newAmount);    
  }

  function setUserDetails(string calldata _name, uint256 _age) public {
      userDetail[msg.sender] = User(_name, _age);
  }

  function getUserDetail() public view returns(string memory _name, uint256 _age){
      User memory myUser;
      myUser = userDetail[msg.sender];
      return (myUser.name, myUser.age);
  }

  function deposit (uint256 _amount) public {
    balance[msg.sender] = _amount;
  }

  function checkBalance() public view returns (uint256){
    return (balance[msg.sender]);
  }
    
  
}
