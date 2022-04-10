pragma solidity ^0.5.0;

contract Adoption {

//Election Function Adapted From Election DAPP

uint public petcounts;

struct Pets {
  uint PetsID;
  string PetName;
  uint votecount;
}

//mappings for pet and voters
mapping(uint => Pets) public Pet;
mapping(address => bool) public voters;

address[16] public adopters;


constructor () public {
  addpets('Barfy');
  addpets('JoJo');
}
// Adopting a pet
function adopt(uint petId) public returns (uint) {
  require(petId >= 0 && petId <= 15);

  adopters[petId] = msg.sender;

  return petId;
}

// Retrieving the adopters
function getAdopters() public view returns (address[16] memory) {
  return adopters;
}

// Addpets Initially
function addpets(string memory _petname) private {
  petcounts ++;
  Pet[petcounts] = Pets(petcounts, _petname, 0);
}

// Vote for pets
event voteevent (
  uint indexed _petid
);

function vote (uint _petid) public{
  require(!voters[msg.sender]);
  require(_petid > 0 && _petid < petcounts);

  voters[msg.sender] = true;
  Pet[_petid].votecount ++;

  emit voteevent(_petid);
}
}
