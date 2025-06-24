# 💧 SimpleSwap Smart Contract

`SimpleSwap` is a Solidity smart contract implementing a simplified decentralized exchange (DEX) inspired by Uniswap. It allows ERC20 token swaps, liquidity provision, and on-chain price queries.

---

## 🧠 Overview

This contract supports:

- Adding liquidity to a pool of two ERC20 tokens.
- Removing liquidity and redeeming the underlying assets.
- Swapping one token for another using an automated market-making formula.
- Retrieving current token prices based on reserves.
- Issuing internal LP (liquidity provider) tokens (non-ERC20 compliant).

---

## 📘 Front-End Integration Guide

| Function | Type | Description |
|---------|------|-------------|
| `addLiquidity(...)` | External | Adds liquidity to the pool and mints LP tokens. Requires prior `approve()` on tokenA and tokenB. |
| `removeLiquidity(...)` | External | Burns LP tokens and sends back corresponding tokenA and tokenB. |
| `swapExactTokensForTokens(...)` | External | Swaps a fixed amount of tokenA for tokenB or vice versa. |
| `getPrice(tokenA, tokenB)` | View | Returns the current exchange rate between tokenA and tokenB. |
| `getAmountOut(amountIn, reserveIn, reserveOut)` | Pure | Estimates the output amount for a given input amount and reserves. |
| `name()` / `symbol()` / `decimals()` | View | Returns metadata for the LP token. |
| `reserveA` / `reserveB` / `tokenA` / `tokenB` | Public | Pool configuration and current reserves. |
| `balanceOf(address)` | View | Returns the LP token balance of a given address. |
| `totalSupply()` | View | Total supply of LP tokens. |

---

## 📂 Repository Structure

- `SimpleSwap.sol`: The main smart contract implementation.
- `README.md`: This documentation.
- `tokens/`: (Optional) Example ERC20 tokens used for testing.

---

## 🛠️ Technologies Used

- Solidity `^0.8.0`
- OpenZeppelin:
  - `IERC20.sol`
  - `Math.sol`
- Remix + MetaMask (deployment/testing)
- Etherscan & Sourcify (source code verification)

---

## 🚀 Deployment Details

The contract was deployed on **Ethereum Sepolia Testnet** using Remix and MetaMask.

| Component | Address |
|----------|---------|
| 📄 SimpleSwap Contract | [`0x098A34D8c5Ba4B6737E8fDa9c498C6170184a51C`](https://sepolia.etherscan.io/address/0x098A34D8c5Ba4B6737E8fDa9c498C6170184a51C) |
| 🟦 Token A (M10) | [`0x7d0EC05eBA3e804c1Be44496fE8Ce40EAD2EAC85`](https://sepolia.etherscan.io/address/0x7d0EC05eBA3e804c1Be44496fE8Ce40EAD2EAC85) |
| 🟥 Token B (CR7) | [`0x3097ba96c610b257FB87615d8602F306ba196703`](https://sepolia.etherscan.io/address/0x3097ba96c610b257FB87615d8602F306ba196703) |
| 🔎 EVM Version | `prague` |

> ✅ The contract can be verified using [Etherscan](https://sepolia.etherscan.io/) or [Sourcify](https://sourcify.dev/) with the correct compiler settings (Solidity v0.8.x, with or without optimization).

---

## 🧪 Usage Guide

1. **Initialize Pool:** Only the owner can call `addLiquidity()` the first time to initialize the pool. Requires `approve()` on both tokens.
2. **Add Liquidity:** Users call `addLiquidity(...)` with desired amounts.
3. **Swap Tokens:** Use `swapExactTokensForTokens(...)` with a valid token pair.
4. **Price Query:** Call `getPrice(tokenA, tokenB)` to get the current exchange rate.
5. **Remove Liquidity:** Call `removeLiquidity(...)` to withdraw tokens and burn LP tokens.

---

## ✅ Testing & Verification Checklist

- [x] Proper pool initialization with permission checks.
- [x] Deadline expiration checks in time-sensitive functions.
- [x] Proportional liquidity enforcement during deposits.
- [x] Correct swap behavior and slippage validation.
- [x] Robust `getAmountOut()` and `getPrice()` calculations.
- [x] Event emission for all critical actions.

---

## 📄 License

This project is licensed under the MIT License. Feel free to use, modify, and distribute.

---