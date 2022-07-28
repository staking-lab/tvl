// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

interface IsKCS {
    function totalSupply() external view returns (uint256);
    function exchangeRate() external view returns(uint256, uint256);
    function kcsBalances() external view returns (uint256, uint256, uint256);
}

contract sKCSTVL {

    AggregatorV3Interface public priceFeed;
    IsKCS public  sKCS;


    constructor() {

        ///  @dev Aggregator of KCS/USD
        priceFeed = AggregatorV3Interface(0xAFC9c849b1a784955908d91EE43A3203fBC1f950);
        /// @dev sKCS
        sKCS = IsKCS(0x00eE2d494258D6C5A30d6B6472A09b27121Ef451);
    }


    /// @dev Returns the latest KCS price
    function getLatestKCSPrice() public view returns (int) {
        (
        /*uint80 roundID*/,
        int price,
        /*uint startedAt*/,
        /*uint timeStamp*/,
        /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    /// exchange rate of sKCS
    function exchangeRateOfsKCS() external view returns(uint, uint) {
        return sKCS.exchangeRate();
    }

    /// @dev Returns the latest sKCS TVL
    /// TVL should divide by 1e18 and divide by 1e8
    function getLatestsKCSTVL() external view returns (uint) {

        // decimals is 8
        int kcsPrice = getLatestKCSPrice();
        (, , uint256 fee) = sKCS.kcsBalances();
        (uint256 kcsAmount, ) = sKCS.exchangeRate();

        uint256 tvl = (kcsAmount + fee) * uint256(kcsPrice);

        return tvl;
    }

    function getLatestLockedKCS() external view returns (uint) {
        (, , uint256 fee) = sKCS.kcsBalances();
        (uint256 kcsAmount, ) = sKCS.exchangeRate();

        uint256 amount = kcsAmount + fee;
        return amount;
    }
}
