// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Swap {

    uint tokenA;
    uint tokenB;

    uint256 priceAgg;

     AggregatorV3Interface internal priceFeed;

    /**
     * Network: Mainnet
     * Aggregator: LINK / USD
     * Address: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price/1e8;
    }

    // function getPrice() public {
    //     priceAgg = getLatestPrice();
    // }
    function swapToken() public {
        tokenA = tokenB;
    }
}
