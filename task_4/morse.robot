*** Settings ***
Documentation     Morse transmitter test
Library           OperatingSystem
Library           String
Resource          src/res.resource
Test Setup        Set State Off   
Test Teardown     Set State On
Default Tags      AllTest


*** Variables ***
${Speed}=    80
${TextSpeed}=   50
${tolerance}=  10  
${zeroTolerance}=  0


*** Test Cases ***                  Speed              Text                Speed should be      Text should be      tolerance in %
TestCase 1 Text Only
    [Tags]    TextOnly  AllTest  notStrict    
    Morse Decoder Tester            ${TextSpeed}       Hello world         ${TextSpeed}         HELLO WORLD         ${zeroTolerance}
    
TestCase 2 Relaxed Speed
    [Tags]    Relaxed   AllTest  notStrict
    Morse Decoder Tester            ${Speed}           Hello world         ${Speed}             HELLO WORLD         ${tolerance}
    
TestCase 3 Strict
    [Tags]    Strict    AllTest 
    ${output}=    Run Keyword And Expect Error  *   
    ...   Morse Decoder Tester      ${Speed}           Hello world         ${Speed}             HELLO WORLD         ${zeroTolerance}
    Log to Console   \n${output}

    


