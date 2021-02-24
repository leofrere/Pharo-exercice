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
NChainListTest >> testChangeValueAt [
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	l changeValueAt: 2 and: 42.
	self assert: (l eltAt: 2) equals: 42
	
]

{ #category : #tests }
NChainListTest >> testContainsElt [
	l add: 0.
	l add: 1.
	self assert: (l contains: 1)
]

{ #category : #tests }
NChainListTest >> testEltAt [
	l add: 0.
	l add: 1.
	l add: 2.
	self assert: (l eltAt: 1) equals: 1
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
NChainListTest >> testForEach [
	| list |.
	list := ChainList new.
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	l forEach: [ :each | list add: each ].
	self assert: list size equals: 4
	
]

{ #category : #tests }
NChainListTest >> testIncrementSize [
	| len |.
	len := (l size).
	l add: 0.
	self assert: (l size) equals: (len + 1) 
]

{ #category : #tests }
NChainListTest >> testIndexErrorChangeValueAt [
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	self should: [ l changeValueAt: 5 and: 42 ] raise: IndexError
	
]

{ #category : #tests }
NChainListTest >> testIndexErrorEltAt [
	l add: 0.
	l add: 1.
	l add: 2.
	self should: [ l eltAt: 5 ] raise: IndexError 
]

{ #category : #tests }
NChainListTest >> testIndexErrorRemoveAt [ 
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	self should: [ l removeAt: 5 ] raise: IndexError 
]

{ #category : #tests }
NChainListTest >> testIndexOf [ 	
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	self assert: (l indexOf: 2) equals: 2
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
NChainListTest >> testLastIndexOf [ 
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	l add: 1.
	l add: 2.
	l add: 3.
	self assert: (l lastIndexOf: 1) equals: 4 
	
]

{ #category : #tests }
NChainListTest >> testNoLastIndexOf [ 
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	l add: 1.
	l add: 2.
	l add: 3.
	self assert: (l lastIndexOf: 5) equals: -1
	
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
NChainListTest >> testNotIndexOf [ 	
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	self assert: (l indexOf: 5) equals: -1
]

{ #category : #tests }
NChainListTest >> testNotRemoveElt [
	| list |
	list := ChainList new
	add: 0;
	add: 1;
	add: 2;
	yourself.
	l add: 0.
	l add: 1.
	l add: 2.
	l removeElt: 5.
	self assert: list equals: l 
]

{ #category : #tests }
NChainListTest >> testRemoveAt [
	| list |.
	list := ChainList new 
	add: 0;
	add: 1;
	add: 3;
	yourself.  
	l add: 0.
	l add: 1.
	l add: 2.
	l add: 3.
	l removeAt: 2.
	self assert: (l = list)
]

{ #category : #tests }
NChainListTest >> testRemoveElt [
	| list |
	list := ChainList new
	add: 0;
	add: 2;
	yourself.
	l add: 0.
	l add: 1.
	l add: 2.
	l removeElt: 1.
	self assert: (list = l)
]

{ #category : #tests }
NChainListTest >> testRemoveFirstElt [
	| list |
	list := ChainList new
	add: 1;
	add: 2;
	yourself.
	l add: 0.
	l add: 1.
	l add: 2.
	l removeElt: 0.
	self assert: (list = l)
]

{ #category : #tests }
NChainListTest >> testRemoveLastElt [
	| list |
	list := ChainList new
	add: 0;
	add: 1;
	yourself.
	l add: 0.
	l add: 1.
	l add: 2.
	l removeElt: 2.
	self assert: (list = l)
]

{ #category : #tests }
NChainListTest >> testSize [
	l add: 0.
	l add: 1.
	l add: 2.
	self assert: (l size) equals: 3 
]
