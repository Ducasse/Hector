# Hector
Hector is super nice guy helping use to commit nice and clean code.

You can ask Hector tools to massively clean the protocols of your system. 



## About HCProtocolAnalyzer
I'm a tool to collect some analyses on selectors categorisation.
### First some simple statistics
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
### Miscategorized methods
Now we can  get a list of all miscategorized method definitions.
```
HCProtocolAnalyzer new findInconsistenciesForASelector: #initialize thatIsNotInProtocol: 'initialization'
```
### Fixing miscategorized methods 
Now you can also fix all the method that are not consistently categorized.
``` 
HCProtocolAnalyzer new fixInconsistenciesOf: #printOn: toBeInProtocol: 'printing'		
```
