// Sources flattened with hardhat v2.10.1 https://hardhat.org

// File @chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol@v0.4.2

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}


// File contracts/sKCSTVL.sol

pragma solidity ^0.8.7;

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
    function getLatestsKCSTVL() external view returns (uint) {

        // decimals is 8
        int kcsPrice = getLatestKCSPrice();
        (, , uint256 fee) = sKCS.kcsBalances();
        (uint256 kcsAmount, ) = sKCS.exchangeRate();

        uint256 tvl = (kcsAmount + fee) * uint256(kcsPrice) / 1e8;

        return tvl;
    }
}
