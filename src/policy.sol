// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";


/// Policy terms approved by insurdao gov


// TODO setup number types [wad, etc..]
contract Policy is DSNote {
    int         public pid;                 // Policy ID
    string      public name;                // Policy name 
    uint256     public premium;             // Dynamic paid premium
    uint256     public premium_max;         // Max cap premium for this policy
    uint256     public payout;              // Dynamic payout coverage
    uint256     public payout_min;          // Min cap payout for this policy
    uint256     public payout_max;          // Max cap payout for this policy
    uint256     public members_min;         // Minimum members to start coverage
    address     public admin;               // Temporary admin [TODO: move to auth]


    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external note auth { wards[usr] = 1; }
    function deny(address usr) external note auth { wards[usr] = 0; }

    mapping(address => mapping (address => uint)) public can;
    function hope(address usr) external note { can[msg.sender][usr] = 1; }
    function nope(address usr) external note { can[msg.sender][usr] = 0; }
    function wish(address bit, address usr) internal view returns (bool) {
        return either(bit == usr, can[bit][usr] == 1);
    }

    // --- MODIFIERS ---
    modifier auth {
        require(wards[msg.sender] == 1, "claim/not-authorized");
        _;
    }

    // --- DATA ---


    // --- EVENTS ---
    event PayoutSet(uint256 indexed payout);


    // --- INIT ----
    constructor(){
        admin = msg.sender;
    }

    function add(string memory name_,
                uint256 premium_,
                uint256 premium_max_,
                uint256 payout_,
                uint256 payout_min_,
                uint256 payout_max_,
                uint256 members_min_) public {

        name        = name_;
        premium     = premium_;
        premium_max = premium_max_;
        payout      = payout_;
        payout_min  = payout_min_;
        payout_max  = payout_max_;
        members_min = members_min_;
    }

    // --- MANUAL RISK MANAGEMENT ---


    // --- MATH ---

    function either(bool x, bool y) internal pure returns (bool z) {
        assembly{ z := or(x, y)}
    }
    function both(bool x, bool y) internal pure returns (bool z) {
        assembly{ z := and(x, y)}
    }

}
