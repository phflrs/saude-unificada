const web3 = new Web3("HTTP://127.0.0.1:7545");
const contractInstanceAddress = '0x79A75680d859BdD1EEF9226ea112d23d3B556f26';
const abi = [ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "inputs": [ { "internalType": "address", "name": "_patientWallet", "type": "address" }, { "internalType": "string", "name": "_name", "type": "string" } ], "name": "setPacientName", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_patientWallet", "type": "address" }, { "internalType": "address", "name": "_doctorWallet", "type": "address" } ], "name": "addDoctorOnList", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_patientWallet", "type": "address" }, { "internalType": "address", "name": "_doctorWallet", "type": "address" } ], "name": "getMedicalRecord", "outputs": [ { "internalType": "string[]", "name": "", "type": "string[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_patientWallet", "type": "address" }, { "internalType": "address", "name": "_doctorWallet", "type": "address" } ], "name": "getPacientName", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_doctorWallet", "type": "address" } ], "name": "getAllAuthorizedPacientsByDoctor", "outputs": [ { "internalType": "address[]", "name": "", "type": "address[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_patientWallet", "type": "address" }, { "internalType": "address", "name": "_doctorWallet", "type": "address" }, { "internalType": "string", "name": "_medicalRecordJSON", "type": "string" } ], "name": "addMedicalRecord", "outputs": [], "stateMutability": "nonpayable", "type": "function" } ];
const contract = new web3.eth.Contract(abi, contractInstanceAddress);

let pacientWallet = "0x8616d69252A16addbd464866277177002fFC3E62";
let doc1Wallet = "0xec91C5876C47CedF8b50bf531340f05b0b49D1D1";
let doc2Wallet = "0x9d83E9DfB8c5a36919D23A58f5553d383997D1CE";


async function getPacientName() {
    let response = await contract.methods.getPacientName(pacientWallet, doc1Wallet).send({from: pacientWallet});
    console.log("paciente nome", response);
}
async function getPacientName() {
    let response = await contract.methods.setPacientName(pacientWallet, "Gilson").send({from: pacientWallet});
    console.log("Nome registrado", response);
}
async function addDoctorOnList() {
    let response = await contract.methods.addDoctorOnList(pacientWallet, doc1Wallet).send({from: pacientWallet});
    console.log("add doc", response);
}
async function addMedicalRecord() {
    let response = await contract.methods.addMedicalRecord(pacientWallet, doc1Wallet,"xxx").send({from: pacientWallet, gas: 3000000});
    console.log("add mR", response);
}
async function getAllAuthorizedPacientsByDoctor() {
    let response = await contract.methods.getAllAuthorizedPacientsByDoctor(doc1Wallet);
    console.log("athorizados", response);
}
async function getMedicalRecord() {
    let response = await contract.methods.getMedicalRecord(pacientWallet, doc1Wallet).call()
    console.log("medical record link",response);
}
