pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale{
    constructor(
        string memory name,
        string memory symbol,
        address payable private wallet,
        uint private goal,
        uint rate,
        uint cap,
        uint openingTime, 
        uint closingTime
        
       )
    
        Crowdsale(_rate, _wallet, _token)
        CappedCrowdsale(_cap)
        TimedCrowdsale(now, now +24 weeks)
        RefundableCrowdsale(_goal)
        public
    {
        // constructor can stay empty
    }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;

    constructor(
        // @TODO: Fill in the constructor parameters!
    )
        public
    {
        // create the PupperCoin and keep its address handy
        ERC20Mintable token = new PupperCoin(name, symbol, 0);
        
        // create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        Crowdsale token_sale_address = new Crowdsale(
            1,               // rate, still in TKNbits
            msg.sender,      // send Ether to the deployer
            token            // the token
            goal            // the goal
        );
        
        token_sale_address = address(token_sale_address);
        
        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}