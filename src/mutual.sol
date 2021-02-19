// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";


interface Policy {}

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

  /// have exclusive functions for that.
  /// @param name group name
  /// @param token the token address, can be USDT, etc..
  /// @param policy name of the policy template we want for this group
  function createGroup(string calldata name, string calldata policy, address token) external {
    bytes32 hashedGroup = keccak256(abi.encodePacked(name));
    bytes32 hashedPolicy = keccak256(abi.encodePacked(policy));

    require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not an admin");
    // require(groups(hashedGroup).length == 0, "Already added group");

    Group storage group = groups[hashedGroup];
    group.owner = msg.sender;
    group.manager = msg.sender;
    group.token = token;
    group.name = name;
    group.timestamp = block.timestamp;
    group.policy = policies[hashedPolicy];
  }

}
