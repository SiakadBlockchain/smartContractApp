import { defineConfig } from "hardhat/config";
import dotenv from "dotenv";

dotenv.config();

export default defineConfig({
  solidity: {
    version: "0.8.28",
  },
  networks: {
    siakad: {
      type: "http",
      url: "http://127.0.0.1:9654/ext/bc/LtfgTv2tY6f3PUefYWjEaUXcqBr93wT5YYLDPD1EtZzdjP98L/rpc",
      chainId: 62001,
      accounts: [process.env.PRIVATE_KEY!],
    },
  },
});