*** Settings ***
Documentation     Configurações gerais
Library           Collections

*** Variables ***
&{DADOS_PESSOAIS}    nome=João Silva    idade=30    rua=Rua das Flores    numero=123    cep=12345-678    bairro=Centro    cidade=São Paulo    estado=SP

${CURRENT_YEAR}    2024  # Atualize para o ano atual
@{IDADES}    40    35    60    25

@{FRUTAS}    laranja    maçã    uva    banana

${START}    0
${END}      10
${STEP}     1

&{credenciais}    Usuario=Elis    Senha=123_456

*** Test Cases ***
Exibir Informações do Dicionário
    [Documentation]    Teste para exibir informações do dicionário no console
    Log To Console    \n
    Log To Console    Nome: ${DADOS_PESSOAIS["nome"]}
    Log To Console    Idade: ${DADOS_PESSOAIS["idade"]}
    Log To Console    Rua: ${DADOS_PESSOAIS["rua"]}
    Log To Console    Número: ${DADOS_PESSOAIS["numero"]}
    Log To Console    CEP: ${DADOS_PESSOAIS["cep"]}
    Log To Console    Bairro: ${DADOS_PESSOAIS["bairro"]}
    Log To Console    Cidade: ${DADOS_PESSOAIS["cidade"]}
    Log To Console    Estado: ${DADOS_PESSOAIS["estado"]}
    [Tags]    a_executar



Exibir Frutas
    [Tags]    a_executar
    FOR    ${fruta}    IN    @{FRUTAS}
        Log To Console    ${fruta}
    END

Count Even Numbers
    [Tags]    a_executar
    ${count}=    Set Variable    0
    ${end_plus_one}=    Evaluate    ${END} + 1
    FOR    ${i}    IN RANGE    ${START}    ${end_plus_one}    ${STEP}
        IF    ${i} % 2 == 0
            ${count}=    Evaluate    ${count} + 1
        END
    END
    Log To Console    There are ${count} even numbers between ${START} and ${END}.

Exemplo de Alteração de Senha
    [Setup]    Setup Credenciais
    Log    Dicionário com senha alterada para: ${credenciais}
    [Teardown]    Teardown Credenciais
    [Tags]    a_executar

*** Keywords ***
Setup Credenciais
    Log    Senha antes da alteração: ${credenciais}[Senha]
    Set To Dictionary    ${credenciais}    Senha=654_321

Teardown Credenciais
    Log To Console    Senha antes da restauração: ${credenciais}[Senha]
    Set To Dictionary    ${credenciais}    Senha=123_456
    Log To Console    Senha restaurada no dicionário original para: ${credenciais}
