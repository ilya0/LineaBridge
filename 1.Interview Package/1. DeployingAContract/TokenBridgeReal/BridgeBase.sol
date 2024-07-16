// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {ERC20} from "./ERC20/ERC20.sol";

interface IToken {
function mint(address to, uint amount) external;
function burn(address owner, uint amount) external;
function transfer(address to, uint256 value) external returns (bool);
}


contract Token is ERC20 {
   constructor(string memory name, string memory symbol) ERC20(name, symbol) {}
    function mint(address to, uint amount) external {
        _mint(to, amount);
    }
    function burn(address owner, uint amount) external {
       _burn(owner, amount);
    }
}

// this contract receives the token to be bridge and burns once complete
contract BridgeSepolia {
    IToken public token;

    constructor(address _token) {
        token = IToken(_token);
    }

    // this will burn the origin token after bridge 
    function burn(address from, uint256 amount) external {
        token.burn(from, amount);
    }
}

// this hands out equivalent bridged token
contract BridgeLineaSepolia {
    IToken public token;

    constructor(address _token) {
        token = IToken(_token);
    }

    // this will transfer token over via bridge
    function transfer(address to, uint256 amount) external {
        token.transfer(to, amount);
    }
}