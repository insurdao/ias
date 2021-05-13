// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;


contract ClaimLike {

}


// TODO setup number types [wad, etc..]
contract Policy {
    string      public name;                // Policy name
    uint256     public premium;             // Dynamic paid premium
    uint256     public premium_max;         // Max cap premium for this policy
    uint256     public payout;              // Dynamic payout coverage
    uint256     public payout_min;          // Min cap payout for this policy
    uint256     public payout_max;          // Max cap payout for this policy
    uint256     public members_min;         // Minimum members to start coverage
    uint256     public risk;                // Risk factor calculated by pay/low

    address     public manager;
    address[]   public members;
    address     public token;
    uint256     public totalBalance;
    bool        public live;
    mapping (address => ClaimLike) public claims;
    mapping (address => uint256)   public balances;


    struct Member {
        address     wallet;
        uint256     balance;
    }


    // --- EVENTS ---
    event PayoutSet(uint256 indexed payout);


    // --- INIT ----
    constructor(string memory name_,
                uint256 premium_,
                uint256 premium_max_,
                uint256 payout_,
                uint256 payout_min_,
                uint256 payout_max_,
                uint256 members_min_,
                address manager_) {

        name        = name_;
        premium     = premium_;
        premium_max = premium_max_;
        payout      = payout_;
        payout_min  = payout_min_;
        payout_max  = payout_max_;
        members_min = members_min_;
        manager     = msg.sender;
    }

    // --- START & EMERGENCY STOP COVERAGE
    function start() external {
        // require 
        // require()
    }

    function stop() external {
        //require()
    }

    // --- MANUAL RISK MANAGEMENT ---
    function setPayout(uint256 payout_) external {
        require(payout_ <= payout_max, "payout should be less than the max cap");
        require(payout_ >= payout_min, "payout should be more than the min cap");
        payout = payout_;
    }

    function setPremium(uint256 premium_) external {
        require(premium_ <= premium_max);
        premium = premium_;
    }

}
