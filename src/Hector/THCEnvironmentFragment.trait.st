"
I'm a simple trait that group together a limited interface to access all the classes and traits of the current environment.
"
Trait {
	#name : #THCEnvironmentFragment,
	#instVars : [
		'environment'
	],
	#category : #Hector
}

{ #category : #accessing }
THCEnvironmentFragment >> allClasses [

	^ environment allClasses
]

{ #category : #accessing }
THCEnvironmentFragment >> allClassesAndTraits [

	^ environment allClassesAndTraits
]

{ #category : #accessing }
THCEnvironmentFragment >> environment: anEnvironment [

	environment := anEnvironment
]

{ #category : #initialization }
THCEnvironmentFragment >> initialize [

	super initialize.
	environment := Smalltalk globals
]
