// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";

/*
  Vault
*/

contract Vault is DSNote{

  address public owner;
  string  public name;
  mapping(address => uint256) balances;


}
