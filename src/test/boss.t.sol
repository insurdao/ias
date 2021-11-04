// SPDX-License-Identifier: MIT

pragma solidity >=0.8.6;

import "ds-test/test.sol";

import "../boss.sol";

contract BossTest is DSTest {
    Boss boss;

    function setUp() public {
        //boss = new Boss();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
