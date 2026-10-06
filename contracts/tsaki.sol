// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Nonces.sol";

contract Tsaki is ERC20, ERC20Permit, ERC20Votes, Ownable {
    uint256 public constant MINIMUM_TIME_BETWEEN_MINTS = 365 days;
    uint256 public constant MINT_CAP_BPS = 200; // 2% of supply, in basis points

    uint256 public mintingAllowedAfter;

    error MintTooSoon(uint256 allowedAfter);
    error MintCapExceeded(uint256 amount, uint256 maxAllowed);
    error MintingStartInPast();

    // owner = the timelock address (deploy the timelock first)
    constructor(
        uint256 initialSupply,
        address timelock,
        uint256 firstMintAfter
    ) ERC20("Tsaki", "TSKI") ERC20Permit("Tsaki") Ownable(timelock) {
        if (firstMintAfter < block.timestamp) revert MintingStartInPast();
        mintingAllowedAfter = firstMintAfter;
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        if (block.timestamp < mintingAllowedAfter) {
            revert MintTooSoon(mintingAllowedAfter);
        }
        mintingAllowedAfter = block.timestamp + MINIMUM_TIME_BETWEEN_MINTS;

        uint256 maxAllowed = (totalSupply() * MINT_CAP_BPS) / 10_000;
        if (amount > maxAllowed) revert MintCapExceeded(amount, maxAllowed);

        _mint(to, amount);
    }

    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Votes) {
        super._update(from, to, value);
    }

    function nonces(address owner) public view override(ERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }
}
