*** Settings ***
Documentation   Deletar usuário existente com DELETE request
Library         RequestsLibrary
Library         String
Library         Collections
Library         BuiltIn
Library         resources/resource_generator.py

*** Variables ***
${baseUrl}      https://quality-eagles.qacoders-academy.com.br/api
${userId}       none  # ID do usuário recém-criado
${token}        none

*** Test Cases ***
Deletar Usuario
    Criar Sessao
    Realizar Login
    Criar Novo Usuario
    Delete User


*** Keywords ***
Criar Sessao
    ${headers}=  Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session  alias=develop   url=${baseUrl}   headers=${headers}   verify=true

Realizar Login
    ${body}=     Create Dictionary     mail=sysadmin@qacoders.com     password=1234@Test
    ${resposta}=     POST On Session     alias=develop   url=/login/   json=${body}
    Status Should Be    200    ${resposta}
    ${token}=    Get From Dictionary    ${resposta.json()}    token
    Set Global Variable    ${token}    ${token}
    Log To Console  Token obtido: ${token}

Criar Novo Usuario
    Realizar Login
    ${headers}=    Create Dictionary    accept=application/json    Authorization=Bearer ${token}
    ${firstName}=  Evaluate    resource_generator.generate_first_name()
    ${lastName}=   Evaluate    resource_generator.generate_last_name()
    ${fullName}=   Set Variable    ${firstName} ${lastName}
    ${email}=      Evaluate    resource_generator.generate_email()
    ${cpf}=        Evaluate    resource_generator.generate_cpf()
    ${password}=   Evaluate    resource_generator.generate_password()
    ${bodyUser}=   Create Dictionary    fullName=${fullName}    mail=${email}    password=${password}    accessProfile=ADMIN    cpf=${cpf}    confirmPassword=${password}   status=True
    ${resposta}=   POST On Session      alias=develop   url=/user/?token=${token}   json=${bodyUser}   headers=${headers}
    Status Should Be    201    ${resposta}

    ${userId}=       Get From Dictionary    ${response.json()}    user._id
    Log    User ID: ${userId}
    Set Global Variable    ${userId}    ${userId}

Delete User
    DELETE On Session    alias=develop    url=/user/${userId}?token=${token}
    Status Should Be    200
    Log To Console  User ${userId} deletado com sucesso.


