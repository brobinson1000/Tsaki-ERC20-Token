pragma solidity ^0.8.20;
//
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol"; 

contract Tsaki is ERC20 {

	uint256 public constant MIN_BALANCE_FOR_BURN = 100 * 10**18;

	constructor(uint256 initialSupply) 
	ERC20("Tsaki", "TSKI")
        ERC20Capped(1000000 * 10**18) // 1000000 TSKI token capp	
	{
		_mint(msg.sender, initialSupply);
	}

	// Implement an address to burn via min balance
	function holderBurn(uint256 amount) public {
		require(balanceOf(msg.sender) > MIN_BALANCE_FOR_BURN, "Balance must be strictly above 100 tokens");
		_burn(msg.sender, amount);
	}

	// Overide Parent Object
	function _update(address from, address to, uint256 value) 
		internal
		override(ERC20, ERC20Capped)
	{
		super._update(from, to, value);
	}



}


