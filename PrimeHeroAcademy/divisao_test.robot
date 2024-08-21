*** Settings ***
Test Setup     Log To Console    "Iniciando o teste de divisão"

*** Test Cases ***
Cenario: Divisão
    Dividir numero 8 por 2

*** Keywords ***
Dividir numero ${valor1} por ${valor2}
    ${resultado}    Evaluate    ${valor1} / ${valor2}
    Log To Console  O resultado da divisão é: ${resultado}
