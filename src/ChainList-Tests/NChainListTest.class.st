"
This class contains tests for ChainList
"
Class {
	#name : #NChainListTest,
	#superclass : #TestCase,
	#category : #'ChainList-Tests'
}

{ #category : #tests }
NChainListTest >> testAccessHead [
	| l |
	l := ChainList new.
	self assert: (l head) isNil. 
]

{ #category : #tests }
NChainListTest >> testAccessTail [
	| l |
	l := ChainList new.
	self assert: (l tail) isNil.
]

{ #category : #tests }
NChainListTest >> testAddMoreOneObject [
	| l |
	l := ChainList new.
	l add: 0.
	l add: 1.
	self assert: ((l tail) head) equals: 1.
]

{ #category : #tests }
NChainListTest >> testAddOneObject [
	| l |
	l := ChainList new.
	l add: 0.
	self assert: (l head) equals: 0.

	
]

{ #category : #tests }
NChainListTest >> testInitializeChainList [
	| l |
	l := ChainList new.
	self assert: (l head) isNil.
	self assert: (l tail) isNil.  
]
