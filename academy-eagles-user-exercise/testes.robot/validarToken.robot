*** Settings ***
Documentation   Validar Token de Autenticação
Library         RequestsLibrary
Library         String
Library         Collections
Library         BuiltIn

*** Variables ***
${baseUrl}      https://quality-eagles.qacoders-academy.com.br/api
${token}

*** Test Cases ***
Validar Token de Autenticação
    Criar Sessao
    Realizar Login      # Obtenha o token de autenticação
    Validar Token       # Valide o token obtido

*** Keywords ***
Criar Sessao
    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session  alias=develop    url=${baseUrl}    headers=${headers}    verify=true

Realizar Login
    ${body}=     Create Dictionary     mail=sysadmin@qacoders.com     password=1234@Test
    ${resposta}=  POST On Session     alias=develop   url=/login/  json=${body}
    Status Should Be    200     ${resposta}
    ${token}=    Get From Dictionary    ${resposta.json()}    token
    Set Global Variable    ${token}    ${token}
    Log To Console  Token obtido: ${token}

Validar Token
    ${headers}=  Create Dictionary    Authorization=${token}    accept=application/json
    ${resposta}=  GET On Session      alias=develop   url=/validateToken  headers=${headers}
    Status Should Be  200  ${resposta}

