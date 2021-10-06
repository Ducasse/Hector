"
Instances of this class always returns a given protocol for a method.
Such behavior is used for system wide categorisation such as all printOn: methods should be categorized into  the given protocol.
"
Class {
	#name : #HCFixedProtocolFinder,
	#superclass : #HCProtocolFinder,
	#instVars : [
		'protocol'
	],
	#category : #'Hector-Model'
}

{ #category : #'instance creation' }
HCFixedProtocolFinder class >> categorizeIn: aProtocolNameString [ 

	^self new initializeWithFixedProtocol: aProtocolNameString
]

{ #category : #'finding protocols' }
HCFixedProtocolFinder >> findProtocolsFor: aMethodReference [ 

	^ Bag with: protocol
]

{ #category : #initialization }
HCFixedProtocolFinder >> initializeWithFixedProtocol: aProtocolNameString [ 
	protocol := aProtocolNameString
]

{ #category : #printing }
HCFixedProtocolFinder >> printOn: aStream [

	aStream nextPutAll: 'Into protocol ', protocol asString
]
