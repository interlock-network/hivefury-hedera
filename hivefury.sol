// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Minimal HiveFury contract for Hedera TestNet
// Demonstrates AI-powered threat detection with on-chain verification

contract HiveFury {
    // Token info
    string public name = "HiveFury";
    string public symbol = "HFURY";
    uint8 public decimals = 8;
    uint256 public totalSupply = 1000000000 * 10**8; // 1B tokens
    
    // Balances
    mapping(address => uint256) public balanceOf;
    
    // Threat Oracle
    struct Threat {
        address reporter;
        string url;
        uint256 timestamp;
        bool aiVerified;
        uint8 severity; // 1-10
        uint256 reward;
    }
    
    mapping(uint256 => Threat) public threats;
    uint256 public threatCount;
    
    // Owner (acts as AI for testnet)
    address public owner;
    
    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event ThreatReported(uint256 indexed id, address reporter, string url);
    event ThreatVerifiedByAI(uint256 indexed id, uint8 severity, uint256 reward);
    event RewardClaimed(address indexed user, uint256 amount);
    
    constructor() {
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    // ERC20 transfer
    function transfer(address to, uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    // Report a threat (User interaction)
    function reportThreat(string memory url) public returns (uint256) {
        threatCount++;
        threats[threatCount] = Threat({
            reporter: msg.sender,
            url: url,
            timestamp: block.timestamp,
            aiVerified: false,
            severity: 0,
            reward: 0
        });
        
        emit ThreatReported(threatCount, msg.sender, url);
        return threatCount;
    }
    
    // AI verifies threat (Owner simulates AI for testnet)
    function aiVerifyThreat(uint256 threatId, uint8 severity) public onlyOwner {
        require(threatId > 0 && threatId <= threatCount, "Invalid threat");
        require(severity >= 1 && severity <= 10, "Severity must be 1-10");
        require(!threats[threatId].aiVerified, "Already verified");
        
        Threat storage threat = threats[threatId];
        threat.aiVerified = true;
        threat.severity = severity;
        threat.reward = uint256(severity) * 10 * 10**8; // 10-100 HFURY based on severity
        
        // Auto-send reward
        balanceOf[owner] -= threat.reward;
        balanceOf[threat.reporter] += threat.reward;
        
        emit ThreatVerifiedByAI(threatId, severity, threat.reward);
        emit Transfer(owner, threat.reporter, threat.reward);
    }
    
    // Get user's total earned rewards
    function getUserRewards(address user) public view returns (uint256 total) {
        for (uint256 i = 1; i <= threatCount; i++) {
            if (threats[i].reporter == user && threats[i].aiVerified) {
                total += threats[i].reward;
            }
        }
    }
    
    // Get threat details
    function getThreat(uint256 id) public view returns (
        address reporter,
        string memory url,
        uint256 timestamp,
        bool aiVerified,
        uint8 severity,
        uint256 reward
    ) {
        Threat memory t = threats[id];
        return (t.reporter, t.url, t.timestamp, t.aiVerified, t.severity, t.reward);
    }
}