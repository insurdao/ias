/// SPDX-License-Identifier: MIT
/// High-level contract from where governor interacts with the scheleton system to 
/// deploy vaults for futures mutualities, new products and change risk paramenters

pragma solidity >=0.8.0;

import "ds-auth/auth.sol";
import "ds-note/note.sol";


interface PolicyLike {
  function setPayout(uint256 payout) external;
}

interface VaultLike {
    function urns(bytes32, address) external view returns (uint, uint);
    function hope(address) external;
    function flux(bytes32, address, address, uint) external;
    function move(address, address, uint) external;
    function frob(bytes32, address, address, address, int, int) external;
    function fork(bytes32, address, address, int, int) external;
}

interface ClaimLike {}

contract UrnHandler {
    constructor(address vat) {
        VaultLike(vat).hope(msg.sender);
    }
}

contract Boss is DSAuth, DSNote {
    address                   public vault;
    uint                      public cdpi;      // Auto incremental
    mapping (uint => address) public urns;      // CDPId => UrnHandler
    mapping (uint => List)    public list;      // CDPId => Prev & Next CDPIds (double linked list)
    mapping (uint => address) public owns;      // CDPId => Owner
    mapping (uint => bytes32) public ilks;      // CDPId => Ilk

    mapping (address => uint) public first;     // Owner => First CDPId
    mapping (address => uint) public last;      // Owner => Last CDPId
    mapping (address => uint) public count;     // Owner => Amount of CDPs
    mapping (
        address => mapping (
            uint => mapping (
                address => uint
            )
        )
    ) public cdpCan;                            // Owner => CDPId => Allowed Addr => True/False

    mapping (
        address => mapping (
            address => uint
        )
    ) public urnCan;                            // Urn => Allowed Addr => True/False

    struct List {
        uint prev;
        uint next;
    }

    event NewCdp(address indexed usr, address indexed own, uint indexed cdp);

    modifier cdpAllowed(
        uint cdp
    ) {
        require(msg.sender == owns[cdp] || cdpCan[owns[cdp]][cdp][msg.sender] == 1, "cdp-not-allowed");
        _;
    }

    modifier urnAllowed(
        address urn
    ) {
        require(msg.sender == urn || urnCan[urn][msg.sender] == 1, "urn-not-allowed");
        _;
    }


    mapping (address => mapping (bytes32 => mapping (address => bool))) public allows;


    constructor(address vault_) {
      vault = vault_;
    }

    // Open a new cdp for a given usr address.
    function open(
        bytes32 ilk,
        address usr
    ) public note returns (uint) {
        require(usr != address(0), "usr-address-0");

        cdpi = add(cdpi, 1);
        urns[cdpi] = address(new UrnHandler(vault));
        owns[cdpi] = usr;
        ilks[cdpi] = ilk;

        // Add new CDP to double linked list and pointers
        if (first[usr] == 0) {
            first[usr] = cdpi;
        }
        if (last[usr] != 0) {
            list[cdpi].prev = last[usr];
            list[last[usr]].next = cdpi;
        }
        last[usr] = cdpi;
        count[usr] = add(count[usr], 1);

        emit NewCdp(msg.sender, usr, cdpi);
        return cdpi;
    }


    // --- Math ---
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }

    function toInt(uint x) internal pure returns (int y) {
        y = int(x);
        require(y >= 0);
    }
}
