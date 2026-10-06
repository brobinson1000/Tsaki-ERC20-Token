// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract Tsaki is ERC20Capped, Ownable {
    uint256 public constant MIN_BALANCE_FOR_BURN = 100 * 10**18;

    constructor(uint256 initialSupply)
        ERC20("Tsaki", "TSKI")
        ERC20Capped(1_000_000 * 10**18)
	Ownable(msg.sender) // Deploy -> becomes owner
    {
        _mint(msg.sender, initialSupply);
    }

   
   // Owner acessibility to mint new tokens 
    function mint(address to, uint256 amount) external onlyOwner {
	    _mint(to, amount);
    }

   // Owner acessibility to freeze all token activity if there is an exploit or bug
    function pause() external onlyOwner {
	    _pause();
    }

    function unpause() external onlyOwner {
	    _unpause();
    }

    function _update(address to, address from, uint256 value) {
	    internal
	    override(ERC20Capped, ERC20Pausible) 
	    {
		    super._update(to, from, value);
	    }

    }

	
   // Allows holder to burn 100 tokens / burns to dead wallet address
   error BalanceTooLow(uint256 balance, uint256 required);
   event HolderBurn(address indexed holder, uint256 amount);

    function holderBurn(uint256 amount) public {
	    uint256 balance = balanceOf(msg.sender);
	    
	    if (balance <= MIN_BALANCE_FOR_BURN) {
		revert BalanceTooLow(balance, MIN_BALANCE_FOR_BURN);
            }

	    _burn(msg.sender, amount);
	    emit HolderBurn(msg.sender, amount);
}	
