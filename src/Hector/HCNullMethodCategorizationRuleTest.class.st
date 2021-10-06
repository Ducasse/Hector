"
A NullMethodCategorizationRuleTest is not a really exciting test. It just test that the nullMethodCategorisation strategy does nothing.
"
Class {
	#name : #HCNullMethodCategorizationRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rule'
	],
	#category : #Hector
}

{ #category : #'test support' }
HCNullMethodCategorizationRuleTest >> mockClass [

	^HCMockClass
]

{ #category : #'setup/teardown' }
HCNullMethodCategorizationRuleTest >> setUp [

	rule := HCNullMethodCategorizationRule new
]

{ #category : #tests }
HCNullMethodCategorizationRuleTest >> testAppliesTo [

	self 
		assert: (rule canBeAppliedTo: 
					(RGMethodDefinition 
							class: self mockClass 
							selector: #selectorForTesting)) 
		description: 'Always returns true'
]

{ #category : #tests }
HCNullMethodCategorizationRuleTest >> testCategorize [

	self 
		shouldnt: [ rule categorizeMethod: 
							(RGMethodDefinition class: self mockClass selector: #selectorForTesting) ] 
		raise: Exception
	

]
