*** Settings ***
Documentation    

*** Variables ***
@{FRUTAS}        laranja    maçã    uva    banana

*** Test Cases ***
Exibir Frutas
    FOR    ${fruta}    IN    @{FRUTAS}
        Log To Console    ${fruta}
    END