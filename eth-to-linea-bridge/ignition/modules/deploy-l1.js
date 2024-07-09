async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const Token = await ethers.getContractFactory("YourToken"); // Replace with your token contract
    const token = await Token.deploy();
    await token.deployed();
    console.log("Token deployed to:", token.address);
  
    const L1Bridge = await ethers.getContractFactory("L1Bridge");
    const l1Bridge = await L1Bridge.deploy(token.address);
    await l1Bridge.deployed();
    console.log("L1Bridge deployed to:", l1Bridge.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  