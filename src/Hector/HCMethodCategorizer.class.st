"
Instances of this class categorize methods based on a set of rules. The first version of this package was developed by Diego Fernandez and Stéphane Ducasse continued to work on it. 


## Example 
Here is a typical example:

```
| myRule |
myRule := MethodCategorizationRule 
				whenSelectorMatches: 'initialize*' 
				categorizeIn: #initialization.
								
(AutomaticMethodCategorizer using: myRule) categorizeAllMethodsOf: MyClass
```

## API
You can categorize at different levels of granularity.

- `categorizeAllMethodsOf:` aClass
- `categorizeAllUncategorizedMethodsOf:` aClass
- `categorizeMethod:` aMethod
- `categorizeMethods:` methods

## Rule access

You can customize the AutomaticMethodCategorizer to access specific class to hold rules as follows: 

```
	AutomaticMethodCategorizer 
		ruleMapAt: 'RuleRepository'
```	
	or even specify the selector to be sent to get access to rules

```		
	AutomaticMethodCategorizer 
		rulesAccessSelector: #mySpecificRules	
```
		
	The easiest approach is to define a subclass to AutomaticMethodCategorizer and customize the method defaultCategorizationRules which is invoked by default. 
		

## For more examples

- `AutomaticMethodCategorizerTest` 
- `AutomaticMethodCategorizer defaultCategorizationRules`



	


"
Class {
	#name : #HCMethodCategorizer,
	#superclass : #WorkingOnEnvironmentFragment,
	#classTraits : 'THCEnvironmentFragment classTrait',
	#instVars : [
		'categorizationRules'
	],
	#classVars : [
		'RuleMaps'
	],
	#category : #'Hector-Model'
}

