import { ethers } from "ethers";
import hre from "hardhat";

async function main() {
  const provider = new ethers.JsonRpcProvider(
    "http://127.0.0.1:9654/ext/bc/LtfgTv2tY6f3PUefYWjEaUXcqBr93wT5YYLDPD1EtZzdjP98L/rpc"
  );

  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!, provider);

  const artifact = await hre.artifacts.readArtifact("IjazahStorage");

  const factory = new ethers.ContractFactory(
    artifact.abi,
    artifact.bytecode,
    wallet
  );

  const contract = await factory.deploy();

  await contract.waitForDeployment();

  console.log("Contract deployed to:", await contract.getAddress());
}

main().catch(console.error);