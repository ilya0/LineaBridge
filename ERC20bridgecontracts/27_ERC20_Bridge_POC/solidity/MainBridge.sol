// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//this is a contract for the for the main bridge 

//Remix style import
import { IERC20 } from "@openzeppelin/contracts@4.0.0/token/ERC20/IERC20.sol";

//Brownie style import
//import { IERC20 } from "OpenZeppelin/openzeppelin-contracts@4.0.0/contracts/token/ERC20/IERC20.sol";


contract MainBridge {

    IERC20 private mainToken;

    address gateway; //main token address

    event TokensLocked(address indexed requester, bytes32 indexed mainDepositHash, uint amount, uint timestamp);
    event TokensUnlocked(address indexed requester, bytes32 indexed sideDepositHash, uint amount, uint timestamp);

    constructor (address _mainToken, address _gateway) {
        mainToken = IERC20(_mainToken); // address of the main token
        gateway = _gateway; //main token address that you control and have the private keys
    }
// this is to lock the tokens and then emit and event
    function lockTokens (address _requester, uint _bridgedAmount, bytes32 _mainDepositHash) onlyGateway external {
        // requestor is the person creating the request to bridge the tokens
        //bridged amount is the amount of tokens on the bridge 
    
        emit TokensLocked(_requester, _mainDepositHash, _bridgedAmount, block.timestamp);
        //emit and event to show the tokens have been locked

    }
// this is to unlock the tokens when they are coming back from the sidechain 
    function unlockTokens (address _requester, uint _bridgedAmount, bytes32 _sideDepositHash) onlyGateway external {
        mainToken.transfer(_requester, _bridgedAmount);
        emit TokensUnlocked(_requester, _sideDepositHash, _bridgedAmount, block.timestamp); //emit and event when the tokens have been unlocked

    }

    modifier onlyGateway {
      require(msg.sender == gateway, "only gateway can execute this function");
      _;
    }
    

}
