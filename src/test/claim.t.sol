// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-test/test.sol";

import "../claim.sol";

contract PolicyTest is DSTest {
    Claim claim;

    // me is also the claim adjuster, so it can access the claim.review()
    function setUp() public {
        address me = address(this);
        claim = new Claim(bytes32('my-group'), me, me, 100);
    }

    function testSucce_setReview() public {
        claim.review();
    }

    function testSuccess_setPayout() public {
        // policy.setPayout(3);
        // assertEq(3, policy.payout(), "not same payout");
    }

    function testSucceed_sanity() public {
        assertTrue(true);
    }
}
