# HFREW Bonding Curve Validation Report

**Project**: HiveFury  
**Token Name**: HFREW  
**Token ID (Hedera)**: 0.0.9471230  
**Converted Token Address (EVM)**: 0x00000000000000000000000000000000009084Fe  
**Bonding Curve Contract Address**: 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B  
**Deployment Tx Hash**: 0x5987c9bc6441432ad023fce2f0fefc727aa1b037c0780a4e0737d7aed8894e40  
**Block Number**: 4  
**Date of Deployment**: 2025-08-05 13:14:14 UTC

---

## Contract Functionality

The `HFREWBondingCurve` smart contract implements a basic bonding curve model designed to control the price and distribution of the HFREW token over time. The curve ensures that:

- Early buyers acquire HFREW at a lower price.
- Price increases non-linearly with each purchase (price discovery).
- Tokens are minted or released from a reserve based on interaction with the curve.

---

## Constructor Parameters

Upon deployment, the contract was initialized with:

- `_hfrewToken`: `0x00000000000000000000000000000000009084Fe`
- `_initialPrice`: `100000000` (0.1 HBAR in tinybars)

---

## Proof of Activation

### ✅ Deployment Confirmed

- Contract deployed successfully at:  
  [0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B](https://hashscan.io/mainnet/contract/0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B)

- Transaction hash:  
  [0x5987c9bc6441432ad023fce2f0fefc727aa1b037c0780a4e0737d7aed8894e40](https://hashscan.io/mainnet/transaction/0x5987c9bc6441432ad023fce2f0fefc727aa1b037c0780a4e0737d7aed8894e40)

- Explorer confirms execution and constructor input.

---

## Next Steps

- Token buy/sell functions can be called to validate the curve logic in production.
- Further tracking will be recorded in the public dashboard.