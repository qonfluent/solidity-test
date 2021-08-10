(async () => {
try {

// Functions
function dateToUnixTimestamp(d) {
    return parseInt((d.getTime() / 1000).toFixed(0))
}

async function getContractFactory(contractName) {
    const fileName = 'browser/artifacts/'.concat(contractName,'.json')
    console.log("getContractFactory retrieving file ", fileName)
    const metadata = JSON.parse(await remix.call('fileManager', 'getFile', fileName))
    let factory = new ethers.ContractFactory(metadata.abi, metadata.data.bytecode.object, signer);
    return factory;
}

// Global constants
const BigNumber = ethers.utils.BigNumber;
const WeiPerEth = new BigNumber("1000000000000000000");

// Contract addresses
const fishAddr = '0x30BCd71b8d21FE830e493b30e90befbA29de9114'

// Attach to signer
const signer = (new ethers.providers.Web3Provider(web3Provider)).getSigner()
const signerAddr = await signer.getAddress()
console.log("Connected to signer ", signerAddr)

// Load all contracts
const castle = await getContractFactory("Castle")
const govFactory = await getContractFactory("GovernorAlpha")
const lockFactory = await getContractFactory("TimeLock")

// Figure out addresses of contracts
const castleTxn = castle.getDeployTransaction()
const lockTxn = lock.getDeployTransaction()
const govTxn = gov.getDeployTransaction()

console.log("Castle transaction: ", castleTxn)
console.log("Lock transaction: ", lockTxn)
console.log("Gov transaction: ", govTxn)

// NOTE: Not sure if we will need this, but we can use it to get consistent nonces
// const baseNonce = signer.getTransactionCount("pending");

const castleAddr = ethers.utils.getContractAddress({ from: signerAddr, nonce: castleTxn.nonce })
const lockAddr = ethers.utils.getContractAddress({ from: signerAddr, nonce: lockTxn.nonce })
const govAddr = ethers.utils.getContractAddress({ from: signerAddr, nonce: govTxn.nonce })

// RFI: Not sure if the fish should go to the signer or lock account
const castle = castleFactory.deploy("Castle", "CASTLE", 18, 25, 10000, signerAddr, fishAddr)
const lock = lockFactory.deploy(govAddr, 14 days)
const gov = govFactory.deploy(lockAddr, castleAddr, signerAddr)

// Cleanup
} catch(e) {
    console.log(e)
    throw "fail";
}
})()
