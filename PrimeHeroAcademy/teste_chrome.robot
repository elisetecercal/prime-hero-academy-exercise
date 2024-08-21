*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.google.com
${aceitarTudo}  //*[(contains(text(), 'Aceitar tudo'))]
${searchBox}    //*[@id="APjFqb"]
${pesquisaButton}  //*[(contains(text(), 'Pesquisa Google'))]

*** Test Cases ***
Open Google and Search
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    # Accept Cookies
    Click Element    ${aceitarTudo}
    # Input Search Text
    Input Text  ${searchBox}  Robot Framework
    # Click on the Google Search button
    Click Element  ${pesquisaButton}
    # Wait for search results to load
    Sleep  2 seconds
