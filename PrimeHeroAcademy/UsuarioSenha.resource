*** Settings ***
Documentation     Teste com alteração de senha
Library           Collections

*** Variables ***
&{credenciais}    Usuario=Elis    Senha=123_456


*** Keywords ***
Setup Credenciais
    Set To Dictionary    &{credenciais}    Senha    654_321

Teardown Credenciais
    Set To Dictionary    &{credenciais}    Senha    123_456
    Log    Senha restaurada no dicionário original: &{credenciais}
