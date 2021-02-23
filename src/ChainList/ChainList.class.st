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

{ #category : #accessing }
ChainList >> size [ 
	^ size
]

{ #category : #accessing }
ChainList >> tail [ 
	^ tail.
]
