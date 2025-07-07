# HiveFury - Web3 Security Layer on Hedera TestNet

## Overview
HiveFury is a decentralized security platform that uses AI-powered threat detection to protect Web3 users. Built on Hedera TestNet, it demonstrates community-driven security with token incentives.

## Deployment Details
- **Network**: Hedera TestNet
- **Contract Address**: 0x18fddff6eff422ce6106cbb7095a0af7e2414c4a
- **Transaction Hash**: 0x8b6e9037c464ea6cfb6a554093e1dcfbb1120c4249c9cbd25f590dc63efc4500
- **Block**: 21921683

## Features
- 🛡️ Real-time threat reporting by users
- 🤖 AI verification of threats (simulated by contract owner for TestNet)
- 💰 HFURY token rewards for valid threat reports
- 📊 On-chain threat oracle for dApps to query

## Smart Contract Functions
- `reportThreat(string url)` - Report a malicious URL
- `aiVerifyThreat(uint256 id, uint8 severity)` - AI verifies threat (owner only)
- `getThreat(uint256 id)` - Get threat details
- `getBalance(address)` - Check HFURY balance

## How to Test
1. Visit [Your Lovable URL]
2. Connect MetaMask to Hedera TestNet
3. Report a suspicious URL
4. Owner verifies threat with severity rating
5. Reporter receives HFURY rewards

## AI Component
The AI verification is demonstrated through the `aiVerifyThreat` function, where machine learning analysis is simulated by the contract owner assigning severity scores (1-10) to reported threats.