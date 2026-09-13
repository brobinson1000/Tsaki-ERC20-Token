pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Tsaki is ERC20 {
	constructor(uint256 initialSupply) ERC20("Tsaki", "TSKI") {
		_mint(msg.sender, initialSupply);
	}
}


