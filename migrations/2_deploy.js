// migrations/2_deploy.js
// SPDX-License-Identifier: MIT
const PayToken = artifacts.require("PayToken");
var BigNumber = require("big-number");
const { BN } = require("@openzeppelin/test-helpers");
module.exports = async function (deployer, network, accounts) {
  const decimals = "18";
  const initialSupply = new BN(new BN("5000000")).mul(
    new BN("10").pow(new BN(decimals))
  );
  const maxSupply = new BN(new BN("1000000000")).mul(
    new BN("10").pow(new BN(decimals))
  );

  console.log("initial supply ===>", initialSupply.toString());
  console.log("max supply ===>", maxSupply.toString());

  await deployer.deploy(
    PayToken,
    "100Pay Token",
    "$PAY",
    initialSupply.toString(),
    maxSupply.toString()
  );
  const token = await PayToken.deployed();

  let supply = await token.totalSupply();
  let cap = await token.cap();

  console.log("here is the total supply", supply.toString());
  console.log("here is the total supply", cap.toString());
};
