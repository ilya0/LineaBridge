import fetch from 'node-fetch';

fetch("https://mainnet.infura.io.infura.io/v3/a113ee9e65f64c6793fb93a3cea731ab", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify({
    jsonrpc: "2.0",
    method: "eth_blockNumber",
    params: [],
    id: 1
  })
})
.then(response =>
  response.json()
)
.then(data => {
  console.log(data);
})
.catch(error => {
  console.error(error);
});