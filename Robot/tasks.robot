*** Settings ***
Documentation       Template robot main suite.
Library     Collections
Library     RPA.Browser
Library     RPA.Excel.Files

* Keywords *

Create Excel Report
    Create Workbook    reports.xlsx
    Save Workbook

Read Excel
    Open WorkBook  robot_scrape_list.xlsx
    ${list}     Read Worksheet      header=True
    Log To Console      ${list}
    Close WorkBook
    FOR     ${index}    IN      @{list}
        Search Cars    ${index}
    END

Search Cars
    [Arguments]    ${index}
    Go To   %{C_URL}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath:/html/body/div[1]/div/main/div[2]/div[2]/div[1]/div/div[1]/form/div[1]/div[1]/div/div/div/div/div/div[1]/div[2]
    Click Element    xpath:/html/body/div[1]/div/main/div[2]/div[2]/div[1]/div/div[1]/form/div[1]/div[1]/div/div/div/div/div/div[1]/div[2]
    Press Keys    NONE    ${index}[make]
    Sleep    1s
    Press Keys    NONE    TAB
    Press Keys    NONE    TAB
    Sleep    1s
    Press Keys    NONE    ${index}[model]
    Press Keys    NONE    TAB
    Sleep    1s
    Press Keys    NONE    TAB 
    Sleep    1s
    Press Keys    NONE    ${index}[max_km]
    Sleep    1s
    Click Element    xpath:/html/body/div[1]/div/main/div[2]/div[2]/div[1]/div/div[1]/form/div[2]/div[1]/button
    Sleep    3s
#Click sort
    Click Element    xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[1]/div[4]/div[1]/div[3]/div/div
    Sleep    500ms
    Click Element    xpath:/html/body/div[9]/div/div/div/div[2]/div/div/div[1]/span
    Sleep    3s

    ${name}    Get Text    xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[1]/h4
    Sleep    1s
    ${total_km}    Get Text    xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[2]/div[1]/div/div[3]/div/div/p
    Sleep    1s
    ${price}    Get Text    xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[4]/div[3]/div/div/div/div/div/h4
    Sleep    1s
    ${country}    Get Text    xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[4]/div[1]/div/div[2]/div[1]/div/p
    Sleep    1s
    ${fuel}    Get Text   xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[2]/div[1]/div/div[5]/div/div/p
    Sleep    1s
    ${transmision}    Get Text    xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[2]/div[1]/div/div[4]/div/div/p
    Sleep    1s

    ${car_dict}    Create Dictionary
    ...    name: ${name}
    ...    km: ${total_km} 
    ...    price: ${price}
    ...    city: ${country}
    ...    fuel: ${fuel}
    ...    trans: ${transmision}
    Log To Console    ${car_dict}
    Append to Excel    ${car_dict}
Append to Excel
    [Arguments]    ${car_dict}
    Open Workbook    reports.xlsx
    Append Rows To Worksheet    ${car_dict}    #header=True
    Save Workbook


* Tasks *
Main
    Create Excel Report
    Open Available Browser
    Read Excel
    Close All Browsers