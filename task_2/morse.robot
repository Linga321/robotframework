*** Settings ***
Documentation     Morse transmitter test
Library           string
Library           MorseDecoderLibrary.py
Test Template     Morse Decoder Tester

*** Variables ***
${Speed}=    50
${HighSpeed}=   200
${TestNumber}=   12345


*** Test Cases ***                   Speed      Text                        Speed should be   Text should be

TestCase Normal                      ${Speed}        Hello world                ${Speed}               HELLO WORLD
TestCase Uppercase                   ${Speed}        HELLO WORLD                ${Speed}               HELLO WORLD
TestCase Special Character           ${Speed}        Test @#$%!                 ${Speed}               TEST XXXXX
TestCase High Speed                  ${HighSpeed}    Test High Speed            ${HighSpeed}           TEST HIGH SPEED
TestCase Numbers                     ${Speed}        ${TestNumber}              ${Speed}               ${TestNumber} 


*** Keywords ***

Morse Decoder Tester

    [Arguments]   ${SetSpeed}   ${SetText}   ${ExpectedSpeed}   ${ExpectedText}
    Set Speed           ${SetSpeed}
    Send text           ${SetText}
	Speed should be     ${ExpectedSpeed}
	Text should be      ${ExpectedText}
