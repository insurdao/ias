// SPDX-License-Identifier: MIT
// High-level contract from where we interact with other contracts

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";


interface PolicyLike {
  function setPayout(uint256 payout) external;
  // add all policy functions here
}

interface ClaimLike {}

contract Boss is DSAuth {

  uint                      public poli;      // Auto incremental
  mapping (uint => address) public owns;      // PolicyId => Owner
  // Policy repository [to be used in the groups]
  //Policy policy[];

  constructor() {

  }


}
