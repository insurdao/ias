// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-test/test.sol";

import "../claim.sol";

contract PolicyTest is DSTest {
    Claim claim;

    function setUp() public {
        claim = new Claim(bytes32('my-group'), address(123), address(123), 100);
    }

    function testSuccess_setReview() public {
        claim.review();
        //assertTrue(true);
    }

    function testSuccess_setPayout() public {
        // policy.setPayout(3);
        // assertEq(3, policy.payout(), "not same payout");
    }

    function testSucceed_sanity() public {
        assertTrue(true);
    }
}
