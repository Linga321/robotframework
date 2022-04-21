*** Variables ***
${portsender}=    COM8
${portdecoder}=   COm7
${off}=   off
${on}=   on

*** Settings ***
Documentation     Morse transmitter test
Library           string
Library			  OperatingSystem
Library           ../MorseDecoderLibrary.py   ${portsender}   ${portdecoder}


*** Keywords ***

Morse Decoder Tester
    [Arguments]   ${SetSpeed}   ${SetText}   ${ExpectedSpeed}   ${ExpectedText}
    Set Speed           ${SetSpeed}
    Send text           ${SetText}
	Text should be      ${ExpectedText}
    check_speed         ${ExpectedSpeed}

Set State Off
    wpm state       ${off}
    imm state       ${off}

Set State On
    wpm state       ${on}
    imm state       ${on}
     
    