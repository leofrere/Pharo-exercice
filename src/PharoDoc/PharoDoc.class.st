Class {
	#name : #PharoDoc,
	#superclass : #Object,
	#instVars : [
		'cr'
	],
	#category : #PharoDoc
}

{ #category : #accesing }
PharoDoc >> cr [ 	
	^ cr
]

{ #category : #html }
PharoDoc >> generateClassDoc: anClass [
	| stream file |
	file := ((anClass asString),'html') asFileReference.
	stream := file writeStream.
	stream nextPutAll: '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">',cr.
	self generateStyleDoc. 
	self generateHeader: stream and: anClass.
	stream nextPutAll: '<body>',cr.
	self generateTitleDoc: stream and: anClass. 
	self generateSuperClassDoc: stream and: anClass. 
	self generateSubClassDoc: stream and: anClass. 
	self generateInstanceVariableDoc: stream and: anClass. 
	self generateMethodsDoc: stream and: (anClass methods). 
	stream nextPutAll: '</body>',cr.
	stream nextPutAll: '</html>',cr.
	stream close.
	  
]

{ #category : #html }
PharoDoc >> generateClassDoc: anClass at: anPath opt: anOption [
	| stream file location |
	anOption='windows' ifTrue: [ location:=FileLocator C/anPath ].
	anOption='root' ifTrue: [ location:=FileLocator root/anPath ].
	anOption='home' ifTrue: [ location:=FileLocator home/anPath ].
	file := (location/(anClass asString),'html') asFileReference.
	stream := file writeStream.
	stream nextPutAll: '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">',cr.
	self generateStyleDoc: anPath opt: anOption. 
	self generateHeader: stream and: anClass.
	stream nextPutAll: '<body>',cr.
	self generateTitleDoc: stream and: anClass. 
	self generateSuperClassDoc: stream and: anClass. 
	self generateSubClassDoc: stream and: anClass. 
	self generateInstanceVariableDoc: stream and: anClass. 
	self generateMethodsDoc: stream and: (anClass methods). 
	stream nextPutAll: '</body>',cr.
	stream nextPutAll: '</html>',cr.
	stream close.
	  
]

{ #category : #html }
PharoDoc >> generateClasseDoc: anStream and: anClasse with: anColor [
	| color classe |
	classe:= anClasse name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">',cr.
	anStream nextPutAll: '<td> <a href="',classe,'html">',classe,'</a> </td>',cr.
	anStream nextPutAll: '<td> ',((anClasse comment) ifNil: 'NoDescription'),'</td>',cr.
	anStream nextPutAll: '</tr>',cr.
	self generateClassDoc: anClasse.
]

{ #category : #html }
PharoDoc >> generateClasseDoc: anStream and: anClasse with: anColor at: anPath opt: anOption [ 
	| color classe |
	classe:= anClasse name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">',cr.
	anStream nextPutAll: '<td> <a href="',classe,'html">',classe,'</a> </td>',cr.
	anStream nextPutAll: '<td> ',((anClasse comment) ifNil: 'NoDescription'),'</td>',cr.
	anStream nextPutAll: '</tr>',cr.
	self generateClassDoc: anClasse at: anPath opt: anOption.
]

{ #category : #html }
PharoDoc >> generateClassesDoc: anStream and: anPackage [ 
	| color anPackageArray |
	anPackageArray := anPackage package classes.
	color := 'W'.
	anStream nextPutAll: '<table> 
	<thead>
	 <tr>
	 <th> Classes </th>
	 <th> Description </th> 
	</tr>
	 </thead>'.
	anStream nextPutAll: '<tbody> ',cr.
	anPackageArray do: [ :each | 
		(self generateClasseDoc: anStream  and: each with: color ).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> 
	</table>',cr.
]

{ #category : #html }
PharoDoc >> generateClassesDoc: anStream and: anPackage at: anPath opt: anOption [ 
	| color anPackageArray |
	anPackageArray := anPackage package classes.
	color := 'W'.
	anStream nextPutAll: '<table> 
	<thead>
	 <tr>
	 <th> Classes </th>
	 <th> Description </th> 
	</tr>
	 </thead>'.
	anStream nextPutAll: '<tbody> ',cr.
	anPackageArray do: [ :each | 
		(self generateClasseDoc: anStream  and: each with: color at: anPath opt: anOption).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> 
	</table>',cr.
]

{ #category : #html }
PharoDoc >> generateHeader: anStream and: anName [
	| title |
	title := anName asString.
	anStream nextPutAll: '<head>
	<meta charset="UTF-8"/>
	<title>',title,'</title>
	<link rel="stylesheet" type="text/css" href="style.css"/>
</head>',cr.
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
	anStream nextPutAll: '</h4>',cr.
]

{ #category : #html }
PharoDoc >> generateMethodDoc: anStream and: anMethod with: anColor [
	| color method |
	method:= anMethod name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">',cr.
	anStream nextPutAll: '<td> ',method,'</td>',cr.
	anStream nextPutAll: '<td> ',((anMethod comment) ifNil: 'NoDescription'),'</td>',cr.
	anStream nextPutAll: '</tr>',cr.
]

{ #category : #html }
PharoDoc >> generateMethodsDoc: anStream and: anMethodArray [
	| color |
	color := 'W'.
	anStream nextPutAll: '<table>
	<thead> 
	<tr> 
	<th> Methods </th> 
	<th> Description </th> 
	</tr> 
	</thead>',cr.
	anStream nextPutAll: '<tbody> ',cr.
	anMethodArray do: [ :each | 
		(self generateMethodDoc: anStream  and: each with: color).
		color='W' ifTrue: [ color:='D' ] ifFalse: [ color:='W' ]. 
		 ].
	anStream nextPutAll: ' </tbody> 
	</table>',cr.

	
]

{ #category : #html }
PharoDoc >> generatePackageDoc: anPackage [
	| stream file |
	file := ((anPackage asString),'package.html') asFileReference.
	stream := file writeStream.  
	self generateStyleDoc. 
	stream nextPutAll: '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">',cr.
	self generateHeader: stream and: anPackage.
	stream nextPutAll: '<body>',cr.
	self generateTitleDoc:  stream and: anPackage.
	self generateClassesDoc: stream and: anPackage.
	stream nextPutAll: '</body>',cr. 
	stream nextPutAll: '</html>',cr.
	stream close. 
]

{ #category : #html }
PharoDoc >> generatePackageDoc: anPackage at: anPath opt: anOption [ 
	| stream file location |
	anOption='windows' ifTrue: [ location:=FileLocator C/anPath ].
	anOption='root' ifTrue: [ location:=FileLocator root/anPath ].
	anOption='home' ifTrue: [ location:=FileLocator home/anPath ].
	file := (location/(anPackage asString),'package.html') asFileReference.
	stream := file writeStream.  
	self generateStyleDoc. 
	stream nextPutAll: '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">',cr.
	self generateHeader: stream and: anPackage.
	stream nextPutAll: '<body>',cr.
	self generateTitleDoc:  stream and: anPackage.
	self generateClassesDoc: stream and: anPackage at: anPath opt: anOption.
	stream nextPutAll: '</body>',cr. 
	stream nextPutAll: '</html>',cr.
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

{ #category : #css }
PharoDoc >> generateStyleDoc: anPath opt: anOption [
	|stream file location |
	anOption='windows' ifTrue: [ location:=FileLocator C/anPath ].
	anOption='root' ifTrue: [ location:=FileLocator root/anPath ].
	anOption='home' ifTrue: [ location:=FileLocator home/anPath ].
	file := (location/'style.css') asFileReference.
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
	anStream nextPutAll: '</h4>',cr.
]

{ #category : #html }
PharoDoc >> generateSuperClassDoc: anStream and: anClass [
	| superClassName |
	superClassName := anClass  superclass.
	superClassName ifNotNil: [ 
		superClassName := superClassName asString.
		anStream nextPutAll:'<h4> SuperClass : <a href="' , superClassName , '.html"> ', superClassName , ' </a> </h4>',cr.
		 ].
	
]

{ #category : #html }
PharoDoc >> generateTitleDoc: anStream and: anClassOrPackage [
	| title |
	title := anClassOrPackage asString.
	anStream nextPutAll: '<h1> ',title,' </h1>',cr;
	yourself.
]

{ #category : #initialization }
PharoDoc >> initialize [ 	
	super initialize.
	cr := (Character cr) asString.
]
