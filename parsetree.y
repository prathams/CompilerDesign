%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include<string.h>
#include "node.h"
#include "symbol.h"

void yyerror(char *s);
extern int yylineno;
int size;

%}
%union {
	int ival;
	char *bool;
	char *str1;
	struct nodeType *a_tree;
}
%start program
%token PROGRAM START END VAR AS SC READINT WRITEINT IF THEN ELSE WHILE DO LP RP INT BOOL ASGN  
%token<ival> num OP2 OP3 OP4
%token<bool> boollit 
%token<str1> ident 
%type <a_tree>  start program declaration type statementSequence statement assignment ifStatement elseClause whileStatement writeInt expression simpleExpression term factor

%%
start : program {$$ = create_node(START,1,$1); Gen_Code($1); } ;
program : PROGRAM declarations START statementSequence END { $$ = create_node(PROGRAM, 2, $2, $4); }
//{ BINARY_TREE parseTree;
//parseTree = create_node($2,$4);
//}
  ;
declarations : VAR ident AS type SC declarations { $$ = create_node(DECLARATION, 3, $2, $4, $6); }
               |  {$$ = NULL;}
		;
type : INT    	 {$$ = str("int");}
	| BOOL	 {$$ = str("bool");}
		;
statementSequence : statement SC statementSequence { $$ = create_node(STATEMENTSEQUENCE, 2, $1, $3); }
                    | 	{$$ = NULL;}
		;
statement : assignment	{ $$ = create_node(STATEMENT,1,$1);}
            | ifStatement { $$ = create_node(STATEMENT,1,$1);}
            | whileStatement { $$ = create_node(STATEMENT,1,$1);}
            | writeInt { $$ = create_node(STATEMENT,1,$1);}
	    ;
assignment : ident ASGN expression	{ $$ = create_node(ASGN, 2, variable("var"), $3); }
             | ident ASGN READINT       { int x; scanf("%d", &x); 
					$$ = create_node(ASGN, 2, variable("var"), NULL); }
		;
ifStatement : IF expression THEN statementSequence elseClause END	{ $$ = create_node(IF, 3, $2, $4, $5); }
		;
elseClause : ELSE statementSequence	{ $$ = create_node(ELSE, 1, $2); }
             |  {$$ = NULL;}
		;
whileStatement : WHILE expression DO statementSequence END { $$ = create_node(WHILE, 2, $2, $4); }
		;
writeInt : WRITEINT expression { $$ = create_node(WRITEINT, 1, $2); }
		;
expression : simpleExpression { $$ = $1;}
             | simpleExpression OP4 simpleExpression { $$ = create_node($2, 2, $1, $3); }
	     ;
simpleExpression : term OP3 term { $$ = create_node($2, 2, $1, $3); }
                   | term { $$ = $1;}
		;
term : factor OP2 factor { $$ = create_node($2, 2, $1, $3); }
       | factor { $$ = $1;}
	;
factor : ident { $$ = variable("var"); }
         | num { $$ = literal($1); }
         | boollit { $$ = literal($1); }
         | LP expression RP { $$ = $2; }
	 ;
%%
nodeType* search(char* srch)
{
nodeType* ptr;
int i,flag=0;
		struct SymbTab *p;
		ptr->type = typeVar;
		ptr->variable.name =first;
		for(i=0;i<size;i++)
		{
                    if(strcmp(p->label,srch)==0)
                        flag=1;
                    ptr->variable.name=p->next;
		}
return ptr;
}
nodeType* str(char* str) {
	nodeType* ptr;

	if ((ptr = malloc(sizeof(nodeType))) == NULL)
	yyerror("out of memory");

	ptr->type = typeStr;
	ptr->str.name = str;

	return ptr;
}
nodeType* literal(int value) {
	nodeType* ptr;

	if ((ptr = malloc(sizeof(nodeType))) == NULL)
	yyerror("out of memory");

	ptr->type = typeLit;
	ptr->literal.value = value;

	return ptr;
}
nodeType* create_node(int operation, int num_ops, ...) {
	va_list x;
	nodeType* ptr;
	int i;
	if ((ptr = malloc(sizeof(nodeType))) == NULL)
	yyerror("out of memory");
	if ((ptr->op.operands = malloc(num_ops * sizeof(nodeType*))) == NULL)
	yyerror("out of memory");
	ptr->type = typeOp;
	ptr->op.operation = operation;
	ptr->op.num_ops = num_ops;
	va_start(x, num_ops);
	for (i = 0; i < num_ops; i++)
	ptr->op.operands[i] = va_arg(x, nodeType*);
	va_end(x);
	return ptr;
}
nodeType* variable(char* name) {
	nodeType* ptr;

	if ((ptr = malloc(sizeof(nodeType))) == NULL)
	yyerror("out of memory");

	ptr->type = typeVar;
	ptr->variable.name = name;

	return ptr;
}

