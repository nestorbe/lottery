pragma solidity ^0.4.17;

contract Lottery {
    address public manager; //El papiMandocas
    address[] public players; //Los bobos!

    // KingOfTheHill
    function Lottery() public {
      manager = msg.sender;
    }
    // Papi, dame un ticket!
    function enter() public payable {
      require(msg.value > .01 ether);
      players.push(msg.sender);
    }
    // Genera el random index (GANADOR!) TOTALMENTE INSECURE xD
    function random() private view returns(uint) {
      return uint(keccak256(block.difficulty, now, players));
    }
    // Hubo o no hubo ganador? xD
    function pickWinner() public restricted {
      uint index = random() % players.length;
      players[index].transfer(this.balance);
      players = new address[](0);
    }
    // AQUIETADO!
    modifier restricted() {
      require(msg.sender == manager);
      _;
    }
    // Quien compro tickets?
    function getPlayers() public view returns (address[]) {
      return players;
    }
}
