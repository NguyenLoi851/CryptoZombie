// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

import "../../node_modules/openzeppelin-solidity/contracts/access/AccessControl.sol";
import "../../node_modules/openzeppelin-solidity/contracts/utils/math/SafeMath.sol";
import "./CallerContractInterface.sol";

contract EthPriceOracle is AccessControl{
  bytes32 public constant OWNERS = keccak256("OWNERS");
  bytes32 public constant ORACLES = keccak256("ORACLES");
  using SafeMath for uint256;
  uint private randNonce = 0;
  uint private modulus = 1000;
  uint private numOracles = 0;
  uint private THRESHOLD = 0;
  mapping(uint256=>bool) pendingRequests;
  struct Response {
    address oracleAddress;
    address callerAddress;
    uint256 ethPrice;
  }
  mapping (uint256=>Response[]) requestIdToResponse;
  event GetLatestEthPriceEvent(address callerAddress, uint id);
  event SetLatestEthPriceEvent(uint256 ethPrice, address callerAddress);
  event AddOracleEvent(address oracleAddress);
  event RemoveOracleEvent(address oracleAddress);
  event SetThresholdEvent (uint threshold);

  constructor (address _owner){
    grantRole(OWNERS, _owner);
  }

  function addOracle (address _oracle) public {
    require(hasRole(OWNERS,msg.sender), "Not an owner!");
    require(!hasRole(ORACLES,_oracle), "Already an oracle!");
    grantRole(ORACLES,_oracle);
    numOracles++;
    emit AddOracleEvent(_oracle);
  }
  function removeOracle (address _oracle) public {
    require(hasRole(OWNERS,msg.sender), "Not an owner!");
    require(hasRole(ORACLES,_oracle), "Already an oracle!");
    require (numOracles > 1, "Do not remove the last oracle!");
    revokeRole(ORACLES,_oracle);
    numOracles--;
    emit RemoveOracleEvent(_oracle);
  }
  function setThreshold (uint _threshold) public {
    require(hasRole(OWNERS,msg.sender), "Not an owner!");
    THRESHOLD = _threshold;
    emit SetThresholdEvent(THRESHOLD);
  }
  function getLatestEthPrice() public returns (uint256) {
    randNonce++;
    uint id = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % modulus;
    pendingRequests[id] = true;
    emit GetLatestEthPriceEvent(msg.sender, id);
    return id;
  }
  function setLatestEthPrice(uint256 _ethPrice, address _callerAddress, uint256 _id) public {
    require(hasRole(ORACLES,msg.sender), "Not an oracle!");
    require(pendingRequests[_id], "This request is not in my pending list.");
    Response memory resp;
    resp = Response(payable(msg.sender), payable(_callerAddress), _ethPrice);
    requestIdToResponse[_id].push(resp);
    uint numResponses = requestIdToResponse[_id].length;
    if (numResponses == THRESHOLD) {
      uint computedEthPrice = 0;
        for (uint f=0; f < requestIdToResponse[_id].length; f++) {
        computedEthPrice = computedEthPrice.add(requestIdToResponse[_id][f].ethPrice);
      }
      computedEthPrice = computedEthPrice.div(numResponses);
      delete pendingRequests[_id];
      delete requestIdToResponse[_id];
      CallerContractInterface callerContractInstance;
      callerContractInstance = CallerContractInterface(_callerAddress);
      callerContractInstance.callback(computedEthPrice, _id);
      emit SetLatestEthPriceEvent(computedEthPrice, _callerAddress);
    }
  }
}
