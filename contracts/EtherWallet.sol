// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EtherWallet {

    address payable public  owner;

    constructor () {
        owner = payable(msg.sender);
    }

    receive() external payable{}

    modifier onlyOwner {
        require(msg.sender == owner, "Cannot send Ether");
        _;
    }

    function withdraw(uint _amount) external onlyOwner{
        (bool success, ) = owner.call{value: _amount}("");
        require (success, "Failed to send Ether");
    }

    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}