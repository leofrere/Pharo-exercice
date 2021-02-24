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
	self generateInstanceVariableDoc: stream and: anClass. 
	self generateMethodsDoc: stream and: (anClass methods). 
	stream nextPutAll: '</body>'.
	stream close.
	  
]

{ #category : #css }
PharoDoc >> generateClassStyle: anClass [
]

{ #category : #html }
PharoDoc >> generateClasseDoc: anStream and: anClasse with: anColor [
	| color classe |
	classe:= anClasse name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">'.
	anStream nextPutAll: '<td> <a href="',classe,'.html">',classe,'</a> </td>'.
	anStream nextPutAll: '</tr>'.
	self generateClassDoc: anClasse.
]

{ #category : #html }
PharoDoc >> generateClassesDoc: anStream and: anPackage [ 
	| color anPackageArray |
	anPackageArray := anPackage package classes.
	color := 'W'.
	anStream nextPutAll: '<table> <thead> <tr> <th> Classes </th> </tr> </thead>'.
	anStream nextPutAll: '<tbody> '.
	anPackageArray do: [ :each | 
		(self generateClasseDoc: anStream  and: each with: color ).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> </table>'.
]

{ #category : #html }
PharoDoc >> generateInstanceVariableDoc: anStream and: anClass [
	| instanceArray index |
	instanceArray := anClass instVarNames.
	index := 1.
	anStream nextPutAll: '<h4> InstanceVariable : '.
	instanceArray
		do: [ :each | 
			index < instanceArray size
				ifTrue: [ anStream nextPutAll: '<span> ' , each asString , ' </span>, '.
					index := index + 1 ]
				ifFalse: [ anStream nextPutAll: '<span> ' , each asString , ' </span>' ] ].
	anStream nextPutAll: '</h4>'
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
	| stream file |
	file := ((anPackage asString),'-package.html') asFileReference.
	stream := file writeStream.  
	"generate head of file"
	stream nextPutAll: '<body>'.
	self generateTitleDoc:  stream and: anPackage.
	self generateClassesDoc: stream and: anPackage.
	stream nextPutAll: '</body>'. 
	stream close. 
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
PharoDoc >> generateTitleDoc: anStream and: anClassOrPackage [
	| title |
	title := anClassOrPackage asString.
	anStream nextPutAll: '<title> ',title,' </title>';
	nextPutAll: '<h1> ',title,' </h1>';
	yourself.
]
