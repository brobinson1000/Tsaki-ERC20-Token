

import { network } from "hardhat";

const connection = await network.connect({
  network: "sepolia",
});
const { ethers } = connection;

async function main() {
	const [deployer] = await ethers.getSigners();
	console.log("Deploying with account:", deployer.address);
	
	// caclulating initial supply
	// 18 is decimal places so tokens minted = 1000000 * 10^18
	const initialSupply = ethers.parseUnits("1000000", 18);

	// Factoy a template on how each contract should be created
	// Automated machine that uses template to build new contracts
	// Contract states:
	// * exacty supply of token
	// * Who owns token
	// * identity of token to be recognized by block chain
	const Tsaki = await ethers.getContractFactory("Tsaki");


	// Creates transaction with contract + initialSupply
	// Signs with deployer account
	// Broadcast to network
	const tsaki = await Tsaki.deploy(initialSupply);

	// Wait for transaction to be validated and included  in a block  by a validator
	// Validator are people or staking groups with aleast 32 eth as a security deposit and validate blocks


	await tsaki.waitForDeployment();
	
	// logs every contracts adress when deployed
	console.log("Tsaki deployed to:", await tsaki.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
	

	
