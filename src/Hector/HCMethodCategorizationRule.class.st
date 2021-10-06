"
Instances of this class represents a categorization rule.
This class is very flexible and can be used to define different rules, see the instance creation methods for examples.

For example, the following method expresses that when there are more than one message in the system,  the categorizer should select the most used category based on the currently executed image. 

```
usingMostUsedCategoryInImage
	
	^self 
		when: [ :aMethodDefinition | (SystemNavigation new allImplementorsOf: aMethodDefinition selector) size > 1]
		selectFromProtocolsReturnedBy: ImageMethodCategoriesFinder new
		using: MostUsedMethodProtocolSelectionStrategy new
```
"
Class {
	#name : #HCMethodCategorizationRule,
	#superclass : #Object,
	#instVars : [
		'conditionBlock',
		'protocolFinder'
	],
	#category : #Hector
}

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> acceptStarInVisitor [
	^ self 
		whenSelectorMatches: 'accept*' 
		categorizeIn: #'accept'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> accessorsInAccessing [
	"Accessors are categorized in accessing category."
	
	^self when: [ :aMethodDefinition | 
			(aMethodDefinition realClass compiledMethodAt: aMethodDefinition selector) isReturnField 
				or: [(aMethodDefinition selector occurrencesOf: $:) = 1
					and: [aMethodDefinition realClass instVarNames includes: (aMethodDefinition selector copyUpToLast: $:) ]]
		] 
		categorizeIn: #accessing
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> addStarInAddRemove [
	^ self 
		whenSelectorMatches: 'add*' 
		categorizeIn: #'add/remove'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> asStarInPrinting [

	^ (self whenSelectorMatches: 'as*' categorizeIn: #converting)
	
	
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> baselineConfigurationOfInbaselines [
	^ self 
		whenSelectorMatches: 'baseline*'
		andClassMatches: 'ConfigurationOf*'
		categorizeIn: #'baselines'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> benchStarInbenchmarks [
	^ self 
		whenSelectorMatches: 'bench*' 
		categorizeIn: #'benchmarking'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> changeStarInUpdating [
	^ self 
		whenSelectorMatches: 'change*' 
		categorizeIn: #'updating'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> defaultStartInDefaults [

	^ self whenSelectorMatches: 'default*' categorizeIn: #defaults
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> devConfigurationOfInSymbolic [
	^ self 
		whenSelectorMatches: 'development*'
		andClassMatches: 'ConfigurationOf*'
		categorizeIn: #'symbolic'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> drawStarInDrawing [
	^ self 
		whenSelectorMatches: 'draw*' 
		categorizeIn: #'drawing'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> equalInComparing [
	^ self 
		whenSelectorMatches: '=' 
		categorizeIn: #'comparing'
]

{ #category : #example }
HCMethodCategorizationRule class >> exampleSelectorInExample [
	"Each rule is an instance of MethodCategorizationRule. The categorizer expects a collection of rules."

	^ { (HCMethodCategorizationRule whenSelectorMatches: 'example*' categorizeIn: #example) }
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> exampleStarInExamples [
	^ self 
		whenSelectorMatches: 'example*' 
		categorizeIn: #examples
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> hasStarInTesting [
	^ self 
		whenSelectorMatches: 'has*' 
		categorizeIn: #'testing'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> hashInComparing [
	^ self 
		whenSelectorMatches: 'hash' 
		categorizeIn: #'comparing'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> initStarInInitialization [

	^ self whenSelectorMatches: 'init*' categorizeIn: #initialization
]

{ #category : #'predefined exact matching rules' }
HCMethodCategorizationRule class >> initializeInInitialization [

	^ self whenSelectorMatches: 'initialize*' categorizeIn: #initialization
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> isStarInInitialization [

	^ self whenSelectorMatches: 'is*' categorizeIn: #testing
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> menuStarInMenus [
	"probably should handle also pragma"
	^ self 
		whenSelectorMatches: 'menu*' 
		categorizeIn: #'menus'
]

{ #category : #'predefined exact matching rules' }
HCMethodCategorizationRule class >> newInInstanceCreation [
	^ self 
		whenSelectorMatches: 'new' 
		categorizeIn: #'instance creation'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> newStarInInstanceCreation [
	^ self 
		whenSelectorMatches: 'new*' 
		categorizeIn: #'instance creation'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> openStarInOpening [
	^ self 
		whenSelectorMatches: 'open*' 
		categorizeIn: #'opening'
]

{ #category : #'predefined exact matching rules' }
HCMethodCategorizationRule class >> printOnInPrinting [

	^ (self whenSelectorMatches: 'printOn:' categorizeIn: #printing)
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> printStarInPrinting [

	^ (self whenSelectorMatches: 'print*' categorizeIn: #printing)
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> removeStarInAddRemove [
	^ self 
		whenSelectorMatches: 'remove*' 
		categorizeIn: #'add/remove'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> setUpTestCaseInSetup [
	^ self 
		whenSelectorMatches: 'setUp'
		andClassInheritsFrom: TestCase
		categorizeIn: #'setup'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> settingInSettings [
	"we need to do something with pragma here."
	
	^ self 
		whenSelectorMatches: 'setting' 
		categorizeIn: #'settings'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> stableConfigurationOfInSymbolic [
	^ self 
		whenSelectorMatches: 'stable*'
		andClassMatches: 'ConfigurationOf*'
		categorizeIn: #'symbolic'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> starCopyStarInCopying [
	^ self 
		whenSelectorMatches: '*copy*' 
		categorizeIn: #'copying'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> storeOnInPrinting [

	^ (self whenSelectorMatches: 'storeOn:' categorizeIn: #printing)
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> tearDownTestCaseInSetup [
	^ self 
		whenSelectorMatches: 'tearDown'
		andClassInheritsFrom: TestCase
		categorizeIn: #'setup'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> testInTestCaseInTests [
	^ self 
		whenSelectorMatches: 'test*'
		andClassInheritsFrom: TestCase
		categorizeIn: #'tests'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> updateStarInUpdating [
	^ self 
		whenSelectorMatches: 'update*' 
		categorizeIn: #'updating'
]

{ #category : #'predefined dynamic rules' }
HCMethodCategorizationRule class >> usingMostUsedProtocolInImage [
	
	^self 
		when: [ :aMethodDefinition | (SystemNavigation new allImplementorsOf: aMethodDefinition selector) size > 1]
		selectFromProtocolsReturnedBy: HCImageProtocolFinder new
		
]

{ #category : #'predefined dynamic rules' }
HCMethodCategorizationRule class >> usingMostUsedProtocolInSuperClasses [

	^ self 
		when: 
			[ :methodDefinition | 
			methodDefinition realClass superclass 
				canUnderstand: methodDefinition selector]
		selectFromProtocolsReturnedBy: HCSuperClassProtocolFinder new
	
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> versionConfigurationOfInVersions [
	^ self 
		whenSelectorMatches: 'version*'
		andClassMatches: 'ConfigurationOf*'
		categorizeIn: #'versions'
]

{ #category : #'predefined rules' }
HCMethodCategorizationRule class >> visitStarInVisiting [
	^ self 
		whenSelectorMatches: 'visit*' 
		categorizeIn: #'visiting'
]

{ #category : #'instance creation' }
HCMethodCategorizationRule class >> when: aOneArgBlock categorizeIn: aSymbol [ 

	^self 
		when: aOneArgBlock
		selectFromProtocolsReturnedBy: (HCFixedProtocolFinder categorizeIn: aSymbol)
	
]

{ #category : #'instance creation' }
HCMethodCategorizationRule class >> when: aOneArgBlock 
	selectFromProtocolsReturnedBy: aMethodCategoriesFinder [ 

	^ self new 
		initializeWhen: aOneArgBlock
		selectFromProtocolsReturnedBy: aMethodCategoriesFinder
	
]

{ #category : #'instance creation' }
HCMethodCategorizationRule class >> when: aOneArgBlock 
	selectFromProtocolsReturnedBy: aMethodCategoriesFinder 
	using: aMethodCategorySelectionStrategy [ 

	^ self new 
		initializeWhen: aOneArgBlock
		selectFromProtocolsReturnedBy: aMethodCategoriesFinder
		using: aMethodCategorySelectionStrategy
]

{ #category : #'instance creation' }
HCMethodCategorizationRule class >> whenSelectorMatches: aSelectorPatternString 
	andClassInheritsFrom: aClass 
	categorizeIn: aSymbol [ 

	^self 
		when: [ :aMethodDefinition |
			(aSelectorPatternString match: aMethodDefinition selector asString)
				and: [ aMethodDefinition realClass inheritsFrom: aClass ] ]
		categorizeIn: aSymbol
]

{ #category : #'instance creation' }
HCMethodCategorizationRule class >> whenSelectorMatches: aSelectorPatternString 
	andClassMatches: aClassPatternString 
	categorizeIn: aSymbol [ 

	^self 
		when: [ :aMethodDefinition |
			(aSelectorPatternString match: aMethodDefinition selector asString)
				and: [ aClassPatternString, '*' match: aMethodDefinition className ] ]
		categorizeIn: aSymbol
]

{ #category : #'instance creation' }
HCMethodCategorizationRule class >> whenSelectorMatches: aSelectorPatternString categorizeIn: aSymbol [ 
	
	^ self 
		when: [ :aMethodDefinition | aSelectorPatternString match: aMethodDefinition selector asString ] 
		categorizeIn: aSymbol
]

{ #category : #testing }
HCMethodCategorizationRule >> canBeAppliedTo: aMethodDefinition [
	"We can apply a rule when the condition holds and when we know what to do with the method."
	
	^ (conditionBlock value: aMethodDefinition) 
			 and: [ self canSelectProtocolFor: aMethodDefinition ]
]

{ #category : #'testing - private' }
HCMethodCategorizationRule >> canSelectProtocolFor: aMethodDefinition [ 

	^  (protocolFinder findProtocolsFor: aMethodDefinition) notEmpty
	
]

{ #category : #action }
HCMethodCategorizationRule >> categorizeMethod: aMethodDefinition [ 

	| proposedProtocol |
	proposedProtocol := self suggestProtocolFor: aMethodDefinition.
	aMethodDefinition realClass organization 
		classify: aMethodDefinition selector
		under: proposedProtocol.
	^proposedProtocol
]

{ #category : #initialization }
HCMethodCategorizationRule >> initializeWhen: aOneArgBlock 
	selectFromProtocolsReturnedBy: aMethodProtocolFinder [ 

	conditionBlock := aOneArgBlock.
	protocolFinder := aMethodProtocolFinder
	
]

{ #category : #query }
HCMethodCategorizationRule >> suggestProtocolFor: aMethodReference [ 
	"Return the suggested protocol for the method"
	
	^ (protocolFinder findProtocolsFor: aMethodReference) sortedCounts first value
]
