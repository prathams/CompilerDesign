%{
#include<stdio.h>
#include<string.h>
#include "symbol.h"
#include "parsetree.tab.c"

void yyerror(char *);

%}

%%

"\n"		yylineno++;
[ \r\n\t]*		;
"("		return LP;
")"		return RP;
":="		{				
			yylval.str1 = malloc(strlen(yytext));
			strncpy(yylval.str1, yytext, strlen(yytext));
			return ASGN;
		}

";"		return SC;

"*" | 
"div" | 
"mod"		{	
			yylval.str1 = malloc(strlen(yytext));
			strncpy(yylval.str1, yytext, strlen(yytext));
			return OP2;
		}
"+" | 
"-"		{
			yylval.str1 = malloc(strlen(yytext));
			strncpy(yylval.str1, yytext, strlen(yytext));
			return OP3;
		}
"=" | 
"!=" | 
"<" | 
">" | 
"<=" |
">=" 		{
			yylval.str1 = malloc(strlen(yytext));
			strncpy(yylval.str1, yytext, strlen(yytext));
			return OP4;
		}
if		return IF;
then		return THEN;
else		return ELSE;
begin		return START;
end		return END;
while		return WHILE;
do		return DO;
program		return PROGRAM;
var		return VAR;
as		return AS;
int		return INT;
bool		return BOOL;
writeInt	return WRITEINT;
readInt		return READINT;

[1-9][0-9]*|0	{		
			yylval.ival = atoi(yytext);
			return num;
		}
false|true	{		
			yylval.bool = malloc(strlen(yytext));
			strncpy(yylval.bool, yytext, strlen(yytext));
			return boollit;
		}
[A-Z][A-z0-9]* 	{
			yylval.str1 = malloc(strlen(yytext));
			strncpy(yylval.str1, yytext, strlen(yytext));
			return ident;
		}
.		yyerror("INVALID CHARACTER");
%%
int Insert(char lab[])
{
		int n,j;
		n=Search(lab);
		if(n==0)
		{
				struct SymbTab *p;
				p=malloc(sizeof(struct SymbTab));
				strcpy(p->label,lab);
				p->addr=q;
                                q++;
				p->next=NULL;
				if(size==0)
				{
					first=p;
					last=p;
				}
				else
				{
					last->next=p;
					last=p;
				}
				size++;
				j=1;
				return j;
		}
}

int Search(char lab[])
{
		int i,flag=0;
		struct SymbTab *p;
		p=first;
		for(i=0;i<size;i++)
		{
                    if(strcmp(p->label,lab)==0)
                        flag=1;
                    p=p->next;
		}
		return flag;
}
int yywrap(void)
{
return 1;
}

