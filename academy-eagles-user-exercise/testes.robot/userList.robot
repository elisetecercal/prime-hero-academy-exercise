*** Settings ***
Documentation   Lista Usuarios

Library     RequestsLibrary
Library     String
Library     Collections
Library     BuiltIn

*** Variables ***
${baseUrl}      https://quality-eagles.qacoders-academy.com.br/api
${token}


*** Test Cases ***
Listar e Validar Usuarios
    Criar sessao
    Pegar Token
    Listagem de Usuarios

*** Keywords ***

Criar Sessao
    ${headers}=  Create Dictionary     accept=application/json     Content-Type=application/json
    Create Session  alias=develop   url=${baseUrl}   headers=${headers}   verify=true

Pegar Token
    ${body}=     Create Dictionary     mail=sysadmin@qacoders.com     password=1234@Test
    ${resposta}=  POST On Session     alias=develop   url=/login/  json=${body}
    Status Should Be    200     ${resposta}
    ${token}=    Get From Dictionary    ${resposta.json()}    token
    Set Global Variable    ${token}    ${token}
    Log To Console      ${resposta.json()["token"]}

Validar Token
    ${headers}=  Create Dictionary   Authorization=Bearer ${token}   accept=application/json
    ${resposta}=  GET On Session  alias=develop   url=${baseUrl}/validateToken  headers=${headers}
    Log To Console  ${resposta.json()}  # Loga a resposta completa para análise
    Status Should Be  200  ${resposta}

Listagem de Usuarios
    ${token}    Pegar Token
    ${headers}=    Create Dictionary    accept=application/json    Authorization=Bearer ${token}
    ${resposta}=   GET On Session       alias=develop   url=${baseUrl}/user/?token=${token}   headers=${headers}
    Status Should Be    200     ${resposta}
    ${json}=      Get From Dictionary    ${resposta.json()}    users
    Log To Console    Response JSON: ${json}
    RETURN  ${json}
