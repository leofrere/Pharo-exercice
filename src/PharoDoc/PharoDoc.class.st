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
	stream nextPutAll: '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">'.
	self generateStyleDoc. 
	self generateHeader: stream and: anClass.
	stream nextPutAll: '<body>'.
	self generateTitleDoc: stream and: anClass. 
	self generateSuperClassDoc: stream and: anClass. 
	self generateSubClassDoc: stream and: anClass. 
	self generateInstanceVariableDoc: stream and: anClass. 
	self generateMethodsDoc: stream and: (anClass methods). 
	stream nextPutAll: '</body>'.
	stream nextPutAll: '</html>'.
	stream close.
	  
]

{ #category : #html }
PharoDoc >> generateClasseDoc: anStream and: anClasse with: anColor [
	| color classe |
	classe:= anClasse name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">'.
	anStream nextPutAll: '<td> <a href="',classe,'.html">',classe,'</a> </td>'.
	anStream nextPutAll: '<td> ',((anClasse comment) ifNil: 'NoDescription'),'</td>'.
	anStream nextPutAll: '</tr>'.
	self generateClassDoc: anClasse.
]

{ #category : #html }
PharoDoc >> generateClassesDoc: anStream and: anPackage [ 
	| color anPackageArray |
	anPackageArray := anPackage package classes.
	color := 'W'.
	anStream nextPutAll: '<table> <thead> <tr> <th> Classes </th> <th> Description </th> </tr> </thead>'.
	anStream nextPutAll: '<tbody> '.
	anPackageArray do: [ :each | 
		(self generateClasseDoc: anStream  and: each with: color ).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> </table>'.
]

{ #category : #html }
PharoDoc >> generateHeader: anStream and: anName [
	| title |
	title := anName asString.
	anStream nextPutAll: '<head>
	<meta charset="UTF-8"/>
	<title>',title,'</title>
	<link rel="stylesheet" type="text/css" href="style.css"/>
</head>'.
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
	anStream nextPutAll: '<td> ',((anMethod comment) ifNil: 'NoDescription'),'</td>'.
	anStream nextPutAll: '</tr>'.
]

{ #category : #html }
PharoDoc >> generateMethodsDoc: anStream and: anMethodArray [
	| color |
	color := 'W'.
	anStream nextPutAll: '<table> <thead> <tr> <th> Methods </th>  <th> Description </th> </tr> </thead>'.
	anStream nextPutAll: '<tbody> '.
	anMethodArray do: [ :each | 
		(self generateMethodDoc: anStream  and: each with: color).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> </table>'.

	
]

{ #category : #html }
PharoDoc >> generatePackageDoc: anPackage [
	| stream file |
	file := ((anPackage asString),'-package.html') asFileReference.
	stream := file writeStream.  
	self generateStyleDoc. 
	stream nextPutAll: '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">'.
	self generateHeader: stream and: anPackage.
	stream nextPutAll: '<body>'.
	self generateTitleDoc:  stream and: anPackage.
	self generateClassesDoc: stream and: anPackage.
	stream nextPutAll: '</body>'. 
	stream nextPutAll: '</html>'.
	stream close. 
]

{ #category : #css }
PharoDoc >> generateStyleDoc [
	|stream file|
	file := 'style.css' asFileReference.
	stream := file writeStream.
	stream nextPutAll: 'tr.clear td{
    background-color: white;
    padding-left: 15px;
    padding-top: 5px;
    padding-bottom: 5px;
}

tr.dark td{
   background-color: lightgray;
   padding-left: 15px;
   padding-top: 5px;
   padding-bottom: 5px;
}

th{
  background-color: lightsteelblue
}

h1{
  font-family: arial;
  border: 1px solid lightgray;
}

h4{
  font-family: arial;
  border: 1px solid lightgray;
}

a{
  font-size: 14px;
  font-family: OCR A Std, monospace;
  
}

span{
  font-size: 14px;
  font-family: OCR A Std, monospace;
}

table{
  font-family: arial;
  border : 1px solid lightgray;
  border-collapse: collapse;
  text-indent: initial;
  margin-left: auto;
  margin-right: auto;

}

body{
  background-color: white;
}'.
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
	anStream nextPutAll: '<h1> ',title,' </h1>';
	yourself.
]
