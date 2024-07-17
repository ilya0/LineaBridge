// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { IERC20Child } from "./IERC20Child.sol";

contract SideBridge {

    event BridgeInitialized(uint indexed timestamp);
    event TokensBridged(address indexed requester, bytes32 indexed mainDepositHash, uint amount, uint timestamp);
    event TokensReturned(address indexed requester, bytes32 indexed sideDepositHash, uint amount, uint timestamp);
    
    IERC20Child private sideToken;
    bool bridgeInitState;
    address owner;
    address gateway;


    constructor (address _gateway) {
        gateway = _gateway;
        owner = msg.sender;
    }
// this is created so that when the contracts are deployed, the child token doesn't have to be initialized, 
// when the contracts are deployed, intiializedBridge an then be triggered and the child token set
    function initializeBridge (address _childTokenAddress) onlyOwner external {
        sideToken = IERC20Child(_childTokenAddress);
        bridgeInitState = true;
    }
// Minting function to mint tokens on the side bridge in the amount of the requestor, can only be triggered by the gateway  (onlyGateway function)
    function bridgeTokens (address _requester, uint _bridgedAmount, bytes32 _mainDepositHash) verifyInitialization onlyGateway  external {
        sideToken.mint(_requester,_bridgedAmount);
        emit TokensBridged(_requester, _mainDepositHash, _bridgedAmount, block.timestamp);
    }
// this is returning the tokens to the main net, burning the tokens, triggered by the gateway, when tokens are transfered to bridge on this side
    function returnTokens (address _requester, uint _bridgedAmount, bytes32 _sideDepositHash) verifyInitialization onlyGateway external {
        sideToken.burn(_bridgedAmount);

        //emiting a TokensReturned signal, with the specific params
        emit TokensReturned(_requester, _sideDepositHash, _bridgedAmount, block.timestamp);
    }

    modifier verifyInitialization {
      require(bridgeInitState, "Bridge has not been initialized");
      _;
    }
    
    modifier onlyGateway {
      require(msg.sender == gateway, "Only gateway can execute this function");
      _;
    }

    modifier onlyOwner {
      require(msg.sender == owner, "Only owner can execute this function");
      _;
    }
    

}