import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
    solidity: {
        compilers:[
            {
                version: "0.8.7",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 200,
                    },
                },
            },
        ]
    },

    networks: {
        testnet: {
            url: "https://rpc-testnet.kcc.network",
            chainId: 322,
            accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],

        },
        mainnet: {
            url: "https://rpc-mainnet.kcc.network",
            chainId: 321,
            accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],

        },

        hardhat: {
            allowUnlimitedContractSize: true,
        },
    }
};

export default config;
