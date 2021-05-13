// SPDX-License-Identifier: MIT
// Every new user has a profile, and many contracts can ask about the state

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";
import "ds-note/note.sol";



contract Profile {
  address owner;

  // struct User {
  //   address       wallet;
  //   is_adjuster   bool;
  //   is_provider   bool;
  //   approved      bool;
  //   suspended     bool;
  // }
  //
  // mapping (bytes32 => User) users;

  constructor(address _owner) {
    owner = _owner;
  }

}







