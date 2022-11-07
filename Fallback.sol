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

  address payable owner;

  mapping (address => uint256) public balance;

  event Receive(uint gas);
  event Fallback(uint gas);

  constructor() payable {
        owner = payable(msg.sender);
    }

  function deposit() public payable {
    balance[msg.sender] = msg.value;
  }

  function checkBalance() public view returns (uint256){
    return (balance[msg.sender]);
  }

  fallback() external payable {
    emit Fallback(gasleft());
  }

  receive() external payable {
    emit Receive(gasleft());
  }

  

  
}
