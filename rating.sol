import "./ownable.sol";

contract Rating is Ownable{

  mapping (uint => uint) public rating;
  mapping (address => uint) spamStatus;
  uint id = 0;
  uint spamCutOff = 70;

  struct Professor {
    uint id;
    string name;
  }

  Professor[] public professors;

  modifier NotSpam(){
      require(spamStatus[msg.sender] < spamCutOff);
      _;
  }

  function addProfessor(string _name){
      professors.push(Professor(id,_name));
      rating[id] = 0;
      id++;

  }

  function upvote(uint _professorId) public NotSpam{
      rating[_professorId]++;
      spamStatus[msg.sender]++;
  }

  function downvote(uint _professorId) public NotSpam{
      rating[_professorId]--;
      spamStatus[msg.sender]++;

  }

  function setCutOff(uint _new) external onlyOwner{
      spamCutOff = _new;
  }


}
