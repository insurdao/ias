// SPDX-License-Identifier: MIT

pragma solidity >=0.7.4;

import "ds-test/test.sol";

import "./WepyContracts.sol";

contract WepyContractsTest is DSTest {
    WepyContracts contracts;

    function setUp() public {
        contracts = new WepyContracts();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
