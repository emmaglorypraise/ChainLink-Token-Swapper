// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "../contracts/IERC20.sol";
// import "../contracts/AggregatorV3Interface.sol";

contract Swap{
    event input(uint256);

    struct TokenDetails {
        address tokenAddress;
        int256 price;
        
    }
    struct AggregatorFeed {
        AggregatorV3Interface priceFeed;
    }


    address owner;
    TokenDetails[] pricefeed;


    mapping(address => TokenDetails) _tokenInfo;
    mapping(address => AggregatorFeed) _tokenUsd;



    modifier onlyOwner() {
        require(msg.sender == owner, "You are not authorize");

        _;
    }



    constructor(){
        owner = msg.sender;
    }  


    function setPriceFeed(address _addrFeedInput, address _tokenAddr) public {
        AggregatorFeed storage AF = _tokenUsd[_tokenAddr];
        AF.priceFeed = AggregatorV3Interface(_addrFeedInput);
    }


    function RegisterToken(address _tokenaddr) public onlyOwner {
        TokenDetails memory TD = _tokenInfo[_tokenaddr];
        AggregatorFeed memory AF = _tokenUsd[_tokenaddr];
        (
            /uint80 roundID/,
            int price,
            /uint startedAt/,
            /uint timeStamp/,
            /uint80 answeredInRound/
        ) = AF.priceFeed.latestRoundData();
        TD.tokenAddress = _tokenaddr;
        TD.price = price;
        uint256 priceIndex = pricefeed.length;
        pricefeed.push(TD);

        emit input(priceIndex);
     }

    

    function SwapExactTokentoToken (address tokenaddr, address tokenaddr2,address owner1, address owner2,uint tokenvalue1, uint tokenvalue2) public {
        IERC20 exactToken = IERC20(tokenaddr);
        IERC20 token = IERC20(tokenaddr2);

        require(exactToken.allowance(owner1, address(this)) >= tokenvalue1, "You are withdrawing more than your allowance");
        require(token.allowance(owner2, address(this)) >= tokenvalue2, "You are withdrawing more than your allowance");

        for(uint256 i=0; i < pricefeed.length; i++){
            if(pricefeed[i].tokenAddress == tokenaddr){
                int256 checkprice1 = pricefeed[i].price;
                token.transferFrom(owner2, owner1, (tokenvalue2 * uint256(checkprice1)));
            }
            if(pricefeed[i].tokenAddress == tokenaddr2){
                int256 checkprice2 = pricefeed[i].price;
                exactToken.transferFrom(owner1, owner2, (tokenvalue1 * uint256(checkprice2)));
            }
        }

        
        
    }
}