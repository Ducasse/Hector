"
This is a null rule that does nothing.

See also:
Search on the web for ""Null Object Pattern"".
"
Class {
	#name : #HCNullMethodCategorizationRule,
	#superclass : #HCMethodCategorizationRule,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #Hector
}

{ #category : #initialization }
HCNullMethodCategorizationRule class >> initialize [

	self initializeUniqueInstance
]

{ #category : #initialization }
HCNullMethodCategorizationRule class >> initializeUniqueInstance [

	uniqueInstance := super new
]

{ #category : #'instance creation' }
HCNullMethodCategorizationRule class >> new [

	^self uniqueInstance
]

{ #category : #initialization }
HCNullMethodCategorizationRule class >> uniqueInstance [

	uniqueInstance isNil ifTrue: [ self initializeUniqueInstance ].
	
	^uniqueInstance
]

{ #category : #testing }
HCNullMethodCategorizationRule >> canBeAppliedTo: aMethodReference [

	^true
]

{ #category : #evaluating }
HCNullMethodCategorizationRule >> categorizeMethod: aMethodReference [

	^nil
]
