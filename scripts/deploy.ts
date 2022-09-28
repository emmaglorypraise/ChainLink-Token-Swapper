import { ethers } from "hardhat";

async function main() {
  // - use chainlink price feed
  // - impersonate user with subscription and chainlink
  // - swap token

  // ----------------- DEPLOY SCRIPT HERE ----------------------

  // const ChainLinkSwap = await ethers.getContractFactory("Swap");
  // const chainlinkswap = await ChainLinkSwap.deploy();

  // await chainlinkswap.deployed();

  // console.log("My ChainLinkSwap contract deployed at:", chainlinkswap.address);

  // ----------------- INTERACTED WITH CONTRACT  HERE ----------------------

  const CONTRACT_ADDRESS = "0xBEe6FFc1E8627F51CcDF0b4399a1e1abc5165f15";
  const MyDeployedChainLinkSwapContract = await ethers.getContractAt("ISwap", CONTRACT_ADDRESS );
  await MyDeployedChainLinkSwapContract.getLatestPrice()

  // ----------------- IMPERSONATING ACCOUNT ----------------------

  // const helpers = require("@nomicfoundation/hardhat-network-helpers");
  // const LinkHolder = "0x580abef96406bfbaed57d5380a90c1e56b347c2e";
  // await helpers.impersonateAccount(LinkHolder);
  // const impersonatedSigner = await ethers.getSigner(LinkHolder);


}

//Link be4   149376718595560
//USD       500002764750

//Link after 149376716590810
//USD       500004764750

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});