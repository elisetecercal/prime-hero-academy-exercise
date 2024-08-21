*** Settings ***
Documentation     Teste com alteração de senha
Library           Collections

*** Variables ***
&{credenciais}    Usuario=Elis    Senha=123_456

*** Test Cases ***
Exemplo de Alteração de Senha
    [Setup]    Setup Credenciais
    Log    Dicionário com senha alterada para: ${credenciais}
    [Teardown]    Teardown Credenciais

*** Keywords ***
Setup Credenciais
    Log    Senha antes da alteração: ${credenciais}[Senha]
    Set To Dictionary    ${credenciais}    Senha=654_321

Teardown Credenciais
    Log To Console    Senha antes da restauração: ${credenciais}[Senha]
    Set To Dictionary    ${credenciais}    Senha=123_456
    Log To Console    Senha restaurada no dicionário original para: ${credenciais}
