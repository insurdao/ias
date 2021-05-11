// SPDX-License-Identifier: MIT
// High-level contract from where we interact with other contracts

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";
import "ds-note/note.sol";


interface PolicyLike {
  function setPayout(uint256 payout) external;
  // add all policy functions here
}

interface ClaimLike {}

contract Boss is DSAuth, DSNote {
  mapping (bytes32 => address) public policies;
  mapping (address => mapping (bytes32 => mapping (address => bool))) public allows;
  uint256 public policyId;

  // event NewPolicy(address indexed guy, bytes12 cdp);

  uint                      public poli;      // Auto incremental
  mapping (uint => address) public owns;      // PolicyId => Owner
  // Policy repository [to be used in the groups]
  //Policy policy[];

  constructor() {

  }


  function open(address token, address usr) public note returns (uint) {
    require(usr != address(0), "usr-address-0");

  }


  // --- Math ---
  function add(uint x, uint y) internal pure returns (uint z) {
      require((z = x + y) >= x);
  }

  function sub(uint x, uint y) internal pure returns (uint z) {
      require((z = x - y) <= x);
  }
}
