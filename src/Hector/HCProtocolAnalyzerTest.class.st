Class {
	#name : #HCProtocolAnalyzerTest,
	#superclass : #TestCase,
	#category : #Hector
}

{ #category : #tests }
HCProtocolAnalyzerTest >> testStatisticFor [

	self assert: (HCProtocolAnalyzer new statisticFor: #printOn:) first value equals: #printing.
	
]
