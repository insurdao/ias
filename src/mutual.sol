// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";

contract Mutual is DSAuth {


  // Policy repository [to be used in the groups]
  mapping (bytes32 => Policy) claims;
  mapping (bytes32 => Policy) policies;
  mapping (bytes32 => Group) groups;

  /// GROUP
  struct Group {
    Policy policy;
    address owner;
    address manager;
    string name;
    address[] members;
    uint256 depositAmount;
    address token;
    uint256 timestamp;
    mapping(address => uint256) balances;
    uint256 totalBalance;
  }

  constructor() {

  }


}
