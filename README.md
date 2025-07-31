# HiveFury HFREW Token Launch (Hedera MainNet)

This repository documents the successful deployment and activation of the HFREW token on Hedera MainNet as part of the HiveFury project grant milestone.

---

## ✅ Objective

Launch the HFREW reward token on Hedera MainNet, demonstrate functional smart contract integration, and provide on-chain proof of reward issuance and utility.

---

## 🔗 Contract + Token Info

| Component               | Address / ID                                                                 |
|------------------------|-------------------------------------------------------------------------------|
| HFREW Token ID         | `0.0.9471230`                                                                 |
| Token Solidity Address | `0x00000000000000000000000000000000009084Fe`                                 |
| HiveFury SC Address    | `0xc308fcc5882bc91939e363c2f87a9496b195434c`                                  |
| Verified Contract Name | `HiveFuryThreatOracle`                                                       |

---

## 📄 Contract Deployment & Token Configuration

| Action                          | Tx Hash                                                                                                                | Description                                |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
| SC Deployment                  | [`0xd607adc56182b574ee18be4de3f1f5db52739dc72d83f5e0b658008667a70870`](https://hashscan.io/mainnet/transaction/0xd607adc56182b574ee18be4de3f1f5db52739dc72d83f5e0b658008667a70870) | Oracle smart contract deployment            |
| `configureTokens()`            | [`0x8b83ae280ad5d50fb28e5f9c0d57682fbfc4a7a54dea8550bcb4365df8d4b01c`](https://hashscan.io/mainnet/transaction/0x8b83ae280ad5d50fb28e5f9c0d57682fbfc4a7a54dea8550bcb4365df8d4b01c) | HFREW token address linked to contract      |
| Token Transfer → Contract      | `SUCCESS` — visible in [HashScan HFREW transfers](https://hashscan.io/mainnet/token/0.0.9471230)                       | HFREW token sent to smart contract wallet   |

---

## 🧠 Threat Reporting & Reward Demonstration

| Action              | Status    |
|---------------------|-----------|
| `reportThreat()`    | ✅ Tested |
| `claimRewards()`    | ✅ Tested |
| HFREW distributed?  | ✅ Yes    |
| Token association?  | ✅ Confirmed via HashPack & smart contract success |

---

## 📈 Bonding Curve

A bonding curve will be created using SaucerSwap or similar when full tokenomics are solidified. This token is used for rewards but there will be a governance token.

---

## 📊 Public Dashboard / Metrics (WIP)

- [HashScan Token Page](https://hashscan.io/mainnet/token/0.0.9471230)
- Initial holders: 1 (contract-associated and reporter)
- Transfers: ✅ visible
- Rewards claimed: ✅ simulated
- Threat submissions: ✅ tested via Remix

