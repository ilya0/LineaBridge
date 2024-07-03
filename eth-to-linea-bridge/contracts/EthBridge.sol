// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {ILineaBridge} from "@linea-bridge/contracts/ILineaBridge.sol";

/**
 * @title EthToLineaBridge
 * @dev Bridges ERC-20 tokens from Ethereum to Linea.
 */
contract EthToLineaBridge {
    using SafeERC20 for IERC20;
    using Address for address;

    IERC20 public immutable token;
    ILineaBridge public immutable lineaBridge;

    /**
     * @dev Constructor sets the token and Linea bridge addresses.
     * @param _token Address of the ERC-20 token contract.
     * @param _lineaBridge Address of the Linea bridge contract.
     */
    constructor(address _token, address _lineaBridge) {
        require(_token.isContract(), "Provided address must be a contract.");
        require(_lineaBridge.isContract(), "Provided address must be a contract.");
        token = IERC20(_token);
        lineaBridge = ILineaBridge(_lineaBridge);
    }

    /**
     * @notice Bridges tokens from Ethereum to Linea.
     * @param amount Amount of tokens to bridge.
     */
    function bridgeToLinea(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0.");
        token.safeTransferFrom(msg.sender, address(this), amount);
        token.approve(address(lineaBridge), amount);
        lineaBridge.deposit(amount, msg.sender);
    }
}
