"
- Returns occurences based on the current situation in the image.
- Handles carefully extensions. 
"
Class {
	#name : #HCImageProtocolFinder,
	#superclass : #HCProtocolFinder,
	#category : #'Hector-Model'
}

{ #category : #'finding protocols' }
HCImageProtocolFinder >> findProtocolsFor: aMethodDefinition [
	"self new findProtocolsFor: Object>>#printOn:"
	| selector result|
	selector := aMethodDefinition selector.
	result := Bag new. 
	environment allClasses
		do: [ :eachClass | (eachClass includesSelector: selector)
									ifTrue: [ | protocol |
									       protocol := (eachClass whichCategoryIncludesSelector: selector).
											((protocol beginsWith: '*') or: [ protocol = 'as yet unclassified' ])
													ifFalse: [result add: protocol]]].
	^ result
]

{ #category : #'finding protocols' }
HCImageProtocolFinder >> fromClasses [
	^ environment allClasses
		
]
