pragma solidity ^0.4.23;

//global Truffle files, not a truffle directory. You should not see a truffle directory inside your test/ directory.
// disregard compiler errors
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
//The smart contract we want to test.
import "../contracts/ZombieFactory.sol";

contract TestZombieFactory {
    //define a contract-wide variable containing the smart contract to be tested, 
    //calling the DeployedAddresses smart contract to get its address.
    ZombieFactory zombieFactory = ZombieFactory(DeployedAddresses.ZombieFactory());

    // testing the createRandomZombie() function
    function testUserCanCreateZombie() public {
        //call the smart contract we declared earlier with the ID of 4.
        bool result = zombieFactory.createRandomZombie("Zomboy");
        //expected value
        bool expected = true;
        //pass the actual value, the expected value and a failure message 
        Assert.equal(result, expected, "Zombie should be created successfully.");
        // expected owner is this contract
        //Since the TestAdoption contract will be sending the transaction, we set the expected value to this
        address testAddress = this;
        // check index 0, first zombie in array
        address ownerAddress = zombieFactory.zombieToOwner(0);
        Assert.equal(ownerAddress, testAddress, "Zombie Owner address should be  the TestZombieFactory address.");
    }
}