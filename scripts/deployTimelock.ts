import { network } from "hardhat"

const { viem } = await network.connect();
const [ deployer ] = await view.getWalletClients();

const minDelay = 604800; // Min delay of 7 days
const proposers = [deployer.account.address]; // TODO: add governance
const executors = ["0x0000000000000000000000000000000000000000"]; // anyone
const admin = deployer.account.address;

const timelock = await view.deployContract("TsakiTimelock", [
	minDelay,
	proposers,
	executors,
	admin,
]);

console.log("Timelock deployed to: ", timelock.address);
