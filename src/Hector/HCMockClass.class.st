"
A child class to check that the categorizer is working well.
"
Class {
	#name : #HCMockClass,
	#superclass : #HCMockParentClass,
	#instVars : [
		'accessor'
	],
	#category : #Hector
}

{ #category : #'test support' }
HCMockClass >> accessor [

	^accessor
]

{ #category : #'test support' }
HCMockClass >> otherSelectorForTesting [

	"This method is classified and unclassified by the tests, don't remove it.
	If you classify it in another category.. it doesn't matter the classification will be lost each time
	that you run the tests - DF"
]

{ #category : #'as yet unclassified' }
HCMockClass >> selectorForTesting [

	"This method is classified and unclassified by the tests, don't remove it.
	If you classify it in another category.. it doesn't matter the classification will be lost each time
	that you run the tests"
]
