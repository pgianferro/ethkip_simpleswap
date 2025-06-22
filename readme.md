# SimpleSwap Smart Contract

This repository contains the Solidity implementation of `SimpleSwap`, a simplified decentralized exchange (DEX) for swapping between two ERC20 tokens, inspired by Uniswap's liquidity pool logic.

## 🧠 Contract Overview

`SimpleSwap` allows users to:
- Add liquidity to a token pair and receive LP tokens.
- Remove liquidity and redeem their share of the pool.
- Swap one token for another.
- Get the price of a token in terms of another.
- Calculate how many tokens they would receive for a given input amount.


## 🧱 Core Functionalities

| Function | Description |
|---------|-------------|
| `addLiquidity(...)` | Add tokens to the pool and receive LP tokens. |
| `removeLiquidity(...)` | Remove liquidity and receive tokens A and B. |
| `swapExactTokensForTokens(...)` | Swap a specific amount of token A for token B or vice versa. |
| `getPrice(...)` | Get the price of tokenA in terms of tokenB (based on reserves). |
| `getAmountOut(...)` | Pure function to estimate output amount for a given input. |


## 🔧 Technologies

- Solidity ^0.8.0
- OpenZeppelin (IERC20 interface and Math utilities)
- Metamask + Remix (for deployment)


## 📂 Structure

- `SimpleSwap.sol`: The main contract file with inline documentation.
- `README.md`: This file.


## 🚀 Deployment & Verification

The `SimpleSwap` contract was successfully deployed to the **Ethereum Sepolia testnet** using **Remix IDE** and **MetaMask**.

- **Contract Address:** [`0x098A34D8c5Ba4B6737E8fDa9c498C6170184a51C`](https://sepolia.etherscan.io/address/0x098A34D8c5Ba4B6737E8fDa9c498C6170184a51C)
- **Deployed with:** EVM version `prague`
- **Token A (M10):** [`0x7d0EC05eBA3e804c1Be44496fE8Ce40EAD2EAC85`](https://sepolia.etherscan.io/address/0x7d0EC05eBA3e804c1Be44496fE8Ce40EAD2EAC85)
- **Token B (CR7):** [`0x3097ba96c610b257FB87615d8602F306ba196703`](https://sepolia.etherscan.io/address/0x3097ba96c610b257FB87615d8602F306ba196703)

✅ The contract is ready for source code verification using tools like **Remix**, **Etherscan**, or **Sourcify**.

## 📝 License

MIT License.