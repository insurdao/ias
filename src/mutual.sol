// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";


interface Policy {}
interface ClaimLike {}

contract Mutual is DSAuth {

  // Policy repository [to be used in the groups]
  Policy policy;
  uint256 created;
  address manager;
  string name;
  address[] members;
  address token;
  uint256 totalBalance;
  mapping (address => ClaimLike) claims;
  mapping (address => uint256) balances;

  constructor() {

  }


}
