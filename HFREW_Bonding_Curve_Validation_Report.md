# HFREW Bonding Curve Validation Report

**Project**: HiveFury  
**Token Name**: HFREW  
**Token ID (Hedera)**: 0.0.9471230  
**Converted Token Address (EVM)**: `0x00000000000000000000000000000000009084Fe`  
**Bonding Curve Contract Address**: `0x9a2fdf465eeda0afab7795a8caef47fbbabf9691`  
**Deployment Tx Hash**: `0x89ff7fbbf3ad539a95e03d3b9e26296a7f52abcec21f9f8df4ea3827a917cb0a`  
**Block Number**: 82847926  
**Date of Deployment**: 2025-08-05 18:39:21 UTC

---

## ⚙️ Contract Functionality

The `HFREWBondingCurve` contract implements a bonding curve tokenomics model to manage dynamic pricing for HFREW tokens. It ensures:

- Early participants acquire HFREW at a lower cost.
- Each subsequent purchase increases the token price along the curve.
- The curve is deterministic and based on preset price progression rules.

---

## 🛠️ Constructor Parameters

Upon deployment, the following parameters were passed:

- `_hfrewToken`: `0x00000000000000000000000000000000009084Fe`
- `_initialPrice`: `100000000` (equals **0.1 HBAR** in tinybars)

These inputs are consistent with the proposed tokenomics strategy.

---

## ✅ Proof of Activation

### Deployment Confirmed on Hedera MainNet

- **Contract Address:**  
  [`0x9a2fdf465eeda0afab7795a8caef47fbbabf9691`](https://hashscan.io/mainnet/contract/0x9a2fdf465eeda0afab7795a8caef47fbbabf9691)

- **Deployment Transaction:**  
  [`0x89ff7fbbf3ad539a95e03d3b9e26296a7f52abcec21f9f8df4ea3827a917cb0a`](https://hashscan.io/mainnet/transaction/0x89ff7fbbf3ad539a95e03d3b9e26296a7f52abcec21f9f8df4ea3827a917cb0a)

- **Contract Explorer Link:**  
  [HashScan - Contract View](https://hashscan.io/mainnet/address/0x9a2fdf465eeda0afab7795a8caef47fbbabf9691)

Explorer confirms successful execution, correct constructor parameters, and proper network status.

---

---
