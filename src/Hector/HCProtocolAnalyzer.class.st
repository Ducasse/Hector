"
I'm a tool to collect some analyses on selectors categorisation.

## First some simple statistics

The following shows that in the image in which this comment was written most of the printOn: messages are all categorized in printing. 

```			
HCProtocolAnalyzer new statisticFor: #printOn:  

>>> {377->#printing. 3->#accessing. 1->#ui. 1->#private. 1->#transmitting}
```

Now for initialize we see that it is not the case. 

```  
HCProtocolAnalyzer new statisticFor: #initialize  {

>>> {867->#initialization. 85->#'initialize-release'. 12->#'as yet unclassified'. 8->#initializing. 6->#accessing. 3->#'instance initalization'. 1->#'initalize-release'. 1->#testing. 1->#'class initialization'. 1->#'updating screen'. 1->#actions. 1->#drawing. 1->#displaying. 1->#tests. 1->#shout}
```

## Miscategorized methods

Now we can  get a list of all miscategorized method definitions.

```
HCProtocolAnalyzer new findInconsistenciesForASelector: #initialize thatIsNotInProtocol: 'initialization'
```

## Fixing miscategorized methods 

Now you can also fix all the method that are not consistently categorized.

``` 
HCProtocolAnalyzer new fixInconsistenciesOf: #printOn: toBeInProtocol: 'printing'		
```

## Todo

- make the analyser and fixer working on list of packages and not the complete environment. 
For this we can introduce onPackagesNamed: {} and also onFullEnvironment.






"
Class {
	#name : #HCProtocolAnalyzer,
	#superclass : #Object,
	#traits : 'THCEnvironmentFragment',
	#classTraits : 'THCEnvironmentFragment classTrait',
	#category : #Hector
}

{ #category : #analyses }
HCProtocolAnalyzer >> findClassHavingProtocolNamed: aString [ 
	"self new findClassHavingProtocolNamed: #'initialize-release'"

	^ self allClassesAndTraits select: [ :each | 
		each organization allProtocolsNames includes: aString ].
	
]

{ #category : #analyses }
HCProtocolAnalyzer >> findInconsistenciesForASelector: aSymbol thatIsNotInProtocol: aString [
	"Pay attention it filters extensions."
	
	"self new findInconsistenciesForASelector: #initialize thatIsNotInProtocol: 'initialization'"

	| implementingClasses resultingMethods |
	implementingClasses := self allClassesAndTraits select: [ :each | 
		each includesSelector: aSymbol ].
	resultingMethods := OrderedCollection new: implementingClasses size. 
	implementingClasses do: [ :each | 
			| cat |
			cat := each whichCategoryIncludesSelector: aSymbol.
			((cat beginsWith: '*') or: [ (cat = aString) ])
				ifFalse: [ resultingMethods add: ((RGMethodDefinition class: each selector: aSymbol ) protocol: cat; yourself) ] 
			 ].
	^ resultingMethods
]

{ #category : #analyses }
HCProtocolAnalyzer >> fixInconsistenciesOf: aSelector toBeInProtocol: aProtocol [
	"Changes the protocol to all the methods of selector, aSelector, to be aProtocol"
	"self new fixInconsistenciesOf: #printOn: toBeInProtocol: 'printing'"
	
	(self findInconsistenciesForASelector: aSelector thatIsNotInProtocol: aProtocol)
		do: [ :aMethodDefinition|
				aMethodDefinition realClass organization 
					classify: aMethodDefinition selector
					under: aProtocol ]

	
]

{ #category : #'may be useless' }
HCProtocolAnalyzer >> methodDefinitionsFor: aSelector thatIsInProtocol: aString [
	"Pay attention it filters extensions."
	"self new methodDefinitionFor: #initialize thatIsInProtocol: #shout"

	| implementingClasses resultingMethods |
	implementingClasses := self allClassesAndTraits select: [ :each | each includesSelector: aSelector ].
	resultingMethods := OrderedCollection new: implementingClasses size. 
	implementingClasses do: [ :each | 
			| cat |
			cat := each whichCategoryIncludesSelector: aSelector.
			cat = aString
				ifTrue: [ resultingMethods add: ((RGMethodDefinition class: each selector: aSelector ) protocol: cat; yourself) ] 
			 ].
	^ resultingMethods
]

{ #category : #queries }
HCProtocolAnalyzer >> mostCommonlyDefinedSelectors [
	"Return the list of selectors sorted according to the their usage. Higher first"
	"self new mostCommonlyDefinedSelectors 
	>>> {1073->#initialize. 366->#printOn:. 286->#setUp. 253->#name. 220->#=. 197->#hash. 172->#accept:. 152->#label"
	
	| result |
	result := Bag new.
	self allClassesAndTraits do: [ :each | result addAll: each selectors].
	^ result sortedCounts
]

{ #category : #analyses }
HCProtocolAnalyzer >> renameProtocol: source to: target in: aClass [
	"Watch out, does not pay attention to extensions!"
	"self new renameProtocol: 'initialize-release' to: 'initialization' in: RBAbstractClass"
	
	| selectorsToReclassify | 
	selectorsToReclassify := (aClass organization protocolOrganizer methodsInProtocolNamed: source).
	selectorsToReclassify do: [ :s | 
	aClass organization 
				classify: s
				under: target].
]

{ #category : #analyses }
HCProtocolAnalyzer >> statisticFor: aSymbol [
	"self new statisticFor: #printOn:"
	"self new statisticFor: #initialize"
	"self new statisticFor: #storeOn:"

	| result |
	result := Bag new.
	self allClassesAndTraits
		do: [ :eachClass | 
			(eachClass includesSelector: aSymbol)
				ifTrue: [ | cat |	
					cat := eachClass whichCategoryIncludesSelector: aSymbol.
					(cat beginsWith: '*')
						ifFalse: [ result add: cat ] ] ].
	^ result sortedCounts
]

{ #category : #analyses }
HCProtocolAnalyzer >> systemRenameProtocol: source to: target [
	"self new systemRenameProtocol: 'initialize-release' to: 'initialization'"

	| classes |
	classes := self allClassesAndTraits
		select:
			[ :class | class organization protocolOrganizer hasProtocolNamed: source ].
	classes
		do: [ :class | self renameProtocol: source to: target in: class ].
	^ classes
]
