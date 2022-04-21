*** Settings ***
Documentation     Data driven style 
...               Assignment 3
...               Manish Subedi 
...               Try this one
Test Template     My test
Resource          myres.resource
Test Setup        Turn off
Test Teardown     Turn on


*** Test Cases ***		Speed 			Text
high and long			50				Today is a wonderful day!				


