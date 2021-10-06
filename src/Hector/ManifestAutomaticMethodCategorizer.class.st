"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAutomaticMethodCategorizer,
	#superclass : #PackageManifest,
	#category : #Hector
}

{ #category : #'meta-data' }
ManifestAutomaticMethodCategorizer class >> description [ ^ 'I''m a package to support the analysis and application of consistent rule-based method categorisation. 
I have been designed some years ago by  Diego Fernandez and evolved by Stéphane Ducasse.
Now it got released so that people can play with it and decide what to do.

My main classes are
	AutomaticMethodCategorizer 
	MethodCategorizationRule
	and 
	ProtocolAnalyzer
	
Now the design of this method categoriser is less efficient than the default one. 
AutomaticMethodCategorizer is based on first class rules while MethodCategorizer is based on dictionaries. 

Now AutomaticMethodCategorizer is more flexible:
	- It can manage different rules groups
	- the order of the rules can be changed. 
		
One possibilty can be to 
	- Extract ProtocolAnalyzer as a separate project 
	- Create classes out of the dictionaries of MethodCategorizer and make the lookup customizable

In any case it would be good 
	- To generate refactorings so that we can use the current tools to see the 
result of a classification
	- To put the classification on so that methods are automatically classified on accept. 
	'
]
