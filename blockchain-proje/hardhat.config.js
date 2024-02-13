require("@nomiclabs/hardhat-waffle");

const PRIVATE_KEY = "38508a1d6ab816253b81c56717de36779c83e6a5bfba48b212bfa13be2aaa23d";

module.exports = {
    solidity: "0.8.20",
    networks: {

      hardhat: {
        forking: {
          url: "https://eth-mainnet.g.alchemy.com/v2/qFcq7W9VBNvNP6QlMjtoiepmPfx_rBqk",
          
        }
      },

      mainnet: {
        url: `https://api.avax.network/ext/bc/C/rpc`,
          accounts: [`${PRIVATE_KEY}`]
      },
      fuji: {
        url: `https://api.avax-test.network/ext/bc/C/rpc`,
          accounts: [`${PRIVATE_KEY}`]
      }
    }
};