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
     // string ipfsHash;
     // bytes32 coverId;
     // address owner;
     // uint incidentDate;
     // function _setClaimStatus(uint claimId, uint stat) 

    // --- State Machine ---

    enum State {
        NEW,       // [sent by member  ]
        REVIEWING, // [adjuster reviews]
        APPROVED,  // [adjuster approve]
        CANCELED,  // [member canceled ]
        REJECTED,  // [ajuster rejects ]
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

    // --- State Machine Rules ---
    function transitionTo(State to) internal {
        // sanity check
        require(to != State.NEW, 'new-state-not-allowed');
        require(to != state,     'same-state-not-allowed');
        // claim-adjuster start reviewing
        if(to == State.REVIEWING) {
            require(state == State.NEW, 'only-new-to-reviewing-allowed');
            require(msg.sender == adjuster);
            state = State.REVIEWING;
        }
        // claimer decides to cancel while adjuster was reviewing
        if(to == State.CANCELED) {
            require(state == State.REVIEWING, 'only-cancel-from-reviewing');
            require(msg.sender == claimer);
            state = State.REVIEWING;
        }
        // claim-adjuster aproves after reviewing or after claimer wins a dispute
        if(to == State.APPROVED) {
            require(state == State.REVIEWING || 
                    state == State.DISPUTING, 'only-reviewing-approved-allowed');
            require(msg.sender == adjuster);
            state = State.APPROVED;
        }
        // claim-adjuster rejects after reviewing or after adjuster wins a dispute
        if(to == State.REJECTED) {
            require(state == State.REVIEWING || 
                    state == State.DISPUTING, 'only-reviewing-declined');
            require(msg.sender == adjuster);
            state = State.REJECTED;
        }
        // claimer dislikes the rejecting and starts an off-chain dispute
        if(to == State.DISPUTING) {
            require(state == State.REJECTED, 'only-disputes-from-rejected');
            require(msg.sender == claimer);
            state = State.DISPUTING;
        }
        // adjuster finally pays the claimer
        if(to == State.PAID) {
            require(state == State.APPROVED, 'only-paid-from-disputed');
            require(msg.sender == adjuster);
            state = State.PAID;
        }
    }


}
