// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

struct medicalRecords_t {
    mapping (uint => string) hospitalMedicalRecordLinks;//mapeia o id do hospital para um link de um prontuário.
    mapping (address => bool) authorizedDoctors; 
}

contract MedicalRecords {
    mapping(address => medicalRecords_t) private medicalRecordsMapping;

    constructor() {
    }
    // Adiciona medico na lista de medicos permitidos
    function addDoctorOnList(address _patientWallet, address _doctorWallet) public
    {   
        medicalRecordsMapping[_patientWallet].authorizedDoctors[_doctorWallet] = true;
    }

    // Retornar o prontuario do paciente
    function getMedicalRecord(address _patientWallet, address _doctorWallet, uint _hospitalId) public view returns (string memory)
    {   
        if(verifyIfDoctorIsAllowed(_patientWallet, _doctorWallet)) {
            return medicalRecordsMapping[_patientWallet].hospitalMedicalRecordLinks[_hospitalId];
        }
        return "ERRO: Medico nao autorizado a acessar dados do paciente.";
    }

    // Caso seja a primeira vez do paciente no hospital, temos que colocar o 
    // link que referencia os prontuarios desse usuario no novo local.

    //ATENCAO: os prontuarios so devem ser atualizados caso o usuario ainda 
    //nao possua uma referencia (link) ao hospital que ele esta sendo consultado.

    // A permissao para adicionar infos esta atreladas a hospitais e nao medicos
    function addLinkInTheMedicalRecord(address _patientWallet,address _doctorWallet, uint _hospitalId, string memory _medicalRecordlink) public
    {   
        if(verifyIfDoctorIsAllowed(_patientWallet, _doctorWallet)) {
            medicalRecordsMapping[_patientWallet].hospitalMedicalRecordLinks[_hospitalId] = _medicalRecordlink;
        }
    }

    // Verifica se o medico pode pegar os dados.
    function verifyIfDoctorIsAllowed(address _patientWallet,address _doctorWallet) private view returns (bool)
    {   
        if(medicalRecordsMapping[_patientWallet].authorizedDoctors[_doctorWallet]) 
            return true;
        return false;
    }
}