void Gen_Code(nodeType *p)
{
	if(p==NULL) return;
		switch(p->type)
		{	
			case(PROGRAM) :
			printf("\n#include<stdio.h>\n");
			printf("#include<string.h>\n");
			printf("int main(void) {\n");
			Gen_Code(p->op.operands[1]);
			printf("}\n");
			return;

			case(DECLARATION) :
			Gen_Code(p->op.operands[1]);
			Gen_Code(p->op.operands[2]);
			printf(";\n");
			if(p->op.operands[3]!=NULL)
			Gen_Code(p->op.operands[3]);
			return;

			case(INT):
			printf("%s","int");
			return;

			case(BOOL):
			printf("%s","bool");
			return;

			case(StatementSequence) :
			if(p->op.operands[1]!= NULL)
			{
				Gen_Code(p->op.operands[1]);
				temp1 = temp->body.node2.left;
				temp2 = temp1->body.node3.mid;
				if(temp2->nodetype != IF && temp2->nodetype != WHILE)
				{ 					
					printf(";\n");
				}
				if(p->op.operands[3]!=NULL)
				{
					Gen_Code(p->op.operands[3]);
				}
			}
				return;
			
			case(Statement) :
			Gen_Code(p->op.operands[2]);
			return;

			case(ASGN) :
			if(p->op.operands[1]!= NULL)
			{
				Gen_Code(p->op.operands[2]);
				printf("=");
				Gen_Code(p->op.operands[1]);
			}
			else
			{
				printf("\nscanf(\"\%%d\",&");
				Gen_Code(p->op.operands[2]);
				printf(")");
			}

			case(WRITEINT) :
			printf("\nprintf(%d",");
			Gen_Code(p->op.operands[1]);
			printf(")");

			
			case(IF) :
			print("if (");
			Gen_Code(p->op.operands[1]);
			printf(") {\n");
			Gen_Code(p->op.operands[2]);
			printf(" }\n");
			return;

			case(ELSE) :
			printf(" {\n");
			Gen_Code(p->op.operands[2]);
			printf(" }\n");
			return;

			case(WHILE) :
			print("while (");
			Gen_Code(p->op.operands[1]);
			printf(") do {\n");
			Gen_Code(p->op.operands[2]);
			printf(" }\n");
			return;

			case(EXPR) :
			if(p->op.operands[3]!= NULL)
				{
					Gen_Code(p->op.operands[1]);
					Gen_Code(p->op.operands[2]);
					Gen_Code(p->op.operands[3]);
	    			}
	   			else
	   				Gen_Code(p->op.operands[1]);
			return;

			case(SIMPLEEXPR) :
			if(p->op.operands[3]!= NULL)
				{
					Gen_Code(p->op.operands[1]);
					Gen_Code(p->op.operands[2]);
					Gen_Code(p->op.operands[3]);
	    			}
	   			else
	   				Gen_Code(p->op.operands[1]);
			return;

			case(TERM) :
			if(temp->body.node1.right != NULL)
				{
					Gen_Code(temp->body.node1.left);
					Gen_Code(temp->body.node1.mid);
					Gen_Code(temp->body.node1.right);
	    			}
	   			else
	   				Gen_Code(temp->body.node2.left);
			return;

			case(FACTOR) :
			if(p->op.operands[2]!=NULL)
				{
 					printf("(");
					Gen_Code(p->op.operands[2]);
					printf(")");
 					
				}
			return;

			case(IDENT) :
			if(strcmp(p->str,"mod")==0)
					printf("\%% ");
				else if(strcmp(p->str,"div")==0)
					printf("/ ");
				else if(strcmp(p->str,"=")==0)
					printf("==");
				else
					printf("%s",p->str);
				return;

			case(NUM) :
			printf(" %u ",p->literal.value);
				return;

			case(BOOLLIT) :
			printf(" %s ",p->literal.value);
				return;
		}
}


void yyerror(char *msg){
fprintf(stderr,"%s : on line %d\n",msg,yylineno);
exit(1);
}
int main(void){
yyparse();
printf("******************PARSING COMPLETED****************\n\n");
}
