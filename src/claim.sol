// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";

/*
 The claim state machine will check that every function call is
 permitted to be executed in its current state.
*/

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
    address     public adjuster;
    address     public claimer;
    uint256     public payout;
    State       public state;

    // --- State Machine ---

    enum State {
        NEW,       // [sent by member  ]
        REVIEWING, // [adjuster reviews]
        CANCELED,  // [member canceled ]
        DECLINED,  // [ajuster declines]
        DISPUTING, // [member disagrees]
        PAID,      // [ajuster paid it ]
        SETTLED    // [rejected forever]
    }

    modifier atState(State state_) {
        require(state == state_);
        _;
    }

    modifier checkAllowed {
        //conditionalTransitions();
        //require(states[currentStateId].allowedFunctions[msg.sig]);
        _;
    }

    event Transition(bytes32 stateId, uint256 blockNumber);

    constructor(bytes32 group_,
                address adjuster_,
                address claimer_,
                uint256 payout_)  {
        group      = group_;
        adjuster   = adjuster_;
        payout     = payout_;
        claimer    = claimer_;
        state      = State.NEW;
    }


    function review(address aju)

}
