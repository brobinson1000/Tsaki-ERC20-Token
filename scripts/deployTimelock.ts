// Script to deploy time lock and governance actions

import { network } from "hardhat";

const { viem } = await network.connect();
const publicClient = await viem.getPublicClient();
const [deployer] = await viem.getWalletClients();
const deployerAddress = deployer.account.address;

// Waits for transaction to be mined
const wait = (hash: `0x${string}`) =>
  publicClient.waitForTransactionReceipt({ hash });

const tokenAddress = "0xINEEEDTOENETER" as `0x${string}`;

// Deploy the timelock 
const minDelay = 604800n; // Every transaction or change shall wait 7 days before effective
const proposers = [deployerAddress];
const executors = ["0x0000000000000000000000000000000000000000"]; // anyone can execute
const admin = deployerAddress;

const timelock = await viem.deployContract("TsakiTimelock", [
  minDelay,
  proposers,
  executors,
  admin,
]);
console.log("Timelock:", timelock.address);

// 2. Deploy the Governor needs token and time lock address
const governor = await viem.deployContract("TsakiGovernor", [
  tokenAddress,
  timelock.address,
]);
console.log("Governor:", governor.address);

// Give the Governor the proposer and canceller roles
const PROPOSER_ROLE = await timelock.read.PROPOSER_ROLE();
const CANCELLER_ROLE = await timelock.read.CANCELLER_ROLE();
const ADMIN_ROLE = await timelock.read.DEFAULT_ADMIN_ROLE();

await wait(await timelock.write.grantRole([PROPOSER_ROLE, governor.address]));
await wait(await timelock.write.grantRole([CANCELLER_ROLE, governor.address]));
console.log("Governor granted proposer + canceller");

// Remove powers once deployed successfully
await wait(await timelock.write.revokeRole([PROPOSER_ROLE, deployerAddress]));
await wait(await timelock.write.revokeRole([CANCELLER_ROLE, deployerAddress]));
await wait(await timelock.write.renounceRole([ADMIN_ROLE, deployerAddress]));
console.log("Deployer roles removed. Governance now controls the timelock.");
