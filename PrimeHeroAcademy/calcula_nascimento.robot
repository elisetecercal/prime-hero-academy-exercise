*** Settings ***
Library    Collections

*** Variables ***
${CURRENT_YEAR}    2024  # Atualize para o ano atual
@{IDADES}    40    35    60    25

*** Test Cases ***
Calcular Ano de Nascimento e Verificar Século para Múltiplas Idades
    [Documentation]    Teste que calcula o ano de nascimento e verifica se é do século passado para múltiplas idades.
    FOR    ${idade}    IN    @{IDADES}
        ${ano_nascimento}  Calcular Ano de Nascimento    ${idade}
        Log To Console    Ano de nascimento para idade ${idade} é ${ano_nascimento}
        Verificar Ano    ${ano_nascimento}
    END

*** Keywords ***
Calcular Ano de Nascimento
    [Arguments]    ${idade}
    ${ano_nascimento}=    Evaluate    ${CURRENT_YEAR} - ${idade}
    RETURN    ${ano_nascimento}

Verificar Ano
    [Arguments]    ${ano}
    Run Keyword If    ${ano} < 2000    Log To Console    Você nasceu no século passado.
    ...    ELSE    Log To Console    Você nasceu no século atual.
