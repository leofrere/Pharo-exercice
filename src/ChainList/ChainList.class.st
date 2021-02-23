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

{ #category : #accessing }
ChainList >> changeValueAt: index and: anObject [ 
	index >= size ifTrue: [ IndexError new signal: 'IndexOutOfBoundError' ].
	index = 0 ifTrue: [ 
		head := anObject.
		^ true 
		 ].
	^ tail changeValueAt: index-1 and: anObject 
	
]

{ #category : #comparing }
ChainList >> contains: anObject [ 
	head = anObject ifTrue: [ ^ true ].
	tail ifNil: [ ^ head = anObject  ].
	^ tail contains: anObject 
]

{ #category : #accessing }
ChainList >> eltAt: index [ 
	index >= size ifTrue: [ IndexError new signal: 'IndexOutOfBoundError' ].
	index = 0 ifTrue: [ ^ head ].
	^ tail eltAt: index-1
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

{ #category : #accessing }
ChainList >> indexOf: anObject [ 
	(self contains: anObject) ifFalse: [ ^ -1 ].
	head = anObject ifTrue: [ ^ 0 ].
	^ 1 + (tail indexOf: anObject)
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

{ #category : #accessing }
ChainList >> lastIndexOf: anObject [ 
	(self contains: anObject) ifFalse:[ ^ -1 ].
	head = anObject ifTrue: [ ^ 1 max: (tail lastIndexOf: anObject) ].
	^ 1 + (tail lastIndexOf: anObject) 
	
]

{ #category : #removing }
ChainList >> removeAt: index [ 
	index >= size ifTrue: [ IndexError new signal: 'IndexOutOfBoundError' ].
	size := size -1.
	index = 0 ifTrue: [ 
		head := tail head.
		tail := tail tail.
		^ true
		 ].
	(index = 1 and: tail tail isNil)  ifTrue: [ 
		tail := nil.
		^ true
		 ].
	^ tail removeAt: index-1
]

{ #category : #removing }
ChainList >> removeElt: anObject [
	(self contains: anObject)ifFalse: [ ^ false ]. 
	size := size -1.
	head = anObject ifTrue: [ 
		head := (tail head).
		tail := (tail tail).
		^ true
		 ].
	(tail  tail) ifNil: [ 
			tail := nil.
			^ true
		 ].
	^ (tail removeElt: anObject)

	
	
	

]

{ #category : #accessing }
ChainList >> size [ 
	^ size
]

{ #category : #accessing }
ChainList >> tail [ 
	^ tail.
]
