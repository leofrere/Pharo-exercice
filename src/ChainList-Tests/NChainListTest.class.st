"
This class contains tests for ChainList
"
Class {
	#name : #NChainListTest,
	#superclass : #TestCase,
	#instVars : [
		'l'
	],
	#category : #'ChainList-Tests'
}

{ #category : #running }
NChainListTest >> setUp [
	super setUp. 
	l := ChainList new.

]

{ #category : #tests }
NChainListTest >> testAccessHead [
	self assert: (l head) isNil. 
]

{ #category : #tests }
NChainListTest >> testAccessTail [
	self assert: (l tail) isNil.
]

{ #category : #tests }
NChainListTest >> testAddMoreOneObject [
	l add: 0.
	l add: 1.
	self assert: ((l tail) head) equals: 1.
]

{ #category : #tests }
NChainListTest >> testAddOneObject [
	l add: 0.
	self assert: (l head) equals: 0.

	
]

{ #category : #tests }
NChainListTest >> testInitializeChainList [
	self assert: (l head) isNil.
	self assert: (l tail) isNil.  
]

{ #category : #tests }
NChainListTest >> testIsEmpty [ 
	self assert: (l isEmpty)
]

{ #category : #tests }
NChainListTest >> testIsNotEmpty [ 
	self assert: (l isEmpty) equals: false
]
