
*** Settings ***
Force Tags        faker
Test Timeout      1 minute
Library           FakerLibrary    fi_FI
Library           OperatingSystem
Library           String
Library           Collections
Library           Dialogs


*** Variables ***
# file name with path
${filename}=        ./test.txt
# number of name we genarate
${number} =    5



*** Test Cases ***

Remove an existing file
    [Documentation]  Remove Existing Address File, File name is Global
    # Remove file that Existing with file name of ${filename}
    ${state} =    Remove Existing Address File    ${filename}
    # State File Existed or not before
    Log To Console  ${state} 
    
Create a new address file
    [Documentation]  Get Random name and create and insert into file 
    # get the random name from keyword  
    @{list} =    Get Random Names    ${number}

    # chose from the random name 
    ${name} =	Get Selections From User    Please select:   @{list}

    # address contain street name and postcode and city 
    ${Address} =	FakerLibrary.Address

    # second line contains postcode and city, 1 index 
    ${line2}=    Get Line     ${Address}    1

    # Split the String thats contains postcode and city, by SPACE
    @{post_code_city}    Split String	${line2}	${SPACE}

    # First line contains street name, 0 index 
    ${Address} =    Get Line     ${Address}    0
    
    # create and store the information into file 
    Create File    ${fileName}  ${name}[0] \n${Address} \n${post_code_city}[0] \n ${post_code_city}[1]

    # check if the file created using "File Should Exist"
    File Should Exist     ${fileName}

    # check file is not Empty using "File Should Not Be Empty"
    File Should Not Be Empty     ${fileName}

Checks that the address file contains three lines

    ${FileContent}=     Get file     ${fileName}
    # check the file have three lines, by checking forth or last line by index 3
    ${FileContent}=     Get Line     ${FileContent}    ${3}




*** Keywords ***

Get Random Names
    [Arguments]    ${number_of_name}
    # This list for storing list of names 
    @{list_of_name}    Create List
    
    # Get Random name by give ${number_of_name} = 5
	FOR    ${i}    IN RANGE    0    ${number_of_name}
        # Assign Random name from FakerLibrary to ${name}
        ${name}=    FakerLibrary.Name

        Should Not Be Empty    ${name}
        # Append To List name to list ${list_of_name} 
        Append To List     ${list_of_name}    ${name}
    END

    Should Not Be Empty    ${list_of_name}

    [RETURN]    ${list_of_name} 

Remove Existing Address File
    [Arguments]    ${file_Name}
    Log To Console   ${file_Name}
    # get ture or false by given file name 
    ${state}=    Run Keyword And Return Status    File Should Not Exist      ${file_Name}
    # if file Exist then romve the file, and Show thw first line (name)
    IF  ${state} != ${true}
        ${FileContent}=     Get file     ${file_Name}   
        ${FileContent}=     Get Line     ${FileContent}    ${0}
        Remove File    ${file_Name}
        File Should Not Exist   ${file_Name}
        Log To Console  \n\n Display name of the person whose data is removed in File \n ${FileContent}
    END
    [RETURN]    ${state}