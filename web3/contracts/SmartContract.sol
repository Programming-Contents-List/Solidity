// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BNBLockup {
    address public owner;

    struct LockInfo {
        uint256 amount;      // amount of BNB locked
        uint256 releaseTime; // unlock time (timestamp) 
        bool released;       // release status
    }

    mapping(address => LockInfo) public lockedFunds;

    event Locked(address indexed user, uint256 amount, uint256 releaseTime);
    event Released(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // lockup for BNB function
    function lockBNB(address _user, uint256 _releaseTime) external payable onlyOwner {
        require(msg.value > 0, "Must send BNB to lock");
        require(_releaseTime > block.timestamp, "Release time must be in the future");
        require(lockedFunds[_user].amount == 0, "User already has locked BNB");

        lockedFunds[_user] = LockInfo({
            amount: msg.value,
            releaseTime: _releaseTime,
            released: false
        });

        emit Locked(_user, msg.value, _releaseTime);
    }

    // BNB release function
    function releaseBNB() external {
        LockInfo storage lockInfo = lockedFunds[msg.sender];
        require(lockInfo.amount > 0, "No locked BNB found");
        require(block.timestamp >= lockInfo.releaseTime, "BNB is still locked");
        require(!lockInfo.released, "BNB already released");

        uint256 amount = lockInfo.amount;
        lockInfo.released = true;

        payable(msg.sender).transfer(amount);

        emit Released(msg.sender, amount);
    }

    // check staked BNB
    function getLockedInfo(address _user) external view returns (uint256 amount, uint256 releaseTime, bool released) {
        LockInfo memory lockInfo = lockedFunds[_user];
        return (lockInfo.amount, lockInfo.releaseTime, lockInfo.released);
    }

    // check contract balance
    function contractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
