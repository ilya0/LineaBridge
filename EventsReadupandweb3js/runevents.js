const Web3 = require('web3');
const web3 = new Web3("https://mainnet.infura.io.infura.io/v3/a113ee9e65f64c6793fb93a3cea731ab");

const contractAddress = '0xYourContractAddress';
const contractABI = [/* Your contract's ABI */];
const contract = new web3.eth.Contract(contractABI, contractAddress);

contract.getPastEvents('ItemPurchased', {
    fromBlock: 0,
    toBlock: 'latest'
})
.then((events) => {
    // Handle the retrieved events
});