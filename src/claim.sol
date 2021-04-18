// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";

/*
 The claim state machine will check that every function call is
 permitted to be executed in its current state.
    TODO; log state transitions with timestamp
    TODO: add authority owner to let to change adjuster
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
    uint        public created = block.timestamp;  // Time the claim started [New]
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
        APPROVED,  // [adjuster approve]
        CANCELED,  // [member canceled ]
        DECLINED,  // [ajuster declines]
        DISPUTING, // [member disagrees]
        PAID,      // [ajuster paid it ]
        SETTLED    // [rejected forever]
    }

    // --- Modifiers ---

    modifier when(State state_) {
        require(state == state_);
        _;
    }

    modifier only(address guy) {
        require(msg.sender == guy, 'access-denied');
        _;
    }

    modifier timed() {
        if (state == State.CANCELED && block.timestamp >= created) {
            state = State.SETTLED;
        }
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


    function review() external when(State.NEW) only(adjuster){
        transitionTo(State.REVIEWING);
    }


    function transitionTo(State to) internal {
        require(to != State.NEW, 'new-state-not-allowed');
        require(to != state, 'same-state-not-allowed');
        if(to == State.REVIEWING) {
            require(state == State.NEW, 'only-new-to-reviewing-allowed');
            state = State.REVIEWING;
        }
        // if(to == State.REVIEWING) {
        //
        // }
    }


}
