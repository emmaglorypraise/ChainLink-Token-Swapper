// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Swapper.sol";

contract SwapperTest is Test {
    Swapper public swap;
    address USDTHolder = 0x07B664C8aF37EdDAa7e3b6030ed1F494975e9DFB;
    address inchHolder = 0x7C628430e0702847cf4Ec7211C80314E46dB4c87;

    function setUp() public {
        swap = new Swapper();
    }

    function testSwap() public {
        vm.startPrank(inchHolder);
        IERC20(swap.INCH()).transfer(address(swap), 100000e18);
        vm.stopPrank();
        vm.startPrank(USDTHolder);
        IERC20(swap.USDT()).approve(address(swap), 1000000e18);
        swap.swap(500e6);
        vm.stopPrank();
    }
}
