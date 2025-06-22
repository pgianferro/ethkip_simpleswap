// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

/// @title SimpleSwap
/// @author Pablo Gianferro
/// @notice ETHKIPU TP MODULE 3: A simplified implementation of a Uniswap-like liquidity pool for two ERC20 tokens.
/// @dev This contract handles tokenA and tokenB liquidity pools and manages internal LP tokens.
///      LP tokens are not ERC20-compatible but are tracked via internal mappings.

contract SimpleSwap {

    /// @notice owner Address of the provider of LP tokens (initialized by the contract)
    address public owner;

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
    owner = msg.sender;
}

    /// @notice Emitted when INITIAL liquidity is added to the pool
    /// @param provider Address of the liquidity provider
    /// @param amountA Amount of token A added
    /// @param amountB Amount of token B added
    /// @param liquidityMinted Amount of LP tokens minted
    event InitialLiquidityAdded(address indexed provider, uint256 amountA, uint256 amountB, uint256 liquidityMinted);


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

    /// @notice Adds liquidity to the pool and mints LP tokens
    /// @param tokenA_ address of tokenA
    /// @param tokenB_ address of tokenB
    /// @param amountADesired Amount of token A to add
    /// @param amountBDesired Amount of token B to add
    /// @param amountAMin Minimum accepted amount of token A
    /// @param amountBMin Minimum accepted amount of token B
    /// @param to Address to receive LP tokens
    /// @param deadline Transaction expiry timestamp
    /// @return amountA Final amount of token A added
    /// @return amountB Final amount of token B added
    /// @return liquidity Amount of LP tokens minted
    function addLiquidity(address tokenA_, address tokenB_, uint amountADesired, uint amountBDesired, uint amountAMin, uint amountBMin, address to, uint deadline) external returns (uint amountA, uint amountB, uint liquidity) {
        
 if (reserveA == 0 && reserveB == 0) {
        // Only the owner can make the first call
        require(msg.sender == owner, "Only owner can initialize");
        require(to == owner, "Initial LP must be assigned to owner");

        // Silence warnings for unused parameters in this branch
        tokenA; tokenB; amountADesired; amountBDesired; amountAMin; amountBMin; deadline;

        // Fixed amounts, amountDesired is not used
        amountA = 1000 * 1e18;
        amountB = 1000 * 1e18;
        liquidity = 1000 * 1e18;

        // Transfers
        IERC20(tokenA).transferFrom(owner, address(this), amountA);
        IERC20(tokenB).transferFrom(owner, address(this), amountB);

        // State
        reserveA = amountA;
        reserveB = amountB;
        _totalSupply = liquidity;
        _balanceOf[to] = liquidity;

        emit InitialLiquidityAdded(owner, amountA, amountB, liquidity);
        
        return (amountA, amountB, liquidity);

    } else {
        
        require(deadline > block.timestamp, "Transaction expired");
        
        //Read current reserves
        uint256 _reserveA = reserveA;
        uint256 _reserveB = reserveB;

        //Calculate de amount of B token that keeps the originals pool's proportions
        uint256 amountBOptimal = (amountADesired * _reserveB) / _reserveA;
        
        if (amountBOptimal <= amountBDesired) {
    require(amountBOptimal >= amountBMin, "insufficient B");
    amountA = amountADesired;
    amountB = amountBOptimal;
    } else {
    uint256 amountAOptimal = (amountBDesired * _reserveA) / _reserveB;
    require(amountAOptimal <= amountADesired, "too much A");
    require(amountAOptimal >= amountAMin, "not enough A");
    amountA = amountAOptimal;
    amountB = amountBDesired;
    }

    //Transfers the tokens to the contract
    require(tokenA_ == tokenA && tokenB_ == tokenB, "Invalid token pair");
    IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
    IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

    //Mint LP Tokens
    liquidity = Math.min(
    (amountA * _totalSupply) / _reserveA,
    (amountB * _totalSupply) / _reserveB
    );

    //State update
    reserveA +=amountA;
    reserveB +=amountB;
    _totalSupply += liquidity;
	_balanceOf[to] += liquidity;

    emit LiquidityAdded(msg.sender, amountA, amountB, liquidity);

    return (amountA, amountB, liquidity);

}


    }

    /// @notice Removes liquidity from the pool and burns LP tokens
    /// @param tokenA_ address of tokenA
    /// @param tokenB_ address of tokenB
    /// @param liquidity amount of LP tokens to burn
    /// @param amountAMin Minimum accepted amount of token A
    /// @param amountBMin Minimum accepted amount of token B
    /// @param to Address to receive tokens
    /// @param deadline Transaction expiry timestamp
    /// @return amountA Final amount of token A added
    /// @return amountB Final amount of token B added
    function removeLiquidity (address tokenA_, address tokenB_, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline) external returns (uint amountA, uint amountB) {

        require(deadline > block.timestamp, "Transaction expired");
        require(tokenA_ == tokenA && tokenB_ == tokenB, "Invalid token pair");

        //Calculates amount of token A and B to return to user
        amountA = (liquidity * reserveA) / _totalSupply;
        amountB = (liquidity * reserveB) / _totalSupply;

        require(amountA >= amountAMin, "amountA below minimum");
        require(amountB >= amountBMin, "amountB below minimum");
        require(_balanceOf[msg.sender] >= liquidity, "Insufficient LP balance");
        require(reserveA >= amountA && reserveB >= amountB, "Insufficient reserves");

        //Burns the LP tokens equivalent to the liquidity param from user
        _balanceOf[msg.sender] -=liquidity;
        _totalSupply -=liquidity;

        //Transfers the tokens to user

        IERC20(tokenA).transfer(to, amountA);
        IERC20(tokenB).transfer(to, amountB);

        //State
        reserveA -= amountA;
        reserveB -= amountB;

       emit LiquidityRemoved(msg.sender, amountA, amountB, liquidity);

       return (amountA, amountB);

    }

    /// @notice Exchanges one token for another in the exact amount.
    /// @param amountIn Amount of input tokens.
    /// @param amountOutMin: Minimum acceptable number of output tokens.
    /// @param path: Array of token addresses. (input token, output token)
    /// param to: Recipient address.
    /// @param deadline: Timestamp for the transaction.
    /// @param amounts: Array with input and output amounts.
    function swapExactTokensForTokens(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external returns (uint[] memory amounts) {
        
        require(deadline > block.timestamp, "Transaction expired");
        require(path.length == 2 && path[0] != path[1], "invalid pair of tokens");
        require( (path[0] == tokenA && path[1] == tokenB) || (path[0] == tokenB && path[1] == tokenA), "invalid token pair");
        require(amountIn > 0, "insufficient amountIn");

        uint256 amountOut;

        if (path[0] == tokenA) {
            IERC20(tokenA).transferFrom(msg.sender, address(this), amountIn);
            amountOut = (amountIn * reserveB) / (reserveA + amountIn);
            require(amountOut >= amountOutMin, "insuficient amountOut");
            IERC20(tokenB).transfer(to, amountOut);
            reserveA += amountIn;
            reserveB -= amountOut;

        } else {
            
            IERC20(tokenB).transferFrom(msg.sender, address(this), amountIn);
            amountOut = (amountIn * reserveA) / (reserveB + amountIn);
            require(amountOut >= amountOutMin, "insuficient amountOut");
            IERC20(tokenA).transfer(to, amountOut); 
            reserveA += amountIn;
            reserveB -= amountOut;
            
        }
        
        amounts = new uint[](2) ;
        amounts[0] = amountIn;
        amounts[1] = amountOut;

        emit TokensSwapped(msg.sender, path[0], amountIn, path[1], amountOut);

        return amounts;


    }
}