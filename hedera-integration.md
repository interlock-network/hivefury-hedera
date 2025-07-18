# Hedera Services Integration Guide

## Smart Contract

**Address**: `0x5c2761742fc167b47be21e680aa4d0e2f8f9c5ea`

### Key Functions
- `reportThreat()` - Submit threats with AI scoring
- `getContractStats()` - View platform statistics  
- `getReporterStats()` - Check user rewards and reputation

## Mirror Node API

**Endpoint**: `https://mainnet-public.mirrornode.hedera.com/api/v1`

### Usage
- Contract verification
- Transaction history
- Real-time event monitoring

## HTS Integration

**Status**: Architecture implemented, token pending

- Tracks rewards on-chain
- Calculates distributions based on AI scores
- Ready for HIVE token deployment

## HCS Architecture

**Status**: Message ID generation active, topic pending

- Generates deterministic message IDs
- Stores with each threat record
- Ready for consensus submission