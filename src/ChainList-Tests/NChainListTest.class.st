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
NChainListTest >> testContainsElt [
	l add: 0.
	l add: 1.
	self assert: (l contains: 1)
]

{ #category : #tests }
NChainListTest >> testEquals [ 
	| list |
	list := ChainList new
	add: 0;
	add: 1;
	yourself.
	l add: 0.
	l add: 1.
	self assert: l = list
	
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
	l add: 0.
	self assert: (l isEmpty) equals: false
]

{ #category : #tests }
NChainListTest >> testNotContainsElt [
	l add: 0.
	l add: 1.
	self assert: (l contains: 2) equals: false
]

{ #category : #tests }
NChainListTest >> testNotEquals [ 
	| list |
	list := ChainList new
	add: 0;
	add: 2;
	yourself.
	l add: 0.
	l add: 1.
	self assert: (l = list) equals: false
	
]

{ #category : #tests }
NChainListTest >> testSize [
	l add: 0.
	l add: 1.
	l add: 2.
	self assert: (l size) equals: 3 
]
