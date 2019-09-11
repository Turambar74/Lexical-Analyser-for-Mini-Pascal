#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define TABLE_SIZE 25

typedef enum identifier_type {FUNC_ID,PROC_ID,VAR_ID,PROG_ID} ID_TYPE;
//typedef enum scope {LOCAL,GLOBAL} SCOPE;
//typedef enum return_type {,GLOBAL} RETURN_TYPE;

typedef struct list_node{
	char *lexemename;
	ID_TYPE idt;
	//int size;
	int scope;
	char *return_type;
	int index;
	//RETURN_TYPE return_type;
	struct list_node* next;
} LIST_NODE;
typedef LIST_NODE* LIST_NODE_PTR;


LIST_NODE_PTR createListNode(char *lexemename, ID_TYPE idt, int scope, char *ret_type);

void printListNode(LIST_NODE_PTR ln_ptr);

LIST_NODE_PTR* initializeTable(int table_size);

int hash(char *str, int table_size);

int searchList(LIST_NODE_PTR head, LIST_NODE_PTR ln_ptr);

int searchTable(LIST_NODE_PTR *hashTable, int table_size, LIST_NODE_PTR ln_ptr);

void insertList(LIST_NODE_PTR *headref, LIST_NODE_PTR ele);

void insertTable(LIST_NODE_PTR *hashTable, int table_size, LIST_NODE_PTR ln_ptr);

void dispTable2(LIST_NODE_PTR *hashTable,int table_size);
#endif /* SYMBOLTABLE_H */