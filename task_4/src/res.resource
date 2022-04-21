

*** Settings ***
Documentation     Morse transmitter test
Library           string
Library			  OperatingSystem
Library           ../MorseDecoderLibrary.py   ${portsender}   ${portdecoder}

*** Variables ***
${portsender}
${portdecoder}
${off}=   off
${on}=   on

*** Keywords ***

Morse Decoder Tester 
    [Arguments]   ${SetSpeed}   ${SetText}   ${ExpectedSpeed}   ${ExpectedText}  ${tolerance}
    Set Speed           ${SetSpeed}
    Send text           ${SetText}
	Text should be      ${ExpectedText}
    RoundUp Speed       ${ExpectedSpeed}    ${tolerance}

Set State Off
    wpm state       ${off}
    imm state       ${off}

Set State On
    wpm state       ${on}
    imm state       ${on}
     
    