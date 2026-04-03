// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IjazahStorage {

    struct Ijazah {
        string nama;
        string nim;
        string ipfsHash;
        uint256 timestamp;
    }

    mapping(string => Ijazah) public dataIjazah;

    function tambahIjazah(
        string memory _nama,
        string memory _nim,
        string memory _ipfsHash
    ) public {
        dataIjazah[_nim] = Ijazah(
            _nama,
            _nim,
            _ipfsHash,
            block.timestamp
        );
    }

    function getIjazah(string memory _nim)
        public
        view
        returns (Ijazah memory)
    {
        return dataIjazah[_nim];
    }
}