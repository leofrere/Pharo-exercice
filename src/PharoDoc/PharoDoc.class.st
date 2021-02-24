Class {
	#name : #PharoDoc,
	#superclass : #Object,
	#category : #PharoDoc
}

{ #category : #html }
PharoDoc >> generateClassDoc: anClass [
	| stream file |
	file := ((anClass asString),'.html') asFileReference.
	stream := file writeStream.
	"generate head of file"
	stream nextPutAll: '<body>'.
	self generateTitleDoc: stream and: anClass. 
	self generateSuperClassDoc: stream and: anClass. 
	self generateSubClassDoc: stream and: anClass. 
	"generate instance varible of file"
	self generateMethodsDoc: stream and: (anClass methods). 
	stream nextPutAll: '</body>'.
	stream close.
	  
]

{ #category : #css }
PharoDoc >> generateClassStyle: anClass [
]

{ #category : #html }
PharoDoc >> generateMethodDoc: anStream and: anMethod with: anColor [
	| color method |
	method:= anMethod name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">'.
	anStream nextPutAll: '<td> ',method,'</td>'.
	anStream nextPutAll: '</tr>'.
]

{ #category : #html }
PharoDoc >> generateMethodsDoc: anStream and: anMethodArray [
	| color |
	color := 'W'.
	anStream nextPutAll: '<table> <thead> <tr> <th> Methods </th> </tr> </thead>'.
	anStream nextPutAll: '<tbody> '.
	anMethodArray do: [ :each | 
		(self generateMethodDoc: anStream  and: each with: color ).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> </table>'.

	
]

{ #category : #html }
PharoDoc >> generatePackageDoc: anPackage [
]

{ #category : #html }
PharoDoc >> generateSubClassDoc: anStream and: anClass [
	| subClassArray index |
	index := 1.
	subClassArray := anClass subclasses.
	anStream nextPutAll: '<h4> SubClass : '.
	subClassArray do: [ :each | 
		index<(subClassArray size) ifTrue: [ anStream nextPutAll: '<a href="',(each asString),'.html"> ',(each asString),' </a>, '. index:=index+1 ] ifFalse: [ anStream nextPutAll: '<a href="',(each asString),'.html"> ',(each asString),' </a> ' ]. 
		 ].
	anStream nextPutAll: '</h4>'.
]

{ #category : #html }
PharoDoc >> generateSuperClassDoc: anStream and: anClass [
	| superClassName |
	superClassName := anClass  superclass.
	superClassName ifNotNil: [ 
		superClassName := superClassName asString.
		anStream nextPutAll:'<h4> SuperClass : <a href="' , superClassName , '.html"> ', superClassName , ' </a> </h4>'.
		 ].
	
]

{ #category : #html }
PharoDoc >> generateTitleDoc: anStream and: anClass [
	| class |
	class := anClass asString.
	anStream nextPutAll: '<title> ',class,' </title>';
	nextPutAll: '<h1> ',class,' </h1>';
	yourself.
]
