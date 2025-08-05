// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IHFREWToken {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function decimals() external view returns (uint8);
}

contract HFREWBondingCurve {
    IHFREWToken public hfrew;
    address public owner;
    uint256 public pricePerToken; // in wei (HBAR equivalent)
    uint256 public constant INCREMENT = 1000000000; // 1 tinybar per buy (adjustable)
    
    event Bought(address indexed buyer, uint256 amount, uint256 cost);
    event Sold(address indexed seller, uint256 amount, uint256 refund);

    constructor(address _hfrewToken, uint256 _initialPrice) {
        hfrew = IHFREWToken(_hfrewToken);
        owner = msg.sender;
        pricePerToken = _initialPrice; // e.g. 100000000 (0.1 HBAR in tinybars)
    }

    function buy(uint256 amount) external payable {
        uint256 cost = amount * pricePerToken;
        require(msg.value >= cost, "Insufficient HBAR");

        require(hfrew.transfer(msg.sender, amount), "Token transfer failed");
        pricePerToken += INCREMENT * amount;

        emit Bought(msg.sender, amount, cost);
    }

    function sell(uint256 amount) external {
        require(hfrew.transferFrom(msg.sender, address(this), amount), "Token transfer failed");

        uint256 refund = amount * pricePerToken;
        payable(msg.sender).transfer(refund);
        pricePerToken -= INCREMENT * amount;

        emit Sold(msg.sender, amount, refund);
    }

    // Optional: Withdraw HBAR from contract by owner
    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
