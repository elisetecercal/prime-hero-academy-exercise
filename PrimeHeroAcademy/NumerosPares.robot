*** Settings ***
Library    Collections

*** Variables ***
${START}    0
${END}      10
${STEP}     1


*** Test Cases ***
Count Even Numbers
    ${count}=    Set Variable    0
    ${end_plus_one}=    Evaluate    ${END} + 1
    FOR    ${i}    IN RANGE    ${START}    ${end_plus_one}    ${STEP}
        IF    ${i} % 2 == 0
            ${count}=    Evaluate    ${count} + 1
        END
    END
    Log To Console   There are ${count} even numbers between ${START} and ${END}.
