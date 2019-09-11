%{

	#include "symboltable.h"
	#include "minipascal.tab.h"
	extern LIST_NODE_PTR hashTable[TABLE_SIZE];
	int rnum = 1, cnum = 1;
	ID_TYPE idt;
	LIST_NODE_PTR ln_ptr;
	char ret_type[10];
	extern int scope_counter,isArg, isDecl,needDec;
%}

%%
"prog" {//printf("%s",yytext); 
	cnum += strlen(yytext);idt = PROG_ID; return PROG;}
"var" {//printf("%s",yytext); 
	cnum += strlen(yytext);idt = VAR_ID; return VAR;}
"func" {//printf("%s",yytext); 
	cnum += strlen(yytext);idt = FUNC_ID; return FUNC;}
"proc" {//printf("%s",yytext); 
	cnum += strlen(yytext);idt = PROC_ID; return PROC;}
"array" {//printf("%s",yytext); 
	cnum += strlen(yytext);return ARR;}
"of" {//printf("%s",yytext); 
	cnum += strlen(yytext);return OF;}
"if" {//printf("%s",yytext); 
	cnum += strlen(yytext);return IF;}
"then" {//printf("%s",yytext); 
	cnum += strlen(yytext);return THEN;}
"else" {//printf("%s",yytext); 
	cnum += strlen(yytext);return ELSE;}
"begin" {//printf("%s",yytext); 
	cnum += strlen(yytext);return BEG;}
"end" {//printf("%s",yytext); 
	cnum += strlen(yytext);return END;}
"return" {//printf("%s",yytext); 
	cnum += strlen(yytext);return RETURN;}
"read" {//printf("%s",yytext); 
	cnum += strlen(yytext);return READ;}
"writeln" {//printf("%s",yytext); 
	cnum += strlen(yytext);return WRITELN;}
"assert" {//printf("%s",yytext); 
	cnum += strlen(yytext);return ASSERT;}
"while" {//printf("%s",yytext); 
	cnum += strlen(yytext);return WHILE;}
"do" {//printf("%s",yytext); 
	cnum += strlen(yytext);return DO;}
"or" {//printf("%s",yytext); 
	cnum += strlen(yytext);return OR;}
"not" {//printf("%s",yytext); 
	cnum += strlen(yytext);return NOT;}
"size" {//printf("%s",yytext); 
	cnum += strlen(yytext);return SIZE;}
("int"|"real"|"char"|"boolean"|"string") {//printf("%s",yytext); 
	cnum += strlen(yytext);return DATATYPE;}
[0-9]+ {//printf("%s",yytext); 
	cnum += strlen(yytext);return INTEGER;}
\"(\\.|[^"\\])*\" {//printf("%s",yytext); 
	cnum += strlen(yytext);return STRING_LITERAL;}
("/"|"*"|"%"|"and") {//printf("%s",yytext); 
	cnum += strlen(yytext);return MULOP;}
("<"|">"|"<="|">="|"=="|"!=") {//printf("%s",yytext); 
	cnum += strlen(yytext);return RELOP;}
("-"|"+") {//printf("%s",yytext); 
	cnum += strlen(yytext);return ADDOP;}
";" {//printf("%s",yytext); 
	cnum += strlen(yytext);return SEMICOLON;}
":" {//printf("%s",yytext); 
	cnum += strlen(yytext);return COLON;}
"," {//printf("%s",yytext); 
	cnum += strlen(yytext);return COMMA;}
"." {//printf("%s",yytext); 
	cnum += strlen(yytext);return PERIOD;}
"(" {//printf("%s",yytext); 
	cnum += strlen(yytext);return LP;}
")" {//printf("%s",yytext); 
	cnum += strlen(yytext);return RP;}
"[" {//printf("%s",yytext); 
	cnum += strlen(yytext);return LS;}
"]" {//printf("%s",yytext); 
	cnum += strlen(yytext);return RS;}
":=" {//printf("%s",yytext); 
	cnum += strlen(yytext);return ASSGN;}
[a-zA-Z][a-zA-Z0-9_]* {//printf("%s",yytext);
	strcpy(ret_type,"void");
	if(!needDec && !isArg){
		ln_ptr = createListNode(yytext,idt,scope_counter,ret_type);
		//printf("yytext =%s\tscope_counter = %d\tisDecl = %d\n",yytext,scope_counter,isDecl);
		insertTable(hashTable,TABLE_SIZE,ln_ptr);
	}
	if(isDecl && !isArg && (needDec == 1)){
		ln_ptr = createListNode(yytext,idt,scope_counter,ret_type);
		//printf("yytext =%s\tscope_counter = %d\tisDecl = %d\n",yytext,scope_counter,isDecl);
		insertTable(hashTable,TABLE_SIZE,ln_ptr);
	}
	if(!isDecl && (needDec==1)){
		fprintf(stderr,"\nError : %s was not declared\n",yytext);
		return 0;
	}
	cnum += strlen(yytext);
	return ID;}
\n {//printf("%s", yytext); 
	cnum = 1; rnum+=1;}
\t {//printf("%s", yytext); 
	cnum += 4;}
. {//printf("%s", yytext);
	cnum += strlen(yytext);}
%%

int yywrap(){
	cnum += strlen(yytext);return 1;
}