import { ethers } from "ethers";
import hre from "hardhat";
import * as dotenv from "dotenv";

dotenv.config();

async function main() {
  const RPC_URL = process.env.RPC_URL;
  
  const provider = new ethers.JsonRpcProvider(RPC_URL);

  if (!process.env.PRIVATE_KEY) {
    throw new Error("PRIVATE_KEY tidak ditemukan di file .env");
  }

  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  console.log("Deploying contract with account:", wallet.address);

  const artifact = await hre.artifacts.readArtifact("DiplomaStorage");

  const factory = new ethers.ContractFactory(
    artifact.abi,
    artifact.bytecode,
    wallet
  );

  console.log("Deploying DiplomaStorage...");

  const contract = await factory.deploy();
  await contract.waitForDeployment();

  const contractAddress = await contract.getAddress();

  console.log("-----------------------------------------------");
  console.log("DiplomaStorage deployed!");
  console.log("Contract Address  :", contractAddress);
  console.log("Network RPC       :", RPC_URL);
  console.log("Deployer          :", wallet.address);
  console.log("-----------------------------------------------");

}

main().catch((error) => {
  console.error("Error : ", error);
  process.exitCode = 1;
});