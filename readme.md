📝 Introducción

Este repositorio contiene la implementación de un contrato inteligente simplificado al estilo Uniswap V2, denominado SimpleSwap. Su objetivo es permitir a los usuarios agregar liquidez a un pool de dos tokens ERC-20 y recibir a cambio un token LP (liquidity provider token) que representa su participación proporcional en el pool.

El contrato implementa las siguientes funcionalidades clave:
	•	Inicialización única del pool por parte del owner, con reservas fijas de tokens A y B.
	•	Adición de liquidez por parte de usuarios respetando la proporción existente entre las reservas.
	•	Emisión de LP tokens proporcional al aporte real de cada usuario.
	•	Gestión interna de reservas y supply del token LP.
	•	Validaciones para mantener la integridad y seguridad del sistema.

La lógica de emisión de LP tokens está basada en la fórmula tradicional de Uniswap V2:
liquidez = min((amountA * totalSupply) / reserveA, (amountB * totalSupply) / reserveB)
Esto asegura que cada nuevo proveedor de liquidez recibe una participación justa en relación a su aporte.

A continuación, se detallan los tests sugeridos para verificar el correcto funcionamiento del contrato.


✅ Batería de Tests para addLiquidity

A continuación se detallan los casos de prueba sugeridos para validar el correcto funcionamiento del contrato SimpleSwap, específicamente la función addLiquidity.

🧪 1. Inicialización del pool (primer llamado)

1.1. ✅ Solo el owner puede inicializar el pool
1.2. ✅ Se transfieren correctamente 1000 unidades de tokenA y tokenB al contrato
1.3. ✅ Se emiten 1000 LP tokens al owner
1.4. ❌ Cualquier intento posterior de inicialización debe fallar

⸻

🧪 2. Agregar liquidez con proporción correcta

2.1. ✅ Usuario externo puede agregar liquidez luego de inicialización
2.2. ✅ Los tokens transferidos respetan la proporción reservaA/reservaB
2.3. ✅ Se calcula correctamente la cantidad de LP tokens
2.4. ✅ Se actualizan correctamente las reservas y el totalSupply
2.5. ✅ El LP token se asigna correctamente al to especificado

⸻

🧪 3. Agregar liquidez con exceso de uno de los tokens

3.1. ✅ El contrato ajusta el exceso de amountBDesired si amountBOptimal < amountBDesired
3.2. ✅ El contrato ajusta el exceso de amountADesired si amountAOptimal < amountADesired
3.3. ❌ Si el amountAOptimal < amountAMin o amountBOptimal < amountBMin, debe revertir

⸻

🧪 4. Validaciones de seguridad y consistencia

4.1. ❌ Revertir si deadline < block.timestamp
4.2. ❌ Revertir si tokenA_ != tokenA o tokenB_ != tokenB
4.3. ❌ Revertir si el transferFrom falla por falta de approve
4.4. ❌ Revertir si el msg.sender no tiene suficientes tokens

⸻

🧪 5. Comprobación de eventos

5.1. ✅ Se emite correctamente el evento InitialLiquidityAdded al inicializar
5.2. ✅ Se emite correctamente el evento LiquidityAdded en llamadas subsiguientes

⸻

🧪 6. Casos extremos

6.1. ❌ No se debe permitir inicializar con cantidades distintas de amountA y amountB (no 1000-1000)
6.2. ❌ No se debe permitir agregar 0 tokens de tokenA o tokenB
6.3. ✅ Se puede agregar cantidades muy pequeñas si respetan la proporción y mínimos

⸻