{ #category : #compatibility }
HCMethodCategorizer class >> classify: aMethodDefinition [

	^ self new categorizeMethod: aMethodDefinition
]

{ #category : #compatibility }
HCMethodCategorizer class >> classifyAll: methodDefinitions [

	^ self new categorizeMethods: methodDefinitions
]

{ #category : #defaults }
HCMethodCategorizer class >> defaultCategorizationRules [
	"The order is relevant, the categorizer uses the first rule matching"

	^OrderedCollection new
		add: HCMethodCategorizationRule accessorsInAccessing;
		"initialize"
		add: HCMethodCategorizationRule initStarInInitialization;
		add: HCMethodCategorizationRule defaultStartInDefaults;
		add: HCMethodCategorizationRule asStarInPrinting;
		
		add: (HCMethodCategorizationRule hashInComparing);
		"order is important"		
		"testing"
		add: (HCMethodCategorizationRule isStarInInitialization);
		add: (HCMethodCategorizationRule hasStarInTesting);
		add: (HCMethodCategorizationRule equalInComparing);		
		add: (HCMethodCategorizationRule newStarInInstanceCreation);
		add: (HCMethodCategorizationRule settingInSettings);
		add: (HCMethodCategorizationRule printStarInPrinting);
		add: (HCMethodCategorizationRule storeOnInPrinting);
		
		add: (HCMethodCategorizationRule starCopyStarInCopying);
		add: (HCMethodCategorizationRule drawStarInDrawing);
		add: (HCMethodCategorizationRule benchStarInbenchmarks);
		add: (HCMethodCategorizationRule removeStarInAddRemove);
		add: (HCMethodCategorizationRule addStarInAddRemove);
		
		add: (HCMethodCategorizationRule openStarInOpening);
		add: (HCMethodCategorizationRule updateStarInUpdating);
		add: (HCMethodCategorizationRule changeStarInUpdating);
		
		add: (HCMethodCategorizationRule acceptStarInVisitor);
		add: (HCMethodCategorizationRule visitStarInVisiting);

		add: (HCMethodCategorizationRule menuStarInMenus);
		
		add: (HCMethodCategorizationRule exampleStarInExamples);
		
		"test cases"
		add: (HCMethodCategorizationRule testInTestCaseInTests);
		add: (HCMethodCategorizationRule setUpTestCaseInSetup);
		add: (HCMethodCategorizationRule tearDownTestCaseInSetup);
		
		"baselines, versions..."
		add: (HCMethodCategorizationRule versionConfigurationOfInVersions);
		add: (HCMethodCategorizationRule baselineConfigurationOfInbaselines);
		add: (HCMethodCategorizationRule devConfigurationOfInSymbolic);
		add: (HCMethodCategorizationRule stableConfigurationOfInSymbolic);
					
		add: HCMethodCategorizationRule usingMostUsedProtocolInSuperClasses;
		add: HCMethodCategorizationRule usingMostUsedProtocolInImage;
		yourself
]

{ #category : #defaults }
HCMethodCategorizer class >> defaultMapName [
	^ #defaultRuleMap
]

{ #category : #'installation to test' }
HCMethodCategorizer class >> deinstall [
	"Nautilus should have a class var that points to the class to use!"
	"self deinstall"

	Nautilus methodClassifierClass: MethodClassifier
]

{ #category : #initialization }
HCMethodCategorizer class >> initialize [
	"self initialize"
	
	self ruleMapAt: self defaultMapName put: self defaultCategorizationRules.

]

{ #category : #'installation to test' }
HCMethodCategorizer class >> install [
	"Nautilus should have a class var that points to the class to use!"
	"self install"

	Nautilus methodClassifierClass: self
]

{ #category : #'instance creation' }
HCMethodCategorizer class >> new [ 
	"By default take the default rules"
	^ super new categorizationRules: (self ruleMapAt: self defaultMapName) ; yourself
]

{ #category : #'managing rule map' }
HCMethodCategorizer class >> resetRuleMaps [
	"self resetRuleMaps"
	RuleMaps := nil
]

{ #category : #'managing rule map' }
HCMethodCategorizer class >> ruleMapAt: aSymbol [ 

	^ self ruleMaps at: aSymbol 
]

{ #category : #'managing rule map' }
HCMethodCategorizer class >> ruleMapAt: aSymbol put: aListOfRules [

	self ruleMaps at: aSymbol put: aListOfRules
]

{ #category : #'managing rule map' }
HCMethodCategorizer class >> ruleMaps [

	^ RuleMaps ifNil: [ RuleMaps := IdentityDictionary new ]
]

{ #category : #'instance creation' }
HCMethodCategorizer class >> usingRule: aMethodCategorizationRule [
	
	^self usingRules: (Array with: aMethodCategorizationRule)
]

{ #category : #'instance creation' }
HCMethodCategorizer class >> usingRules: aCollection [
	
	^self new categorizationRules: aCollection ; yourself
]

{ #category : #query }
HCMethodCategorizer >> categorizationRuleFor: aMethodDefinition [
	"Find the first rule that matches for a given method definition"
	
	^ categorizationRules 
		detect: [ :eachRule | eachRule canBeAppliedTo: aMethodDefinition ]
		ifNone: [ HCNullMethodCategorizationRule new ]

]

{ #category : #initialization }
HCMethodCategorizer >> categorizationRules: aCollection [ 

	categorizationRules := aCollection
]

{ #category : #'categorize environments' }
HCMethodCategorizer >> categorizeAllMethodsNamed: aSelector [ 
	"categorize all the methods named aSelector using existing rules."
	"self new categorizeAllMethodsNamed: #storeOn:"

	(self identifyClassesWithNonExtendingMethod: aSelector)
		do: [ :each | self categorizeMethod: (RGMethodDefinition class: each selector: aSelector ) ]
]

{ #category : #'categorize environments' }
HCMethodCategorizer >> categorizeAllMethodsNamed: aSelector inProtocol: aString [
	"Categorize all methods named aSelector into the protocol aString. Do not use predefined rules."
	"self new categorizeAllMethods: #storeOn: inProtocol: #'printing'"

	self usingRules: { (HCMethodCategorizationRule whenSelectorMatches: aSelector categorizeIn:  aString)}.
	(self identifyClassesWithNonExtendingMethod: aSelector)
		do: [ :each | 
			self categorizeMethod: (RGMethodDefinition class: each selector: aSelector ) ]
]

{ #category : #categorize }
HCMethodCategorizer >> categorizeAllMethodsOf: aClass [ 

	| methodDefs |
	methodDefs := aClass selectors collect: [ :eachSelector | RGMethodDefinition class: aClass selector: eachSelector ].
	self categorizeMethods: methodDefs
]

{ #category : #categorize }
HCMethodCategorizer >> categorizeAllUncategorizedMethodsOf: aClass [ 

	| referencesToUncategorizedMethods |
	referencesToUncategorizedMethods := aClass organization uncategorizedSelectors 
		collect: [ :eachSelector | RGMethodDefinition class: aClass selector: eachSelector ].
	self categorizeMethods: referencesToUncategorizedMethods
]

{ #category : #categorize }
HCMethodCategorizer >> categorizeMethod: aMethodDefinition [
	
	(self categorizationRuleFor: aMethodDefinition) categorizeMethod: aMethodDefinition
]

{ #category : #categorize }
HCMethodCategorizer >> categorizeMethods: methodDefinitions [
	
	methodDefinitions do: [ :each | 
		(self categorizationRuleFor: each) categorizeMethod: each]
]

{ #category : #compatibility }
HCMethodCategorizer >> classify: aMethodDefinition [
	"to be compatible with the MethodClassifier"
	
	^ self categorizeMethod: aMethodDefinition
]

{ #category : #compatibility }
HCMethodCategorizer >> classifyAll: methodDefinitions [

	^ self categorizeMethods: methodDefinitions
]

{ #category : #'categorize environments' }
HCMethodCategorizer >> identifyClassesWithNonExtendingMethod: aSymbol [ 
	"self new identifyClassesWithNonExtendingMethod: #initialize"
	
	| implementors |
	implementors := self allClassesAndTraits select: [ :each | each includesSelector: aSymbol ].
	implementors := implementors
		reject: [ :each | 
			| cat |
			cat := each whichCategoryIncludesSelector: aSymbol.
			(cat beginsWith: '*')].
	^ implementors
]
