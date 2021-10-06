Class {
	#name : #HCMethodCategorizerTest,
	#superclass : #TestCase,
	#instVars : [
		'categorizationRules'
	],
	#category : #Hector
}

{ #category : #'test support' }
HCMethodCategorizerTest >> assertCategorizationOfAllMethodsWith: anAutomaticMethodCategorizer [

	| mockClassOrganization |
	mockClassOrganization := self mockClass organization.
	mockClassOrganization 
		classify: #selectorForTesting
		under: 'any'.
	self 
		assert: (mockClassOrganization categoryOfElement: #selectorForTesting) 
		equals:  'any'.
	anAutomaticMethodCategorizer categorizeAllMethodsOf: self mockClass.
	self 
		assert: (mockClassOrganization categoryOfElement: #selectorForTesting) 
		equals: self protocolForTesting
]

{ #category : #'test support' }
HCMethodCategorizerTest >> categorizationRules [
	
	^categorizationRules
]

{ #category : #'test support' }
HCMethodCategorizerTest >> globalWithTestingRules [

	^'AutoMethodCatTestGlobal'
]

{ #category : #'test support' }
HCMethodCategorizerTest >> mockClass [

	^HCMockClass
]

{ #category : #'test support' }
HCMethodCategorizerTest >> protocolForTesting [

	^#'categorizer test'
]

{ #category : #running }
HCMethodCategorizerTest >> setUp [

	self class environment 
		at: self globalWithTestingRules asSymbol 
		put: self.
	self mockClass uncategorizeAllMethods.
	self setUpCategorizationRules
]

{ #category : #running }
HCMethodCategorizerTest >> setUpCategorizationRules [

	categorizationRules := OrderedCollection new
		add: (HCMethodCategorizationRule whenSelectorMatches: #selectorForTesting asString categorizeIn: self protocolForTesting);
		add: (HCMethodCategorizationRule whenSelectorMatches: #otherSelectorForTesting asString categorizeIn: self protocolForTesting);
		yourself
]

{ #category : #running }
HCMethodCategorizerTest >> tearDown [

	self class environment removeKey: self globalWithTestingRules asSymbol
]

{ #category : #tests }
HCMethodCategorizerTest >> testCategorizationRuleFor [
	"Get a categorization rule for a given method definition"

	| returnedCategorizationRule methodCategorizer |
	methodCategorizer := HCMethodCategorizer usingRules: categorizationRules.
	returnedCategorizationRule := methodCategorizer categorizationRuleFor: (RGMethodDefinition class: self mockClass selector: #selectorForTesting).
	
	self 
		assert: categorizationRules first 
		equals: returnedCategorizationRule.	
	returnedCategorizationRule := methodCategorizer categorizationRuleFor: (RGMethodDefinition class: self mockClass selector: #otherSelectorForTesting).
	self assert: (categorizationRules at: 2) = returnedCategorizationRule.
	returnedCategorizationRule := methodCategorizer categorizationRuleFor: (RGMethodDefinition class: self mockClass selector: #printString).
	self assert: returnedCategorizationRule = HCNullMethodCategorizationRule new

]

{ #category : #tests }
HCMethodCategorizerTest >> testCategorizeAll [
	
	self assertCategorizationOfAllMethodsWith: (HCMethodCategorizer usingRules: categorizationRules)
]

{ #category : #'tests for system extensions' }
HCMethodCategorizerTest >> testHasProtocolFor [

	| mockClassOrganization |
	mockClassOrganization := self mockClass organization.
	mockClassOrganization classify: #otherSelectorForTesting under: 'any'.

	self assert: (mockClassOrganization hasProtocolFor: #otherSelectorForTesting).
	self deny: (mockClassOrganization hasProtocolFor: #NOtclaisiisifyuiiedMethodSelector).
	
	"verifies that we if classified in unclassified we get the unclassified classification."
	mockClassOrganization classify: #otherSelectorForTesting under: Protocol unclassified.
	self deny: (mockClassOrganization hasProtocolFor: #otherSelectorForTesting)
]

{ #category : #'tests for system extensions' }
HCMethodCategorizerTest >> testProtocolsFor [

	| mockClassOrganization |
	mockClassOrganization := self mockClass organization.
	mockClassOrganization classify: #otherSelectorForTesting under: 'any'.
	
	self assert: (mockClassOrganization protocolsOfSelector: #otherSelectorForTesting) first name equals: #any.
	self assert: (mockClassOrganization protocolsOfSelector: #NOtclaisiisifyuiiedMethodSelector) isEmpty.

	"verifies that we if classified in unclassified we get the unclassified classification."
	self assert: (mockClassOrganization protocolsOfSelector: #otherSelectorForTesting) first name equals: #any.
	mockClassOrganization classify: #otherSelectorForTesting under: Protocol unclassified.
	self assert: (mockClassOrganization protocolsOfSelector: #otherSelectorForTesting) first name equals: Protocol unclassified.
]
