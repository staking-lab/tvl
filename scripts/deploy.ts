import { ethers } from "hardhat";

async function main() {
    // Hardhat always runs the compile task when running scripts with its command
    // line interface.
    //
    // If this script is run directly using `node` you may want to call compile
    // manually to make sure everything is compiled
    // await hre.run('compile');
    const [singer] = await ethers.getSigners();
    console.log(`admin of sKCSTVL: `, singer.address);

    // deploy process redemption
    console.log(`ready to deploy sKCSTVL contract...`);
    const sKCSTVL = await ethers.getContractFactory("sKCSTVL");
    const tvl = await sKCSTVL.deploy();

    console.log(`sKCSTVL address: ${tvl.address}`);

    /*
    * Compiled 2 Solidity files successfully
    admin of sKCSTVL:  0x1C0E983A3853658f5b5Aa46d9772EF929AE64B90
    ready to deploy sKCSTVL contract...
    sKCSTVL address: 0x3CEF6d63C299938083D0c89C812d9C6985e3Af1c

* */

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
