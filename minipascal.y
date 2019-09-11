%{
	#include <stdio.h>
	#include <stdlib.h>	
	#include "symboltable.h"
	int yylex();
	int yyerror();
	extern FILE* yyin;
	extern int rnum, cnum;
	LIST_NODE_PTR hashTable[TABLE_SIZE];
	int scope_counter,isArg, isDecl, needDec;
%}

/*Adding %expect as we expect one shift-reduce conflict that need not be resolved*/

%token BEG PROG FUNC PROC INTEGER ID SEMICOLON PERIOD VAR COLON LP RP LS RS COMMA ARR OF IF THEN ELSE END ASSGN RETURN READ WRITELN ASSERT WHILE DO RELOP ADDOP OR MULOP NOT STRING_LITERAL SIZE DATATYPE
%define parse.error verbose
%expect 1

%%
program :{isDecl++;} PROG ID SEMICOLON {isDecl--;} block PERIOD
	;
declaration : VAR {isDecl++;} ID declaration_prime COLON type {isDecl--;}
	| PROC {isDecl++;} ID LP {isArg++;} parameters RP {isArg--;} SEMICOLON {isDecl--;scope_counter ++;} block {scope_counter --;}
	| FUNC {isDecl++;} ID LP {isArg++;} parameters RP {isArg--;} COLON type SEMICOLON  {isDecl--;scope_counter ++;} block {scope_counter --;}
	;
declaration_prime: COMMA ID declaration_prime
	|
	;
parameters : ID COLON type parameters_prime
	| VAR ID COLON type parameters_prime
	|
	;
parameters_prime: COMMA ID COLON type
	| COMMA VAR ID COLON type
	|
	;
type : DATATYPE 
	| array_type
	;
array_type: ARR LS RS OF DATATYPE
	| ARR LS expr RS OF DATATYPE
	;

/*
In original grammar, productions were of the form 
	block: BEG statement block_prime END
		| BEG statement block_prime SEMICOLON END
		;
	block_prime: SEMICOLON statement block_prime
		|
		;
This leads to a shift reduce conflict when a SEMICOLON is enscope_countered, hence the grammar was modified as below
*/

block: BEG statement block_prime END
	;
block_prime: SEMICOLON statement block_prime
	| SEMICOLON
	|
	;
statement: {scope_counter++;} structured_statement {scope_counter--;} 
	| simple_statement
	|  declaration 
	;
simple_statement: assignment_statement
	| call
	| return_statement
	| read_statement
	| write_statement
	| assert_statement
	;
assignment_statement: variable ASSGN expr
	;
call: ID LP {isArg++;} arguments {isArg--;} RP	
	;
arguments: expr arguments_prime 
	|
	;
arguments_prime: COMMA expr arguments_prime
	|
	;
return_statement: RETURN 
	| RETURN expr
	;
read_statement: READ LP {isArg++;} variable read_statement_prime RP {isArg--;}
	;
read_statement_prime: COMMA variable read_statement_prime
	|
	;
write_statement: WRITELN LP {isArg++;} arguments RP {isArg--;}
	;
assert_statement: ASSERT LP {isArg++;} expr RP  {isArg--;}
	;
structured_statement: block 
	| if_statement
	| while_statement
	;

/* We need not worry about shift-reduce conflict in the below production as by default, bison shifts which is what we want here*/	

if_statement: IF expr THEN statement
	| IF expr THEN statement ELSE statement
	;
while_statement: WHILE expr DO statement
	;
expr: simple_expr
	| simple_expr RELOP simple_expr
	;
simple_expr: term simple_expr_prime
	| ADDOP term simple_expr_prime
	;
simple_expr_prime: add_operator term simple_expr_prime
	|
	;
term: factor term_prime
	;
term_prime: MULOP factor term_prime
	|
	;

/*
In original grammar, productions were of the form 
	factor: call
		| variable
		| literal
		| LP expr RP 
		| NOT factor
		| factor PERIOD SIZE
		;
However this leads to a shift reduce conflict and since only array_id.Size is a valid, the production has been modified as such
*/

factor: call
	| variable
	| literal
	| LP expr RP 
	| NOT factor
	| ID PERIOD SIZE
	;
variable: ID 
	| ID LS expr RS
	;
add_operator: ADDOP
	| OR
	;
literal: INTEGER
	| real_literal
	| STRING_LITERAL
	;
real_literal: INTEGER PERIOD INTEGER
	| INTEGER PERIOD INTEGER "e" INTEGER
	| INTEGER PERIOD INTEGER "e" ADDOP INTEGER
	;

%%
int yyerror(const char *str){
    printf("\nError encountered at line %d, col %d: %s\n",rnum,cnum,str);
    return 1;
}
void main (){
	scope_counter = 0;
	isDecl = 0; isArg = 0, needDec = 0;
	for(int i = 0; i < TABLE_SIZE; i++) 
		hashTable[i] = NULL;
	yyin = fopen("input.txt","r");
	if(yyin	 == NULL){
		printf("Can't open file\n");
		exit(1);
	}
	do{
		if(yyparse()){
			printf("FAILURE\n");
			exit(0);
		}
	}while(!feof(yyin));

	printf("----------SYMBOL TABLE----------\n");
	dispTable2(hashTable,TABLE_SIZE);
	printf("--------------------------------\n");
	printf("Parsing is Complete.\n");
}
