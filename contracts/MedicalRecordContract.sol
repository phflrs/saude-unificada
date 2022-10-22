// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

struct medicalRecords_t {
    string value;
    address[] allowedDoctors;
}

contract MedicalRecords {
    mapping(address => medicalRecords_t) private medicalRecord;

    function addDoctorOnList(/*...*/) public
    {
        // Adiciona medico na lista de medicos permitidos
    }

    function getMedicalRecord(/*...*/) public
    {
        // Retornar o prontuario do paciente
    }

    function addLinkInTheMedicalRecord(/*...*/) public
    {
        // Caso seja a primeira vez do paciente no hospital, temos que colocar o 
        // link que referencia os prontuarios desse usuario no novo local.

        //ATENCAO: os prontuarios so devem ser atualizados caso o usuario ainda 
        //nao possua uma referencia (link) ao hospital que ele esta sendo consultado.

        // A permissao para adicionar infos esta atreladas a hospitais e nao medicos
    }

    function verifyIfDoctorIsAllowed(/*...*/) private
    {
        // Verifica se o medico pode pegar os dados.
    }
}
