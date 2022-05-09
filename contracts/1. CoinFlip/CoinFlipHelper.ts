import { expect } from "chai";
import { ethers } from "hardhat";

const helper = async (victim: any, attacker: any) => {
  // add code here that will help you pass the test
  let consecutiveWins = await victim.consecutiveWins();
  while (consecutiveWins < 10) {
    await attacker.hackContract();
    consecutiveWins = await victim.consecutiveWins();
  }
};

export default helper;
