
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-note/note.sol";

contract Claim is DSNote{

    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external note auth { wards[usr] = 1; }
    function deny(address usr) external note auth { wards[usr] = 0; }
    modifier auth {
        require(wards[msg.sender] == 1, "claim/not-authorized");
        _;
    }

    // --- Data ---
    uint        public creationTime = block.timestamp;  // Time the claim started [New]
    string      public uuid;
    bytes32     public group;
    address     public mediator;
    uint256     public payout_requested;
    uint256     public payout_paid;

    // --- State Machine ---

    enum Stages {
        New,       // [sent by member  ]
        Review,    // [adjuster reviews] Approved,  // [ajuster approved]
        Canceled,  // [member canceled ]
        Rejected,  // [ajuster rejected]
        Disputed,  // [member disagrees]
        Paid,      // [ajuster paid it ]
        Settled    // [rejected forever]
    }

    Stages public stage = Stages.New;
    modifier atStage(Stages _stage) {
        require(stage == _stage);
        _;
    }


}
