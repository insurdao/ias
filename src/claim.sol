
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";

contract Claim is DSAuth {
    string  uuid;
    bytes32 group;
    address mediator;
    uint256 payout_requested;
    uint256 payout_paid;
    uint256 state;
    string[] stateChangeReasons;





}
