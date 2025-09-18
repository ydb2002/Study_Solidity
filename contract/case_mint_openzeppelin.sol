// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// OpenZepplin은 이더리움에서 가장 많이 쓰이는 보안 감사된 라이브러리
// ERC20.sol : ERC20 표준 인터페이스 및 기본 기능 구현
// Ownable.sol : onlyOwner 제어자(modifier)를 제공하여 배포자만 트정 기능을 수행 가능하게 함 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// ERC20의 상속 : _mint, _burn, transfer 등 기본 기능 바로 사용 가능.
// Ownable 상속 : 배포자를 owner로 등록해 관리 기능 제공
contract MyToken is ERC20, Ownable {

    // 생성자 : ERC20("토큰이름', "토큰심폴)
    constructor () ERC20("MyToken", "SPEPE") Ownable(msg.sender) {
        // 배포자에게 초기 발행 100개 지금 (소수점 18자리 기준: 100 * 10^18
        _mint(msg.sender, 100 * 10 ** decimals());
    }

    // 소유자만 새 토큰 발행 가능 
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}