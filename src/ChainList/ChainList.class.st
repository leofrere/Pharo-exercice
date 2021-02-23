Class {
	#name : #ChainList,
	#superclass : #Object,
	#instVars : [
		'head',
		'tail',
		'size'
	],
	#category : #ChainList
}

{ #category : #comparing }
ChainList >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ head = anObject head
		and: [ tail = anObject tail and: [ size = anObject size ] ]
]

{ #category : #adding }
ChainList >> add: anObject [ 
	size := size + 1.
	head ifNil: [ 
		head := anObject.
		 ^ anObject 
		].
	tail ifNil: [ 
		tail := ChainList new.
		tail add: anObject.
		^ anObject 
		 ].
	tail add: anObject.
	^ anObject  
]

{ #category : #comparing }
ChainList >> contains: anObject [ 
	head = anObject ifTrue: [ ^ true ].
	tail ifNil: [ ^ head = anObject  ].
	^ tail contains: anObject 
]

{ #category : #comparing }
ChainList >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ head hash bitXor: (tail hash bitXor: size hash)
]

{ #category : #accessing }
ChainList >> head [ 
	^ head.
]

{ #category : #initialization }
ChainList >> initialize [ 
	super initialize.
	size := 0. 
]

{ #category : #testing }
ChainList >> isEmpty [ 
	^ (head isNil) and: (tail isNil)
]

{ #category : #removing }
ChainList >> removeElt: anObject [
	| res |.
	head = anObject ifTrue: [ 
		head := (tail head).
		tail := (tail tail).
		size := size -1.
		^ 1
		 ].
	(tail  tail) ifNil: [ 
		(tail head) = anObject ifTrue: [ 
			tail := nil.
			^ 1
			 ].
		^ 0
		 ].
	res := (tail removeElt: anObject).
	size := size - res.
	^ res.

	
	
	

]

{ #category : #accessing }
ChainList >> size [ 
	^ size
]

{ #category : #accessing }
ChainList >> tail [ 
	^ tail.
]
