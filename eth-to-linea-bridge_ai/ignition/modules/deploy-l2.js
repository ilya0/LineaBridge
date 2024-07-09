async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const L2Bridge = await ethers.getContractFactory("L2Bridge");
    const l2Bridge = await L2Bridge.deploy();
    await l2Bridge.deployed();
    console.log("L2Bridge deployed to:", l2Bridge.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  