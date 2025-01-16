require("dotenv").config();
require("@matterlabs/hardhat-zksync-solc");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  zksolc: {
    version: "1.3.9",
    compilerSource: "binary",
    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  networks: {
    hardhat: {},
    sepolia: {
      url: "https://rpc.ankr.com/eth_sepolia",
      accounts: [process.env.PRIVATE_KEY],
    },
    zksync_testnet: {
      url: "https://testnet.era.zksync.dev",
      ethNetwork: "sepolia",
      chainId: 280,
      zksync: true,
    },
    zksync_mainnet: {
      url: "https://zksync2-mainnet.zksync.io/",
      ethNetwork: "mainnet",
      chainId: 324,
      zksync: true,
    },
  },
  paths: {
    artifacts: "./artifacts-zk",
    cache: "./cache-zk",
    sources: "./contracts",
    tests: "./test",
  },
  defaultNetwork: "sepolia",
  solidity: {
    version: "0.8.17",
    defaultNetwork: "sepolia",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
