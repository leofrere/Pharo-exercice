Class {
	#name : #ChainList,
	#superclass : #Object,
	#instVars : [
		'head',
		'tail'
	],
	#category : #ChainList
}

{ #category : #adding }
ChainList >> add: anObject [ 
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
ChainList >> head [ 
	^ head.
]

{ #category : #testing }
ChainList >> isEmpty [ 
	^ (head isNil) and: (tail isNil)
]

{ #category : #accessing }
ChainList >> tail [ 
	^ tail.
]
