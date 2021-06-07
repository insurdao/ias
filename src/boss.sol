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

  // event NewPolicy(address indexed guy, bytes12 cdp);

  uint256                   public poli;      // Auto incremental
  mapping (uint => address) public owns;      // PolicyId => Owner
  // Policy repository [to be used in the groups]
  //Policy policy[];


  constructor(address owner_) {
    owner = owner_;
  }


  function open(address token, address usr) public note returns (uint) {

  }


  // --- Math ---
  function add(uint x, uint y) internal pure returns (uint z) {
      require((z = x + y) >= x);
  }

  function sub(uint x, uint y) internal pure returns (uint z) {
      require((z = x - y) <= x);
  }
}
