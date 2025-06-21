// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title SimpleSwap
/// @author Pablo Gianferro
/// @notice ETHKIPU TP MODULE 3: A simplified implementation of a Uniswap-like liquidity pool for two ERC20 tokens.
/// @dev This contract handles tokenA and tokenB liquidity pools and manages internal LP tokens.
///      LP tokens are not ERC20-compatible but are tracked via internal mappings.

contract SimpleSwap {

    /// @notice Name of the liquidity token (LP token)
    string internal _name;

    /// @notice Symbol of the liquidity token (LP token)
    string internal _symbol;

    /// @notice Decimals used for the LP token (default is 18)
    uint8 internal _decimals;

    /// @notice Address of token A
    address public tokenA;

    /// @notice Address of token B
    address public tokenB;

    /// @notice Current reserve of token A held by the pool
    uint256 public reserveA;

    /// @notice Current reserve of token B held by the pool
    uint256 public reserveB;

    /// @notice Total supply of LP tokens minted
    uint256 internal _totalSupply;

    /// @notice Mapping of LP token balances per user
    mapping(address => uint256) internal _balanceOf;

    /// @notice Initializes the contract with the two token addresses
    /// @param _tokenA Address of token A
    /// @param _tokenB Address of token B
constructor(address _tokenA, address _tokenB) {
    tokenA = _tokenA;
    tokenB = _tokenB;
    _name = "SimpleSwap LP Token";
    _symbol = "SSLP";
    _decimals = 18;
}

    /// @notice Emitted when liquidity is added to the pool
    /// @param provider Address of the liquidity provider
    /// @param amountA Amount of token A added
    /// @param amountB Amount of token B added
    /// @param liquidityMinted Amount of LP tokens minted
    event LiquidityAdded(address indexed provider, uint256 amountA, uint256 amountB, uint256 liquidityMinted);

    /// @notice Emitted when liquidity is removed from the pool
    /// @param provider Address of the liquidity provider
    /// @param amountA Amount of token A returned
    /// @param amountB Amount of token B returned
    /// @param liquidityBurned Amount of LP tokens burned
    event LiquidityRemoved(address indexed provider, uint256 amountA, uint256 amountB, uint256 liquidityBurned);

    /// @notice Emitted when a token swap is performed
    /// @param swapper Address performing the swap
    /// @param tokenIn Address of the token sent in
    /// @param amountIn Amount of token sent
    /// @param tokenOut Address of the token received
    /// @param amountOut Amount of token received
    event TokensSwapped(address indexed swapper, address tokenIn, uint256 amountIn, address tokenOut, uint256 amountOut);


    /// @notice Returns the name of the LP token
    function name() external view returns (string memory) {
        return _name;
    }

    /// @notice Returns the symbol of the LP token
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /// @notice Returns the number of decimals used for the LP token
    function decimals() external view returns (uint8) {
        return _decimals;
    }

}