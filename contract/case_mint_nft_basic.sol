// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyERC721 {
    // 토큰 이름과 심볼
    string public name = "MyNFT";
    string public symbol = "MNFT";

    // tokenId -> 소유자 주소
    mapping(uint256 => address) private _owners;
    // 소유자 주소 -> 보유량
    mapping(address => uint256) private _balances;
    // tokenId -> 승인된 주소
    mapping(uint256 => address) private _tokenApprovals;

    uint256 private _totalSupply; // 총 발행할 NFT 수

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    // 소유자 확인
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    // 잔고 확인
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Zero address not allowed");
        return _balances[owner];
    }

    // 민팅
    function mint(address to) public {
        require(to != address(0), "Invalid address");
        uint256 tokenId = _totalSupply + 1; // 토큰 아이디는 1부터 시작
        _owners[tokenId] = to;
        _balances[to] += 1;
        _totalSupply++;

        emit Transfer(address(0), to, tokenId);
    }

    // 총 발행량 확인
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}