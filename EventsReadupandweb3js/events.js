const Web3 = require('web3');
const web3 = new Web3('https://infura.io/your-infura-api-key');

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