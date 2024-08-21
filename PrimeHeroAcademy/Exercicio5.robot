*** Settings ***
Library  Collections

*** Variables ***
# Definindo o dicionário com as informações necessárias
&{DADOS_PESSOAIS}  nome=João Silva  idade=30  rua=Rua das Flores  numero=123  cep=12345-678  bairro=Centro  cidade=São Paulo  estado=SP

*** Test Cases ***
Exibir Informações do Dicionário
    [Documentation]  Teste para exibir informações do dicionário no console
    Log To Console  \n
    Log To Console  Nome: ${DADOS_PESSOAIS["nome"]}
    Log To Console  Idade: ${DADOS_PESSOAIS["idade"]}
    Log To Console  Rua: ${DADOS_PESSOAIS["rua"]}
    Log To Console  Número: ${DADOS_PESSOAIS["numero"]}
    Log To Console  CEP: ${DADOS_PESSOAIS["cep"]}
    Log To Console  Bairro: ${DADOS_PESSOAIS["bairro"]}
    Log To Console  Cidade: ${DADOS_PESSOAIS["cidade"]}
    Log To Console  Estado: ${DADOS_PESSOAIS["estado"]}
 

