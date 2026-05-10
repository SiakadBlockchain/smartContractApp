# Tahapan Membangun Infrastruktur SIAKAD Blockchain

1. Membangun Private Subnet (Lokal)
2. IPFS Sebagai Penyimpanan PDF Ijazah
3. Smart Contract Solidity
4. Publik Verifikasi Via C-Chain
5. Backend API
6. Frontend

# Software & Dependensi Wajib

1. Node JS
2. Git 
3. Docker Desktop (WSL 2 Backend & Virtualization BIOS)
4. Avalanche CLI

# Instalasi WSL & Avalanche dan Menjalankan Server Avalanche (WSL / Ubuntu)

cmd

1. wsl --install

bash 

2. curl -sSfL https://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s
3. echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
4. source ~/.bashrc
5. which avalanche
6. avalanche --version
7. avalanche network start
8. pkill avalanchego (Untuk Menghentikan Paksa Proses Avalanche yang berjalan)
9. avalanche network stop (Untuk mematikan jaringan)

# Membuat Private Subnet di Windows

1. avalanche blockchain create siakadChain
 > Subnet-EVM
 > Proof Of Authority
 > Get address from an existing stored key (created from avalanche key create or avalanche key import)
 > ewoq
 > Validator Manager Contract owner address 0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC
 > I want to use defaults for a test environment
 > Chain ID: 62001
 > Token Symbol: SIAKAD
2. avalanche blockchain deploy siakadChain
3. avalanche blockchain list
4. Koneksikan dengan MetaMask untuk Test Kirim Transaksi (Opsional)

WALLET CONNECTION
=================
 > Network RPC URL = http://127.0.0.1:9654/ext/bc/2wAqwqS41Jky2vJrnJVqs7FW3bYMRwXa7NLCUSQLu1K8hLonuh/rpc
 > Network Name = siakadChain
 > Chain ID = 62001
 > Token Symbol = SIAKAD
 > Token Name = SIAKAD Token

# Integrasi Jaringan Blockchain dengan MetaMask

1. avalanche blockchain describe siakadChain
2. Import Akun Ke Meta Mask Menggunakan Private Key Ewoq
3. Testing Kirim Token Dari Akun Import Ke Akun Alternatif

# Menambahkan Validator / Node (Untesting)

1. avalanche blockchain addValidator siakadChain
2. avalanche network status
3. avalanche network join (Jika di CLI Lain)

# Membangun Smart Contract

1. Menggunakan HardHat+Solidity untuk membuat Smart Contract
2. npm init -y (Inialisasi Node Package Manager)
3. npm install --save-dev hardhat
4. npx hardhat --init
> Version hardhat-3
> Path : .
> ESM Projects : true
5. npm install --save-dev "@types/node@^22.8.5" "typescript@~5.8.0" << Otomatis
> Seteleah hardhat --init akan membuat folder hardhat beserta isinya memuat harhat.config.ts yang harus dikonfigurasi ulang sesuai dengan private key pada file .env dan juga rpc url avalance
6. npm i dotenv ethers (Manual tanpa menggunakan toolbox)
7. tambahkan folder contracts (file contracts yang akan dibuat) dan folder script (file deploy.ts)
8. avalanche blockchain deploy siakadChain (lakukan deploy ulang jika jaringan berlajan di vm id bukan di rpc url avalance) 
9. npx hardhat compile
> Perintah Uji Coba Smart Contract Untuk Cek RPC Valid atau tidak | {"result":"0x..."} > Valid
> curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' ^ -H "content-type:application/json;" ^ http://127.0.0.1:9654/ext/bc/LtfgTv2tY6f3PUefYWjEaUXcqBr93wT5YYLDPD1EtZzdjP98L/rpc
10. npx hardhat run scripts/deploy.ts --network siakad
> Jaringan network wajib di start terlebih dahulu
> Contract deployed to: 0x4Ac1d98D9cEF99EC6546dEd4Bd550b0b287aaD6D
> Contract deployed to: 0xA4cD3b0Eb6E5Ab5d8CE4065BcCD70040ADAB1F00
> Contract deployed to: 0xa4DfF80B4a1D748BF28BC4A271eD834689Ea3407
> Deploy Kontrak Selesai
11. Contract Deployed
> -----------------------------------------------
> DiplomaStorage deployed!
> Contract Address  : 0xe336d36FacA76840407e6836d26119E1EcE0A2b4
> Network RPC       : http://127.0.0.1:9654/ext/bc/LtfgTv2tY6f3PUefYWjEaUXcqBr93wT5YYLDPD1EtZzdjP98L/rpc
> Deployer          : 0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC
> -----------------------------------------------
12. Cara cek Jumlah Transaksi dan block di jaringan Blockchain
> curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getTransactionByHash", "params":["0xa97aaef84ce1442cbf28baebc1267d59ff8f34dc8aacac2c235a57a681fcf3c6"], "id":1 }' -H "Content-Type: application/json" http://127.0.0.1:9654/ext/bc/LtfgTv2tY6f3PUefYWjEaUXcqBr93wT5YYLDPD1EtZzdjP98L/rpc
> Output : {"jsonrpc":"2.0","id":1,"result":"0xd"}

# Daftar Perintah Avalanche
> avalanche blockchain describe siakadChain > (Cek Private Key (Ewoq)) / Detail Jaringan
> avalanche blockhain list > (Cek RPC URL)
> avalanche network status > (Cek RPC URL)
> avalanche network start > (Start Jaringan)
> avalanche network stop > (Stop Jaringan)
> avalanche blockchain deploy siakadChain > (Deploy Jaringan Blockchain)
> pkill avalanchego (Untuk Menghentikan Paksa Proses Avalanche yang berjalan)

# Instalasi IPFS (Daemon)

1. wget https://dist.ipfs.tech/kubo/v0.28.0/kubo_v0.28.0_linux-amd64.tar.gz
2. tar -xvzf kubo_v0.28.0_linux-amd64.tar.gz
3. cd kubo
4. sudo bash install.sh
5. ipfs daemon
> Buat server backend yang mengelola upload file pdf ke IPFS untuk mendapatkan CID
> Contoh format valid file yang berhasil diupload
> {
  > "filename": "tes.pdf",
  > "cid": "Qma9sF4T5mwDyr6bRCv71kVKFPVpisCkmCAcdh5w7JgGHv",
  > "ipfs_url": "https://ipfs.io/ipfs/Qma9sF4T5mwDyr6bRCv71kVKFPVpisCkmCAcdh5w7JgGHv"
> }
> Link Akses Lokal : http://127.0.0.1:8080/ipfs/Qma9sF4T5mwDyr6bRCv71kVKFPVpisCkmCAcdh5w7JgGHv
