*** Settings ***
Documentation     Morse transmitter test
Library           string
Library           MorseDecoderLibrary.py



*** Test Cases ***                 Speed        Text                Speed should be        Text should be

TestCase Normal                      50       Hello world                 50                HELLO WORLD
TestCase Uppercase                   60       HELLO WORLD                 60                HELLO WORLD
TestCase Special Character           70       Test @#$%!                  70                TEST XXXXX
TestCase High Speed                  200      Test High Speed             200               TEST HIGH SPEED
TestCase Numbers                     70       123456                      70                123456


*** Keywords ***

Morse Decoder Tester

    [Arguments]   ${SetSpeed}   ${SetText}   ${ExpectedSpeed}   ${ExpectedText}
    Set Speed           ${SetSpeed}
    Send text           ${SetText}
	Speed should be     ${ExpectedSpeed}
	Text should be      ${ExpectedText}
