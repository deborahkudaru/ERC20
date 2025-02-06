import { expect } from "chai";
import { ethers } from "hardhat";

describe("TokenSavings", function () {
  let TokenSavings: any, tokenSavings: any, owner: any, addr1: any;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    TokenSavings = await ethers.getContractFactory("TokenSavings");
    tokenSavings = await TokenSavings.deploy(ethers.parseEther("1000000"));
  });

  it("Should deploy with the correct initial supply", async function () {
    const ownerBalance = await tokenSavings.balanceOf(owner.address);
    expect(await tokenSavings.totalSupply()).to.equal(ownerBalance);
  });

  it("Should allow users to save tokens", async function () {
    await tokenSavings.saveTokens(ethers.parseEther("500"));
    const savedBalance = await tokenSavings.savedBalance(owner.address);
    expect(savedBalance).to.equal(ethers.parseEther("500"));
  });

  it("Should allow users to withdraw saved tokens", async function () {
    await tokenSavings.saveTokens(ethers.parseEther("500"));
    await tokenSavings.withdrawTokens(ethers.parseEther("300"));
    const savedBalance = await tokenSavings.savedBalance(owner.address);
    const ownerBalance = await tokenSavings.balanceOf(owner.address);
    expect(savedBalance).to.equal(ethers.parseEther("200"));
    expect(ownerBalance).to.equal(ethers.parseEther("999700"));
  });

  it("Should fail if user tries to withdraw more than saved", async function () {
    await tokenSavings.saveTokens(ethers.parseEther("500"));
    await expect(
      tokenSavings.withdrawTokens(ethers.parseEther("600"))
    ).to.be.revertedWith("Insufficient saved balance");
  });
});