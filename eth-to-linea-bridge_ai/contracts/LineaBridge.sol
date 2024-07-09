// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";

/**
 * @title LineaBridge
 * @dev Handles the receiving end of the token bridge on the Linea chain.
 */
contract LineaBridge {
    using SafeERC20 for IERC20;
    using Address for address;

    IERC20 public immutable token;
    address public bridgeOperator;

    event TokensMinted(address indexed user, uint256 amount);

    /**
     * @dev Constructor sets the token address and bridge operator.
     * @param _token Address of the ERC-20 token contract.
     * @param _bridgeOperator Address of the operator managing the bridge.
     */
    constructor(address _token, address _bridgeOperator) {
        require(_token.isContract(), "Provided address must be a contract.");
        require(_bridgeOperator != address(0), "Bridge operator address cannot be zero.");
        token = IERC20(_token);
        bridgeOperator = _bridgeOperator;
    }

    /**
     * @notice Mints tokens to a user's address on Linea.
     * @param amount Amount of tokens to mint.
     * @param user Address of the user receiving the tokens.
     */
    function mint(uint256 amount, address user) external {
        require(msg.sender == bridgeOperator, "Only the bridge operator can mint tokens.");
        require(amount > 0, "Amount must be greater than 0.");
        require(user != address(0), "User address cannot be zero.");

        // Mint or transfer tokens to the user's address
        // Note: The actual minting logic depends on whether the token is mintable or pre-minted and managed.
        token.safeTransfer(user, amount);
        emit TokensMinted(user, amount);
    }
}
