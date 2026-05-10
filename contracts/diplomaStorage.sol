// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DiplomaStorage {

    enum Status { Valid, Revoked }

    struct Diploma {
        string id;             // Mapping ke id (UUID)
        string studentId;      // Mapping ke student_id
        string universityId;   // Mapping ke university_id
        string diplomaNumber;  // Mapping ke diploma_number
        string ipfsCid;        // Mapping ke ipfs_cid
        string documentHash;   // Hash dokumen untuk verifikasi integritas
        Status status;         // Enum valid (0) atau revoked (1)
        uint256 issuedAt;      
    }

    // Menggunakan documentHash sebagai key untuk pencarian cepat
    mapping(string => Diploma) public diplomas;

    event DiplomaAdded(string indexed documentHash, string diplomaNumber, Status status);
    event StatusUpdated(string indexed documentHash, Status newStatus);

    function tambahIjazah(
        string memory _id,
        string memory _studentId,
        string memory _universityId,
        string memory _diplomaNumber,
        string memory _ipfsCid,
        string memory _documentHash,
        uint256 _issuedAt
    ) public {
        // Mencegah duplikasi data berdasarkan hash dokumen
        require(bytes(diplomas[_documentHash].documentHash).length == 0, "Diploma dengan hash ini sudah ada");

        diplomas[_documentHash] = Diploma({
            id: _id,
            studentId: _studentId,
            universityId: _universityId,
            diplomaNumber: _diplomaNumber,
            ipfsCid: _ipfsCid,
            documentHash: _documentHash,
            status: Status.Valid,
            issuedAt: _issuedAt
        });

        emit DiplomaAdded(_documentHash, _diplomaNumber, Status.Valid);
    }

    function updateStatus(string memory _documentHash, Status _status) public {
        require(bytes(diplomas[_documentHash].documentHash).length > 0, "Diploma tidak ditemukan");
        diplomas[_documentHash].status = _status;
        
        emit StatusUpdated(_documentHash, _status);
    }

    function getDiploma(string memory _documentHash)
        public
        view
        returns (Diploma memory)
    {
        return diplomas[_documentHash];
    }
}