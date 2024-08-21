*** Settings ***
Documentation   Criar e Validar Novo Usuario
Library         RequestsLibrary
Library         String
Library         Collections
Library         BuiltIn
Library         resources/resource_generator.py

*** Variables ***
${baseUrl}      https://quality-eagles.qacoders-academy.com.br/api

*** Test Cases ***
Criar e Validar Novo Usuario
    Criar Sessao
    Realizar Login
    Validar Token
    Criar Novo Usuario

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

Validar Token
    ${headers}=  Create Dictionary   Authorization=Bearer ${token}   accept=application/json
    ${resposta}=  GET On Session  alias=develop   url=/validateToken  headers=${headers}
    Log To Console  ${resposta.json()}  # Loga a resposta completa para análise
    Status Should Be  200  ${resposta}

Criar Novo Usuario
    Realizar Login
    ${headers}=    Create Dictionary    accept=application/json
    ${firstName}=  Evaluate    resource_generator.generate_first_name()
    ${lastName}=   Evaluate    resource_generator.generate_last_name()
    ${fullName}=   Evaluate    '${firstName} ${lastName}'
    ${email}=      Evaluate    resource_generator.generate_email()
    ${cpf}=        Evaluate    resource_generator.generate_cpf()
    ${password}=   Evaluate    resource_generator.generate_password()
    ${bodyUser}=   Create Dictionary    fullName=${fullName}    mail=${email}    password=${password}    accessProfile=ADMIN    cpf=${cpf}    confirmPassword=${password}   status=True
    ${resposta}=   POST On Session      alias=develop   url=/user/?token=${token}   json=${bodyUser}   headers=${headers}
    Status Should Be    201    ${resposta}
    Log To Console   ${resposta.json()["user"]["_id"]}  # Imprime o ID do novo usuário
