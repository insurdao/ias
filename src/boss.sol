/// SPDX-License-Identifier: MIT
/// High-level contract from where governor interacts with the scheleton system to 
/// deploy vaults for futures mutualities, new products and change risk paramenters

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
  //mapping (address => Vault) public vaults;

  mapping (address => mapping (bytes32 => mapping (address => bool))) public allows;

  // event NewPolicy(address indexed guy, bytes12 cdp);

  uint256                   public poli;      // Auto incremental
  mapping (uint => address) public owns;      // PolicyId => Owner
  // Policy repository [to be used in the groups]
  //Policy policy[];


  constructor(address owner_) {
    owner = owner_;
  }


  /// create a vault, add to the vault collection with the sender as owner
  // function open(address token, address usr) public note returns (uint) {
  //   require(vaults[msg.sender] = Vault(0));
  //   vaults[msg.sender] = new Vault("test", msg.sender);
  // }


    // function increment() public {
    //     require (_counters[msg.sender] != Counter(0));
    //     Counter(_counters[msg.sender]).increment(msg.sender);
    // }
    //
    // function getCount(address account) public view returns (uint256) {
    //     require (_counters[account] != Counter(0));
    //     return (_counters[account].getCount());
    // }
    //
    // function getMyCount() public view returns (uint256) {
    //     return (getCount(msg.sender));
    // }

  // --- Math ---
  function add(uint x, uint y) internal pure returns (uint z) {
      require((z = x + y) >= x);
  }

  function sub(uint x, uint y) internal pure returns (uint z) {
      require((z = x - y) <= x);
  }
}
// contract Counter {
//
//     uint256 private _count;
//     address private _owner;
//     address private _factory;
//
//
//      modifier onlyOwner(address caller) {
//         require(caller == _owner, "You're not the owner of the contract");
//         _;
//     }
//
//     modifier onlyFactory() {
//         require(msg.sender == _factory, "You need to use the factory");
//         _;
//     }
//
//      constructor(address owner) public {
//         _owner = owner;
//         _factory = msg.sender;
//     }
//
//      function getCount() public view returns (uint256) {
//         return _count;
//     }
//
//     function increment(address caller) public onlyFactory onlyOwner(caller) {
//         _count++;
//     }
//
// }
