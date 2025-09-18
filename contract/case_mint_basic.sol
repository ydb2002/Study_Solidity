/* 
This code is Minting Token without openZeppline
Token Format is ERC-20
*/


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// 토큰을 정의한다. 
// Contract 구조체란? 
contract MyToken {

    // Token에 대한 기본적 요소 정의 
    string public name = "SHIBAPEPE"; // 토큰명
    string public symbol = "SPEPE"; // 토큰 심볼 
    uint8 public decimals = 18; // ERC 표준 기본값
    uint256 public totalSupply; // 총 발행량
    mapping(address => uint256) public balanceOf; // 각 계정의 잔액

    /* Event 정의 (ERC20 표준)
       - Event : 
       - indexed : 
       - address : 
    */
    event Transfer(address indexed from, address indexed to, uint256 value); // 전송 이벤트
    event Mint(address indexed to, uint256 value); // 발행 이벤트

    // 생성자 : 배포 시 초기 발행
    constructor(uint256 initialSupply) {
        _mint(msg.sender, initialSupply);
    }

    /* 내부 민팅 함수
       - require : 
       - address(0) : 
       - emit : 
    */
    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "Mint to zero address");
        totalSupply += amount;
        balanceOf[to] += amount;

        emit Transfer(address(0), to, amount); // ERC20 규약 : mint는 from=0
        emit Mint(to, amount);
    }

    /* 외부 민팅 함수
       - returns : 
       - require : 
    */
    function mint(address to, uint256 amount) external {
        // 함수 실행 가능 조건 정의 : 오너만 민팅 가능
        require(msg.sender == owner, "Only Owner can mint"); 
        _mint(to, amount); // 내부 민팅 함수 호출 
    }

    /* 토큰 전송
    */
    function transfer(address to, uint256 amount) external returns (bool) {
        // 함수 실행 가능 조건 정의 : 잔고 확인, 전송 주소 확인
        require(msg.sender != address(0), "Transfer from zero address");
        require(balanceOf[msg.sender] >= amount, "Not enough balance");
        require(to != address(0), "Transfer to zero address");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    // 컨트렉트 배포자 저장
    address public owner = msg.sender;
}