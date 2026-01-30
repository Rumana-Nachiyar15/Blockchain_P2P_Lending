require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();  // Load environment variables from .env file

module.exports = {
  solidity: {
    version: "0.8.28",  // Match with the contract's pragma version
  },
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}`,
      accounts: [process.env.PRIVATE_KEY],  // Use the private key from .env
    },
  },
};
