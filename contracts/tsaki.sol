// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Pausable.sol";

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
	    _mint(to, amount)
    }


    function holderBurn(uint256 amount) public {
        require(
            balanceOf(msg.sender) > MIN_BALANCE_FOR_BURN,
            "Balance must be above 100 tokens"
        );
        _burn(msg.sender, amount);
    }
}
