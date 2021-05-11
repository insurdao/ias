// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;


contract ClaimLike {

}


contract Policy {
    string      public name;                // Policy name
    uint256     public max_premium;         // Max cap premium for this policy
    uint256     public max_payout;          // Max cap payout for this policy
    uint256     public min_members;         // Minimum members to start coverage
    uint256     public premium;             // Dynamic paid premium
    uint256     public payout;              // Dynamic payout coverage

    uint256     public created;
    address     public manager;
    address[]   public members;
    address     public token;
    uint256     public totalBalance;
    bool        public live;
    mapping (address => ClaimLike) public claims;
    mapping (address => uint256)   public balances;


    // --- EVENTS ---
    event PayoutSet(uint256 indexed payout);


    // --- INIT ----
    constructor(string memory name_,
                uint256 max_premium_,
                uint256 max_payout_,
                uint256 min_members_) {

        name = name_;
        max_premium = max_premium_;
        max_payout = max_payout_;
        min_members = min_members_;
        premium = 0;
        payout = 0;
    }


    // --- FUNCS ---
    function setPayout(uint256 payout) external {
        require(payout <= max_payout, "payout should be less than the cap");
        payout = payout;
    }

    function setPremium(uint256 premium) external {
        require(premium <= max_premium);
        premium = premium;
    }

}
