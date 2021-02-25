"
I represent a generator of documentation HTML for a class or a package.
"
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
	"Return the value of instance Variable cr"
	^ cr
]

{ #category : #html }
PharoDoc >> generateClassDoc: anClass [
	"Generate a doc html of anClass in directory Pharo Mooc"
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
	"Genrate a doc html of AnClass at the location anPath where an option to show de begin of the path"
	| stream file location |
	anOption='windows' ifTrue: [ location:=FileLocator C/anPath ]. "option 'windows' if you are on a windows system"
	anOption='root' ifTrue: [ location:=FileLocator root/anPath ]. "option 'root' to begin the path at root"
	anOption='home' ifTrue: [ location:=FileLocator home/anPath ]. "option 'home' to begin the path at home"
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
	"Generate a row html with a column for nameClasse and another for the description"
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
	"Generate a row html with a column for nameClasse and another for the description. anPath and anOtion transmit to generateClassDoc"
	| color classe |
	classe:= anClasse name.
	color := 'dark'.
	anColor='W' ifTrue: [ color := 'clear' ].
	anStream nextPutAll: '<tr class="',color,'">',cr.
	anStream nextPutAll: '<td> <a href="',classe,'.html">',classe,'</a> </td>',cr.
	anStream nextPutAll: '<td> ',((anClasse comment) ifNil: 'NoDescription'),'</td>',cr.
	anStream nextPutAll: '</tr>',cr.
	self generateClassDoc: anClasse at: anPath opt: anOption.
]

{ #category : #html }
PharoDoc >> generateClassesDoc: anStream and: anPackage [ 
	"Generate a rtable html with a column for nameClasse and another for the description"
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
	"Generate a table html with a column for nameClasse and another for the description. anPath and anOtion transmit to generateClassDoc"
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
	"Generate the head for a html file"
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
	"Generate the html code to display instance variables"
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
	"Generate the row html to display the name and description of method"
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
	"Generate a table html to display the information of differents method"
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
	"Generate file html with the description of different class of package and generate for every class in packages it doc"
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
	"Generate file html with the description of different class of package and generate for every class in packages it doc in anPath with anOption to choose the begin of the path"
	| stream file location |
	anOption='windows' ifTrue: [ location:=FileLocator C/anPath ]. "option 'windows' if you are on a windows system"
	anOption='root' ifTrue: [ location:=FileLocator root/anPath ]. "option 'root' to begin the path at root"
	anOption='home' ifTrue: [ location:=FileLocator home/anPath ]. "option 'home' to begin the path at home"
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
	"Generate a file style.css in directory Pharo Mooc"
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
	"Generate a file style.css at the location anPath where an option to show de begin of the path"
	|stream file location |
	anOption='windows' ifTrue: [ location:=FileLocator C/anPath ]. "option 'windows' if you are on a windows system"
	anOption='root' ifTrue: [ location:=FileLocator root/anPath ]. "option 'root' to begin the path at root"
	anOption='home' ifTrue: [ location:=FileLocator home/anPath ]. "option 'home' to begin the path at home"
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
	"Generate the html code to display the subclass of anClass"
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
	"Generate the html code to display the superclass of anClass"
	| superClassName |
	superClassName := anClass  superclass.
	superClassName ifNotNil: [ 
		superClassName := superClassName asString.
		anStream nextPutAll:'<h4> SuperClass : <a href="' , superClassName , '.html"> ', superClassName , ' </a> </h4>',cr.
		 ].
	
]

{ #category : #html }
PharoDoc >> generateTitleDoc: anStream and: anClassOrPackage [
	"Genrate a title with name of Class or Package for an html document"
	| title |
	title := anClassOrPackage asString.
	anStream nextPutAll: '<h1> ',title,' </h1>',cr;
	yourself.
]

{ #category : #initialization }
PharoDoc >> initialize [ 
	"Initialize an PharoDoc Object"	
	super initialize.
	cr := (Character cr) asString.
]
