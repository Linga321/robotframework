
*** Settings ***
Force Tags        faker
Test Timeout      1 minute
Library           FakerLibrary    fi_FI
Library           OperatingSystem
Library           String
Library           Collections
Library           Dialogs
Library           file.py   

*** Variables ***
    @{encoding}=        encoding=UTF-8 


*** Test Cases ***
Test
    
    ${number} =  Set Variable    5
    Log To Console  \n\n Display 5 Random Names
    ${list} =    Get Random Names    ${number}
    Log To Console  ${list}


    ${fileName} =  Set Variable    test.txt
    ${state} =    Remove Existing Address File    ${fileName}

    Log To Console   \n\n Is it File name Exist, then got removed: ${state}

    Create File    ${fileName}    content=${list} encoding=UTF-8
    ${fileExists}=      File Exists     ${fileName}
    Log To Console   ${fileExists}


*** Keywords ***
Get Random Names
    [Arguments]    ${number_of_name}
    @{list_of_name}    Create List

	FOR    ${i}    IN RANGE    0    ${number_of_name}
        ${name}=    FakerLibrary.Name
        Should Not Be Empty    ${name}
        Append To List     ${list_of_name}    ${name}
    END
    Should Not Be Empty    ${list_of_name}
    [RETURN]    ${list_of_name} 

Remove Existing Address File
    [Arguments]    ${fileName}
    ${fileExists}=      File Exists     ${fileName}
        
    IF   ${fileExists}
        ${FileContent}=   Get file    ${fileName}    encoding=UTF-8 
        Remove File    ${fileName}
        File Should Not Exist   ${fileName}
        Log To Console  \n\n Display name of the person whose data is removed in File \n ${FileContent}
    END
    [RETURN]    ${fileExists}