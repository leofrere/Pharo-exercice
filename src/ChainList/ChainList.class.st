"
I represent LinkedList with a head and a tail.
"
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
	"add anObject at the end of the list"
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
	"Change the value of element at index position by anObject"
	index >= size ifTrue: [ IndexError new signal: 'IndexOutOfBoundError' ].
	index = 0 ifTrue: [ 
		head := anObject.
		^ true 
		 ].
	^ tail changeValueAt: index-1 and: anObject 
	
]

{ #category : #comparing }
ChainList >> contains: anObject [ 
	"Return true if anObject is in the list else false"
	head = anObject ifTrue: [ ^ true ].
	tail ifNil: [ ^ head = anObject  ].
	^ tail contains: anObject 
]

{ #category : #accessing }
ChainList >> eltAt: index [ 
	"Return the element at index position"
	index >= size ifTrue: [ IndexError new signal: 'IndexOutOfBoundError' ].
	index = 0 ifTrue: [ ^ head ].
	^ tail eltAt: index-1
]

{ #category : #iteration }
ChainList >> forEach: block [ 
	"Allow to iterate on a ChainList"
	tail ifNil: [ block value: head ].
	tail ifNotNil: [ 
		block value: head.
		tail forEach: block.
		 ]
	 
]

{ #category : #comparing }
ChainList >> hash [
	"Answer an integer value that is related to the identity of the receiver."
	^ head hash bitXor: (tail hash bitXor: size hash)
]

{ #category : #accessing }
ChainList >> head [ 
	"Return the head of list"
	^ head.
]

{ #category : #accessing }
ChainList >> indexOf: anObject [ 
	"Return the first index of anObject in list or return -1 if the element is not in list"
	(self contains: anObject) ifFalse: [ ^ -1 ].
	head = anObject ifTrue: [ ^ 0 ].
	^ 1 + (tail indexOf: anObject)
]

{ #category : #initialization }
ChainList >> initialize [ 
	"initialize a ChainList with head and tail are nil and size = 0"
	super initialize.
	size := 0. 
]

{ #category : #testing }
ChainList >> isEmpty [ 
	"Return true if the list isEmpty else false"
	^ (head isNil) and: (tail isNil)
]

{ #category : #accessing }
ChainList >> lastIndexOf: anObject [ 
	"Return the last index of anObject in the list or return -1 if the anObject is not in the list"
	(self contains: anObject) ifFalse:[ ^ -1 ].
	head = anObject ifTrue: [ ^ 1 max: (tail lastIndexOf: anObject) ].
	^ 1 + (tail lastIndexOf: anObject) 
	
]

{ #category : #removing }
ChainList >> removeAt: index [ 
	"Remove the element at indexPosition or return an IndexError if the index is out of bound"
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
	"Remove the fist occurence of anObject in the list and return true else return false if the anObject is not in the list"
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
	"Return the size of the list"
	^ size
]

{ #category : #accessing }
ChainList >> tail [ 
	"Return the tail of the list"
	^ tail.
]
