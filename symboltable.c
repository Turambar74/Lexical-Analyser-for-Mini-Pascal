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


LIST_NODE_PTR createListNode(char *lexemename, ID_TYPE idt, int scope, char *ret_type){
	LIST_NODE_PTR ln_ptr = malloc(sizeof(LIST_NODE));
	ln_ptr->lexemename = malloc(sizeof(lexemename));
	strcpy(ln_ptr->lexemename,lexemename);
	ln_ptr->idt = idt;
	//ln_ptr->size = size;
	ln_ptr->scope = scope;
	ln_ptr->return_type = malloc(sizeof(char)*strlen(ret_type));
	//if(idt == FUNC_ID)
		strcpy(ln_ptr->return_type,ret_type);
//	else{
//		printf("Is this a legal move?\n");
//		strcpy(ln_ptr->return_type,"");
//		printf("Yes\n");
//	}
	ln_ptr->next = NULL;
	return ln_ptr;
}

void printListNode(LIST_NODE_PTR ln_ptr){
	char type_str[15],scope_str[10];
	int entry_size = strlen(ln_ptr->lexemename)*sizeof(char);
	switch(ln_ptr->idt){
		case FUNC_ID:
			strcpy(type_str,"FUNC_ID");
			break;
		case PROC_ID:
			strcpy(type_str,"PROC_ID");
			break;
		case VAR_ID:
			strcpy(type_str,"VAR_ID");
			break;
		case PROG_ID:
			strcpy(type_str,"PROG_ID");
			break;
	}
	switch(ln_ptr->scope){
		case 0:
			strcpy(scope_str,"GLOBAL");
			break;
		default:
			strcpy(scope_str,"LOCAL ");
			break;
	}
	printf("%s\t%s\t%s(%d)\t%d\n",ln_ptr->lexemename,type_str,scope_str,ln_ptr->scope,ln_ptr->index);
}

LIST_NODE_PTR* initializeTable(int table_size){
	LIST_NODE_PTR *hashTable = malloc(sizeof(LIST_NODE_PTR)*table_size);
	for(int i = 0; i < table_size; i++){
		hashTable[i] = NULL;
		//hashTable[i]->next = NULL;
	} 
	return hashTable;
}

void dispList(LIST_NODE_PTR head){
	LIST_NODE_PTR temp = head;
	while(temp){
		printListNode(temp);
		printf(" --> ");
		temp = temp->next;
	}
	printf("NULL\n");
}

// void dispTable(LIST_NODE_PTR *hashTable,int table_size){
// 	for(int i = 0; i < table_size; i++)
// 		dispList(hashTable[i]);
// }

int hash(char *str, int table_size){
	int hashKey = 0;
	for(int i = 0; str[i] != '\0'; i++)
		hashKey = (hashKey*101 + str[i])%table_size;
	return hashKey;
}

int searchList(LIST_NODE_PTR head, LIST_NODE_PTR ln_ptr){
	LIST_NODE_PTR temp = head;
	while(temp){
		if(strcmp(ln_ptr->lexemename,temp->lexemename) == 0 && (ln_ptr->scope == temp->scope))
			return 1;
		temp = temp->next;
	}
}

int searchTable(LIST_NODE_PTR *hashTable, int table_size, LIST_NODE_PTR ln_ptr){
	for(int i = 0; i < table_size; i++)
		if(searchList(hashTable[i],ln_ptr))
			return 1;

	return 0;
}

void insertList(LIST_NODE_PTR *headref, LIST_NODE_PTR ele){

	if(*headref == NULL){
		*headref = ele;
		return;
	}

	LIST_NODE_PTR temp = *headref;

	while(temp->next != NULL){
		temp = temp->next;//Seek to last list_node
	}

	temp->next = ele;
}

void insertTable(LIST_NODE_PTR *hashTable, int table_size, LIST_NODE_PTR ln_ptr){
	//printf("zdsdf\n");
	if(searchTable(hashTable,table_size,ln_ptr))
		return;
	//printf("dfsdf\n");
	insertList(hashTable + hash(ln_ptr->lexemename,table_size),ln_ptr);
}

void dispTable2(LIST_NODE_PTR *hashTable,int table_size){
	printf("Name\tType\tScope\tIndex\n");
	for(int i = 0; i < table_size; i++){
		for(LIST_NODE_PTR ptr = hashTable[i]; ptr != NULL; ptr=ptr->next){
			ptr->index = hash(ptr->lexemename,table_size);
			printListNode(ptr);
		}
	}
}
#endif /* SYMBOLTABLE_H */