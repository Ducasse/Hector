Class {
	#name : #HCMethodCategorizationRuleTest,
	#superclass : #TestCase,
	#category : #Hector
}

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> accessorMethod [
	
	^RGMethodDefinition class: self mockClass selector: #accessor

]

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> methodForTesting [
	
	^RGMethodDefinition class: self mockClass selector: #selectorForTesting

]

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> mockClass [

	^HCMockClass
]

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> otherMethodForTesting [
	
	^RGMethodDefinition class: self mockClass selector: #otherSelectorForTesting

]

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> protocolForTesting [

	^#'test category'
]

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> selectorForTesting [
	"Used in tests (see local senders of this method)"
]

{ #category : #running }
HCMethodCategorizationRuleTest >> setUp [

	self mockClass uncategorizeAllMethods.
	self mockClass superclass uncategorizeAllMethods.
]

{ #category : #'test support' }
HCMethodCategorizationRuleTest >> superClassCategory [

	^#'category in super class'
]

{ #category : #running }
HCMethodCategorizationRuleTest >> tearDown [

	self mockClass categorizeAllMethods.
	self mockClass superclass categorizeAllMethods.
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testAppliesTo [

	| rule |
	rule := HCMethodCategorizationRule 
				when: [ :aMethod | aMethod = self methodForTesting ]	
				categorizeIn: self protocolForTesting.
	self
		assert: (rule canBeAppliedTo: self methodForTesting);
		deny: (rule canBeAppliedTo: self otherMethodForTesting)
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testAppliesToAccessors [

	| rule |
	rule := HCMethodCategorizationRule accessorsInAccessing.
	self
		assert: (rule canBeAppliedTo: self accessorMethod);
		deny: (rule canBeAppliedTo: self methodForTesting)
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testAppliesToWhenCreatedForSelector [
	
	| ruleForSelector |
	ruleForSelector := HCMethodCategorizationRule 
				whenSelectorMatches: #selectorForTesting
				categorizeIn: self protocolForTesting.
	self
		assert: (ruleForSelector canBeAppliedTo: self methodForTesting);
		deny: (ruleForSelector canBeAppliedTo: self otherMethodForTesting)
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testAppliesToWhenCreatedForSelectorAndClassInheritsFrom [

	| ruleForSelector |

	ruleForSelector := HCMethodCategorizationRule 
				whenSelectorMatches: #selectorForTesting
				andClassInheritsFrom: self mockClass superclass 
				categorizeIn: self protocolForTesting.
	self
		assert: (ruleForSelector canBeAppliedTo: self methodForTesting);
		deny: (ruleForSelector canBeAppliedTo: self otherMethodForTesting);
		deny: (ruleForSelector canBeAppliedTo: (RGMethodDefinition class: self class selector: #selectorForTesting))
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testAppliesToWhenUsingSuperClassCategory [

	| rule |
	rule := HCMethodCategorizationRule usingMostUsedProtocolInSuperClasses.
	self mockClass superclass organization 
		classify: #selectorForTesting 
		under: self superClassCategory.
	self
		assert: (rule canBeAppliedTo: self methodForTesting);
		deny: (rule canBeAppliedTo: self otherMethodForTesting).
	
	self mockClass superclass uncategorizeAllMethods.
	
	self deny: (rule canBeAppliedTo: self methodForTesting)
		description: 'The rule applies only when the super class method is classified'
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testCategorize [
	| rule |

	rule := HCMethodCategorizationRule 
				when: [:aMethodReference | aMethodReference = self methodForTesting ]
				categorizeIn: self protocolForTesting.

	rule categorizeMethod: self methodForTesting.

	self assert: (self mockClass organization categoryOfElement: #selectorForTesting) = self protocolForTesting
]

{ #category : #tests }
HCMethodCategorizationRuleTest >> testCategorizeWhenUsingSuperClassCategory [

	| rule |

	rule := HCMethodCategorizationRule usingMostUsedProtocolInSuperClasses.

	self mockClass superclass organization classify: #selectorForTesting under: self superClassCategory.
	
	rule categorizeMethod: self methodForTesting.
	
	self assert: (self mockClass organization categoryOfElement: #selectorForTesting) = self superClassCategory
]
