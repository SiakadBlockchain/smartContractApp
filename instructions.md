# Tahapan Membangun Infrastruktur SIAKAD Blockchain

1. Membangun Private Subnet (Lokal)
2. IPFS Sebagai Penyimpanan PDF Ijazah
3. Smart Contract Solidity
4. Publik Verifikasi Via C-Chain
5. Backend API

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