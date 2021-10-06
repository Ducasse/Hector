"
Instances of this class returns all the categories found in the super-classes of a method.
"
Class {
	#name : #HCSuperClassProtocolFinder,
	#superclass : #HCProtocolFinder,
	#category : #'Hector-Model'
}

{ #category : #'finding protocols' }
HCSuperClassProtocolFinder >> fromClasses: aMethodDefinition [

	^ aMethodDefinition realClass allSuperclasses
]
