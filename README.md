<p align="center">
  <img src="assets/tsaki-logo.svg" alt="TSAKI logo" width="720" />
</p>

# TSAKI (TSAKI) ERC-20 Token

TSAKI is an ERC-20 token deployed on the Ethereum blockchain. I built it as a learning project to understand how cryptocurrencies work, how smart contracts are written and deployed, and how the ERC-20 standard behaves in practice.

> **Disclaimer:** TSAKI is an educational project. It has no promised value, is not an investment, and has not been professionally audited. Do not use this code in production or with real funds without a full security review.

---

## Table of Contents

- [Overview](#overview)
- [Token Details](#token-details)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Compile](#compile)
- [Test](#test)
- [Deploy](#deploy)
- [Interacting With the Contract](#interacting-with-the-contract)
- [What I Learned](#what-i-learned)
- [Security Notes](#security-notes)
- [License](#license)

---

## Overview

This project implements a fungible token that follows the [ERC-20 standard](https://eips.ethereum.org/EIPS/eip-20). The contract is written in Solidity, tested and deployed with TypeScript using Hardhat 3.

The token supports the standard ERC-20 functions:

- `totalSupply()`
- `balanceOf(address)`
- `transfer(address, uint256)`
- `approve(address, uint256)`
- `allowance(address, address)`
- `transferFrom(address, address, uint256)`

## Token Details

| Property         | Value                              |
| ---------------- | ---------------------------------- |
| Name             | TSAKI                              |
| Symbol           | TSAKI                              |
| Decimals         | 18                                 |
| Total Supply     | `YOUR_TOTAL_SUPPLY`                |
| Network          | Ethereum (`YOUR_NETWORK`)          |
| Contract Address | `0xYOUR_CONTRACT_ADDRESS`          |
| Etherscan        | [View contract](https://etherscan.io/address/0xYOUR_CONTRACT_ADDRESS) |

> Replace the placeholders above with your real values. If you deployed to a testnet such as Sepolia, use `https://sepolia.etherscan.io/address/...` instead.

## Tech Stack

- **Solidity**: smart contract language
- **TypeScript**: tests, scripts, and deployment modules
- **Hardhat 3**: development environment for compiling, testing, and deploying
- **OpenZeppelin Contracts**: audited ERC-20 base implementation (if used)
- **Node.js**: runtime

## Project Structure

```
.
├── contracts/          # Solidity smart contracts (TSAKI.sol)
├── test/               # TypeScript tests
├── ignition/
│   └── modules/        # Hardhat Ignition deployment modules
├── hardhat.config.ts   # Hardhat 3 configuration
├── package.json
└── README.md
```

> Adjust this tree to match your actual folders.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (use a version supported by Hardhat 3, 22 LTS or newer recommended)
- npm or pnpm
- A wallet with ETH for gas fees (testnet ETH if deploying to a testnet)
- An RPC provider URL (Alchemy, Infura, etc.)
- An Etherscan API key (optional, for contract verification)

### Installation

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
npm install
```

### Configuration

Hardhat 3 supports an encrypted keystore, so you don't need to put private keys in a plain `.env` file. Set your secrets like this:

```bash
npx hardhat keystore set SEPOLIA_RPC_URL
npx hardhat keystore set SEPOLIA_PRIVATE_KEY
npx hardhat keystore set ETHERSCAN_API_KEY
```

If you use a `.env` file instead, **never commit it**. Make sure `.env` is listed in `.gitignore`.

## Compile

```bash
npx hardhat build
```

## Test

```bash
npx hardhat test
```

## Deploy

Deploy locally to a simulated network:

```bash
npx hardhat ignition deploy ignition/modules/TSAKI.ts
```

Deploy to a live network (example: Sepolia):

```bash
npx hardhat ignition deploy ignition/modules/TSAKI.ts --network sepolia
```

Verify the contract on Etherscan:

```bash
npx hardhat verify --network sepolia 0xYOUR_CONTRACT_ADDRESS
```

> Add constructor arguments after the address if your contract takes any.

## Interacting With the Contract

### Add TSAKI to MetaMask

1. Open MetaMask and switch to the network where TSAKI is deployed.
2. Click **Import tokens**.
3. Paste the contract address: `0xYOUR_CONTRACT_ADDRESS`.
4. The symbol (`TSAKI`) and decimals (`18`) should fill in automatically.

### Using Etherscan

On the contract's Etherscan page, open the **Contract** tab, then use **Read Contract** to check balances and supply, and **Write Contract** (after connecting your wallet) to transfer or approve tokens.

## What I Learned

- How the ERC-20 standard defines a common interface for fungible tokens
- How balances, allowances, and transfers are tracked in contract storage
- How events like `Transfer` and `Approval` let wallets and explorers follow activity
- How to write, compile, and test Solidity contracts with Hardhat 3 and TypeScript
- How gas, deployment, and contract verification work on Ethereum
- Why security practices matter when handling private keys and writing contracts

## Security Notes

- This contract has **not** been audited.
- Never commit private keys, seed phrases, or API keys to the repository.
- Always test on a testnet before deploying to mainnet.
- Deployed smart contracts are generally immutable, so double-check everything before deploying.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Built to learn. Feedback and suggestions are welcome.
