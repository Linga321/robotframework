*** Settings ***
Library           MorseDecoderLibrary.py       ${port1}       ${port2}
Library			  OperatingSystem
Library           String

*** Variables ***
${port1}          
${port2}
       

***Keywords***
My test 
	[Arguments]			${arg_speed}      				${arg_text}      		
	Set Speed    		${arg_speed}
    Send text    		${arg_text}
	Verify speed 		${arg_speed}	
	${text}   	 		Replace String Using Regexp     ${arg_text}     [^a-zA-Z0-9 ]    X  
	${expected_text}    Convert to Upper Case  			${text} 
	Text should be    	${expected_text}
	#Speed should be     ${arg_speed}

Turn off	
	disable 

Turn on	
	enable

Verify 
	Verify speed
