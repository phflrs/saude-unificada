// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

struct Pacient_t {
    string name;
    string[] medicalRecords;
    mapping (address => bool) authorizedDoctors; 
}

struct Doctor_t {
    address[] authorizedPacients;
}

contract MedicalRecords {
    mapping(address => Pacient_t) private pacientMapping;
    mapping(address => Doctor_t) private doctorMapping;
    string[] private ERRO = ["ERRO: ACESSO NEGADO"];
    constructor() {
    }
    // seta nome do paciente na struct Pacient_t
    function setPacientName(address _patientWallet, string memory _name) public returns (string memory)
    {   
        if(_patientWallet == msg.sender) {
            pacientMapping[_patientWallet].name = _name;
        }
        return "ERRO: ACESSO NEGADO";
    }
    // Adiciona medico na lista de medicos permitidos
    function addDoctorOnList(address _patientWallet, address _doctorWallet) public
    {   
        pacientMapping[_patientWallet].authorizedDoctors[_doctorWallet] = true;
        doctorMapping[_doctorWallet].authorizedPacients.push(_patientWallet);
    }
    // Retorna o prontuario do paciente
    function getMedicalRecord(address _patientWallet, address _doctorWallet) public view returns (string[]memory)
    {   
        if(verifyIfDoctorIsAllowed(_patientWallet, _doctorWallet)) {
            return pacientMapping[_patientWallet].medicalRecords;
        }
        return ERRO;
    }
    // Retorna o nome do paciente na struct Pacient_t
    function getPacientName(address _patientWallet, address _doctorWallet) public view returns (string memory)
    {   
        if(verifyIfDoctorIsAllowed(_patientWallet, _doctorWallet)) {
            return pacientMapping[_patientWallet].name;
        }
        return "ERRO: ACESSO NEGADO";
    }
    // Retorna todos os pacientes cujo médico tem acesso
    function getAllAuthorizedPacientsByDoctor(address _doctorWallet) public view returns (address[] memory)
    {   
       // if(_doctorWallet == msg.sender) { //medida de segurança que depois tem que descomentar
            return doctorMapping[_doctorWallet].authorizedPacients;
       // }
    }

    // Adiciona prontuário médico
    function addMedicalRecord(address _patientWallet,address _doctorWallet, string memory _medicalRecordJSON) public
    {   
        if(verifyIfDoctorIsAllowed(_patientWallet, _doctorWallet)) {
            pacientMapping[_patientWallet].medicalRecords.push(_medicalRecordJSON);
        }
    }

    // Verifica se o medico pode pegar os dados.
    function verifyIfDoctorIsAllowed(address _patientWallet,address _doctorWallet) private view returns (bool)
    {   
        if(pacientMapping[_patientWallet].authorizedDoctors[_doctorWallet]) 
            return true;
        return false;
    }
}
