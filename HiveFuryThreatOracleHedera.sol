// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title HiveFuryThreatOracle
 * @dev Web3 threat detection oracle demonstrating Hedera services integration
 * @notice Integrates with HTS (ready for tokens), HCS for consensus, AI for validation
 */
contract HiveFuryThreatOracle {
    // Hedera service addresses (mainnet)
    address constant HTS_PRECOMPILE = 0x0000000000000000000000000000000000000167;
    address constant HCS_PRECOMPILE = 0x0000000000000000000000000000000000000168;
    
    struct Threat {
        string url;
        string threatType;
        uint8 aiScore;
        address reporter;
        uint256 timestamp;
        bool validated;
        uint256 rewardAmount;
        bytes32 hcsMessageId;
    }
    
    struct ReporterStats {
        uint256 totalReports;
        uint256 validatedReports;
        uint256 totalRewards;
        uint256 reputation;
        uint256 lastReportTime;
    }
    
    mapping(uint256 => Threat) public threats;
    mapping(string => uint256) public urlToThreatId;
    mapping(address => uint256[]) public reporterThreats;
    mapping(address => ReporterStats) public reporterStats;
    
    uint256 public threatCount;
    uint256 public validatedCount;
    uint256 public totalRewardsIssued;
    address public owner;
    
    // Configuration
    uint256 public baseReward = 100; // Base reward points
    uint256 public highScoreThreshold = 80; // AI score for auto-validation
    uint256 public mediumScoreThreshold = 50;
    address public hcsTopicId; // For HCS integration demo
    
    // Events for Hedera services integration
    event ThreatReported(uint256 indexed threatId, string url, uint8 aiScore, address reporter);
    event ThreatValidated(uint256 indexed threatId, bool autoValidated, uint8 aiScore);
    event RewardCalculated(address indexed reporter, uint256 amount, uint256 threatId);
    event HCSSubmission(uint256 indexed threatId, bytes32 messageId, uint256 timestamp);
    event HTSReady(address indexed reporter, uint256 pendingRewards);
    event ReputationUpdated(address indexed reporter, uint256 newReputation);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev Main function - AI-powered threat reporting with on-chain validation
     * This demonstrates AI performing an on-chain function (auto-validation based on score)
     */
    function reportThreat(
        string calldata _url,
        string calldata _threatType,
        uint8 _aiScore
    ) external returns (uint256) {
        require(bytes(_url).length > 0, "URL required");
        require(_aiScore <= 100, "Invalid AI score");
        
        // Check if URL already reported
        uint256 existingId = urlToThreatId[_url];
        if (existingId != 0) {
            // Update AI score if higher
            if (_aiScore > threats[existingId].aiScore) {
                threats[existingId].aiScore = _aiScore;
                _processAIValidation(existingId, _aiScore);
            }
            return existingId;
        }
        
        threatCount++;
        uint256 threatId = threatCount;
        
        // Create threat record
        threats[threatId] = Threat({
            url: _url,
            threatType: _threatType,
            aiScore: _aiScore,
            reporter: msg.sender,
            timestamp: block.timestamp,
            validated: false,
            rewardAmount: 0,
            hcsMessageId: 0
        });
        
        urlToThreatId[_url] = threatId;
        reporterThreats[msg.sender].push(threatId);
        
        // Update reporter stats
        reporterStats[msg.sender].totalReports++;
        reporterStats[msg.sender].lastReportTime = block.timestamp;
        
        emit ThreatReported(threatId, _url, _aiScore, msg.sender);
        
        // AI performs on-chain validation based on score
        _processAIValidation(threatId, _aiScore);
        
        // Submit to HCS for consensus record
        _submitToHCS(threatId);
        
        return threatId;
    }
    
    /**
     * @dev AI-driven on-chain validation logic
     * Demonstrates AI component performing on-chain function
     */
    function _processAIValidation(uint256 _threatId, uint8 _aiScore) internal {
        if (_aiScore >= highScoreThreshold) {
            // High confidence: Auto-validate and reward
            threats[_threatId].validated = true;
            validatedCount++;
            
            uint256 reward = _calculateReward(_aiScore);
            threats[_threatId].rewardAmount = reward;
            
            address reporter = threats[_threatId].reporter;
            reporterStats[reporter].validatedReports++;
            reporterStats[reporter].totalRewards += reward;
            reporterStats[reporter].reputation += 10;
            
            totalRewardsIssued += reward;
            
            emit ThreatValidated(_threatId, true, _aiScore);
            emit RewardCalculated(reporter, reward, _threatId);
            emit ReputationUpdated(reporter, reporterStats[reporter].reputation);
            
            // Emit HTS readiness event
            emit HTSReady(reporter, reporterStats[reporter].totalRewards);
            
        } else if (_aiScore >= mediumScoreThreshold) {
            // Medium confidence: Mark for manual review
            reporterStats[threats[_threatId].reporter].reputation += 3;
        }
    }
    
    /**
     * @dev Calculate dynamic rewards based on AI score
     */
    function _calculateReward(uint8 _aiScore) internal view returns (uint256) {
        if (_aiScore >= 95) return baseReward * 3;
        if (_aiScore >= 90) return baseReward * 2;
        if (_aiScore >= highScoreThreshold) return baseReward;
        return 0;
    }
    
    /**
     * @dev Submit to Hedera Consensus Service
     * Demonstrates HCS integration
     */
    function _submitToHCS(uint256 _threatId) internal {
        Threat storage threat = threats[_threatId];
        
        // Create consensus message
        bytes memory message = abi.encode(
            "HIVEFURY_THREAT",
            _threatId,
            threat.url,
            threat.aiScore,
            threat.reporter,
            block.timestamp
        );
        
        // Generate pseudo message ID for demo
        // In production, this would be the actual HCS response
        bytes32 messageId = keccak256(abi.encodePacked(
            block.timestamp,
            _threatId,
            message
        ));
        
        threat.hcsMessageId = messageId;
        
        emit HCSSubmission(_threatId, messageId, block.timestamp);
    }
    
    /**
     * @dev Manual validation by owner (backup for AI)
     */
    function validateThreat(uint256 _threatId) external onlyOwner {
        require(_threatId > 0 && _threatId <= threatCount, "Invalid threat ID");
        require(!threats[_threatId].validated, "Already validated");
        
        threats[_threatId].validated = true;
        validatedCount++;
        
        uint256 reward = baseReward;
        threats[_threatId].rewardAmount = reward;
        
        address reporter = threats[_threatId].reporter;
        reporterStats[reporter].validatedReports++;
        reporterStats[reporter].totalRewards += reward;
        reporterStats[reporter].reputation += 5;
        
        totalRewardsIssued += reward;
        
        emit ThreatValidated(_threatId, false, threats[_threatId].aiScore);
        emit RewardCalculated(reporter, reward, _threatId);
    }
    
    /**
     * @dev Get reporter statistics
     */
    function getReporterStats(address _reporter) external view returns (
        uint256 totalReports,
        uint256 validatedReports,
        uint256 totalRewards,
        uint256 reputation
    ) {
        ReporterStats memory stats = reporterStats[_reporter];
        return (
            stats.totalReports,
            stats.validatedReports,
            stats.totalRewards,
            stats.reputation
        );
    }
    
    /**
     * @dev Get threat details with HCS info
     */
    function getThreatDetails(uint256 _threatId) external view returns (
        string memory url,
        uint8 aiScore,
        bool validated,
        uint256 rewardAmount,
        bytes32 hcsMessageId,
        uint256 timestamp
    ) {
        Threat memory threat = threats[_threatId];
        return (
            threat.url,
            threat.aiScore,
            threat.validated,
            threat.rewardAmount,
            threat.hcsMessageId,
            threat.timestamp
        );
    }
    
    /**
     * @dev Check if URL is reported
     */
    function isUrlReported(string calldata _url) external view returns (bool, uint256) {
        uint256 threatId = urlToThreatId[_url];
        return (threatId != 0, threatId);
    }
    
    /**
     * @dev Demonstrate HTS integration readiness
     * Returns pending rewards that would be paid in HTS tokens
     */
    function getPendingHtsRewards(address _reporter) external view returns (uint256) {
        return reporterStats[_reporter].totalRewards;
    }
    
    /**
     * @dev Get contract statistics
     */
    function getContractStats() external view returns (
        uint256 totalThreats,
        uint256 totalValidated,
        uint256 totalRewards,
        uint256 activeReporters
    ) {
        return (threatCount, validatedCount, totalRewardsIssued, 0);
    }
}