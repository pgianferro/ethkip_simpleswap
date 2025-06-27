# 💧 SimpleSwap Smart Contract

`SimpleSwap` es un contrato inteligente en Solidity que implementa un DEX (exchange descentralizado) simplificado inspirado en Uniswap. Permite intercambios entre tokens ERC20, provisión de liquidez y consultas de precio on-chain.

---

## 📑 Índice

1. [Overview](#-overview)  
2. [Guía de Integración para Front-End](#-guía-de-integración-para-front-end)  
3. [Tecnologías Utilizadas](#-tecnologías-utilizadas)  
4. [Detalles de Despliegue](#-detalles-de-despliegue)  
5. [Guía de Uso](#-guía-de-uso)  
6. [Checklist de Testing y Verificación](#-checklist-de-testing-y-verificación)  
7. [Licencia](#-licencia)

---

## 🧠 Overview

Este contrato soporta:

- Agregar liquidez a un pool de dos tokens ERC20.  
- Retirar liquidez y canjear los activos subyacentes.  
- Intercambiar un token por otro usando una fórmula AMM.  
- Consultar precios de tokens basados en reservas.  
- Emitir tokens LP internos (no compatibles ERC20).  

---

## 📘 Guía de Integración para Front-End

| Función                            | Tipo     | Descripción                                                                 |
|------------------------------------|----------|-----------------------------------------------------------------------------|
| `addLiquidity(...)`                | External | Agrega liquidez y emite tokens LP. Requiere `approve()` previo en ambos tokens. |
| `removeLiquidity(...)`             | External | Quema tokens LP y devuelve tokenA y tokenB.                                |
| `swapExactTokensForTokens(...)`    | External | Intercambia tokenA por tokenB o viceversa.                                 |
| `getPrice(tokenA, tokenB)`         | View     | Devuelve el tipo de cambio actual entre tokenA y tokenB.                   |
| `getAmountOut(amountIn, reserveIn, reserveOut)` | Pure | Estima el monto de salida dado un monto de entrada y reservas.             |
| `name()` / `symbol()` / `decimals()` | View  | Metadata del token LP.                                                     |
| `reserveA`, `reserveB`, `tokenA`, `tokenB` | Public | Configuración del pool y reservas actuales.                             |
| `balanceOf(address)`               | View     | Balance de tokens LP.                                                      |
| `totalSupply()`                    | View     | Suministro total de tokens LP.                                             | 

---

## 🛠️ Tecnologías Utilizadas

- Solidity `^0.8.30`  
- OpenZeppelin:  
  - `IERC20.sol`  
  - `Math.sol`  
- Remix + MetaMask  
- Verificación en Etherscan y Sourcify  

---

## 🚀 Detalles de Despliegue

Red: **Ethereum Sepolia Testnet**

| Componente        | Dirección                                                                                                                                     | Verificación                                                                                                                                 |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| 📄 SimpleSwap     | [`0xD1E9aEb4626A96301559806e60068494FB6AC334`](https://sepolia.etherscan.io/address/0xD1E9aEb4626A96301559806e60068494FB6AC334)               | [Etherscan](https://sepolia.etherscan.io/verifyContract-solc?a=0xD1E9aEb4626A96301559806e60068494FB6AC334&c=v0.8.30%2bcommit.73712a01&lictype=3) |
| 🟥 Token A (CR7)  | [`0x054CBf388796adefc392813F440E929760A07f2a`](https://sepolia.etherscan.io/address/0x054CBf388796adefc392813F440E929760A07f2a)               | [Etherscan](https://sepolia.etherscan.io/verifyContract-solc?a=0x054CBf388796adefc392813F440E929760A07f2a&c=v0.8.30%2bcommit.73712a01&lictype=3) |
| 🟦 Token B (M10)  | [`0xE168F31ba1c03Cad6D8B214C49CCe82E1103937B`](https://sepolia.etherscan.io/address/0xE168F31ba1c03Cad6D8B214C49CCe82E1103937B)               | [Etherscan](https://sepolia.etherscan.io/verifyContract-solc?a=0xE168F31ba1c03Cad6D8B214C49CCe82E1103937B&c=v0.8.30%2bcommit.73712a01&lictype=3) |

🔗 GitHub: [https://github.com/pgianferro/ethkip_simpleswap](https://github.com/pgianferro/ethkip_simpleswap)

---

## 🧪 Guía de Uso

1. **Inicializar Pool:** Solo el primer `addLiquidity()` inicia el pool. Requiere `approve()` previo en ambos tokens.  
2. **Agregar Liquidez:** Luego de inicializar, cualquier usuario puede agregar liquidez manteniendo proporciones.  
3. **Intercambiar Tokens:** `swapExactTokensForTokens(...)` permite intercambios respetando slippage.  
4. **Consultar Precio:** Usar `getPrice(tokenA, tokenB)` para obtener el tipo de cambio actual.  
5. **Retirar Liquidez:** `removeLiquidity(...)` quema tokens LP y devuelve los tokens aportados.  

---

## ✅ Checklist de Testing y Verificación

- [x] Validación de la inicialización del pool.  
- [x] Verificación de `deadline` en funciones sensibles al tiempo.  
- [x] Mantenimiento proporcional en `addLiquidity`.  
- [x] Comportamiento correcto en swaps y validación de slippage.  
- [x] Cálculos robustos en `getAmountOut()` y `getPrice()`.  
- [x] Refactorización completa con buenas prácticas (`require` claros, uso eficiente de variables locales).  
- [x] Verificación del contrato en Etherscan.  
- [x] Verificación manual usando el verificador de la cátedra (posición #65).  
- [x] Se utilizaron valores mínimos (`amountA`, `amountB`, `amountIn = 1`) para reducir el consumo de gas.  

---

## 📄 Licencia

MIT License.