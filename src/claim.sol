
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";

contract Claim is DSAuth {

    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external note auth { wards[usr] = 1; }
    function deny(address usr) external note auth { wards[usr] = 0; }
    modifier auth {
        require(wards[msg.sender] == 1, "claim/not-authorized");
        _;
    }

    // --- Data ---
    string  uuid;
    bytes32 group;
    address mediator;
    uint256 payout_requested;
    uint256 payout_paid;
    uint256 state;
    string[] stateChangeReasons;





}
