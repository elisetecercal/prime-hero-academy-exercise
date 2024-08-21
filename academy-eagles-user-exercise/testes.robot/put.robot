*** Settings    ***
Documentation   Mudar status para false

Library     RequestsLibrary
Library     String
Library     Collections
Library     BuiltIn


*** Variables   ***
${baseUrl}      https://quality-eagles.qacoders-academy.com.br/api
${token}
${id_user}


*** Test Cases  ***

Mudar Status False
    Put Status False

*** Keywords    ***
Criar sessao
    ${headers}  Create Dictionary     accept=application/json     Content-Type=application/json
    Create Session  alias=develop       url=${baseUrl}      headers=${headers}      verify=true

Pegar Token
    ${body}     Create Dictionary       mail=sysadmin@qacoders.com      password=1234@Test
    Log     ${body}
    Criar sessao
    ${resposta}     POST On Session     alias=develop   url=/login      json=${body}
    #Log To Console      ${resposta}
    #Log To Console      ${resposta.json()["token"]}
    Status Should Be    200     ${resposta}
    RETURN                      ${resposta.json()["token"]}

Put Status False
    ${token}    Pegar Token
    ${body}     Create Dictionary   status=false
    PUT On Session  alias=develop   url=/user/${id_user}?token=${token}     json=${body}


