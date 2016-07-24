#include<stdio.h>
#include<stdlib.h>
#include<stdarg.h>
#include<string.h>
#include "node.h"

int size=0;
int q=0;
int i=0;
int Insert(char lab[]);
int Search(char lab[]);
struct SymbTab
{
	char label[10];
	char name[10];
	struct SymbTab *next;
};
struct SymbTab *first,*last;
int sym[26];
int ex(nodeType *p);
int yylex(void);


int Insert(char lab[])
{
		int n,j;
		int fg;
		n=Search(lab);
		switch(temp->nodetype)
		{
			case INT:
				fg = 1;
				break;
			case BOOL:
				fg = 2;
				break;
		}
		if(n==0)
		{
				struct SymbTab *p;
				p=malloc(sizeof(struct SymbTab));
				strcpy(p->label,lab);
				if(fg==1)
					p->name="int";
				if(fg==2)
					p->name="bool";
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
void declare(char *s,int a)
{
	int check = 0;
	struct symbTtab *dc;
	for(dc = next; dc < &next[size]; dc++)
		if(strcmp(dc->name,s)==0)
		{
			check = 1;
			break;	
		}
	if(check!=1)
		printf("%s is not declared line : %d\n", s,a);
	
}
void typecheck(char *s, int a)
{
	int check = 0;
	char *type;
	struct symbTab *tc;
	for(tc = next; tc < &next[size]; tc++)
	{
		if((strcmp(tc->name,s)==0))
		{
			check = 1;
			type = tc->type;
			break;	
		}
			
	}
	if(flag==1)
	{
		if(!(strcmp(type_read,"int")==0))
		{
			printf("In line %d Type Mismatch must be of int not bool\n",s,a);
		}
	}	

}
void bound(unsigned int a, int b)
{
	if(!(a>=0 && a<=2147483647))
		 printf("Number literal out of bounds at line %d\n",b);
}
void typeop2(nodeType *n1,nodeType *n2,int a)
{
	ni *temp;
	struct symbTab *top2;
	char *s;
	switch(n1->ni)
	{
		case IDENT:
			s = n1->nodeType.op.name;			
			for(top2 = next; top2 < &next[val]; top2++)
			{
				if((strcmp(top2->name,s)==0))
				{
					if(!(strcmp(top2->type,"int")==0))
						printf("type error at %d, should be a %s type",a,"int");
					break;	
				}
			}
			break;
		case BOOLIT:
			printf("type error at %d, should be a %s type",a,"int");
			break;
		case FACTOR:
			temp = n1->op.operand[2];
			type_expression(temp,a);
			break;
	}
	switch(n2->ni)
	{
		case IDENT:
			s = n2->nodeType.op.name;			
			for(top2 = next; top2 < &next[size]; top2++)
			{
				if((strcmp(top2->name,s)==0))
				{
					if(!(strcmp(top2->type,"int")==0))
						printf("type error at %d, should be a %s type",a,"int");
					break;	
				}
			}
			break;
		case BOOLIT:
			printf("type error at %d, should be a %s type",a,"int");
			break;
		case FACTOR:
			temp = n2->op.operand[2];
			type_expression(temp,a);
			break;
	}
}
void typeop3(nodeType *n1,nodeType *n2,int a)
{
	ni *temp;
	struct symbTab *top3;
	char *s;
	switch(n1->ni)
	{
		case IDENT:
			s = n1->nodeType.op.name;			
			for(top2 = next; top3 < &next[val]; top2++)
			{
				if((strcmp(top3->name,s)==0))
				{
					if(!(strcmp(top3->type,"int")==0))
						printf("type error at %d, should be a %s type",a,"int");
					break;	
				}
			}
			break;
		case BOOLIT:
			printf("type error at %d, should be a %s type",a,"int");
			break;
		case FACTOR:
			temp = n1->op.operand[2];
			type_expression(temp,a);
			break;
	}
	switch(n2->ni)
	{
		case IDENT:
			s = n2->nodeType.op.name;			
			for(top2 = next; top3 < &next[size]; top2++)
			{
				if((strcmp(top3->name,s)==0))
				{
					if(!(strcmp(top3->type,"int")==0))
						printf("type error at %d, should be a %s type",a,"int");
					break;	
				}
			}
			break;
		case BOOLIT:
			printf("type error at %d, should be a %s type",a,"int");
			break;
		case FACTOR:
			temp = n2->op.operand[2];
			type_expression(temp,a);
			break;
	}
}
void typeop4(nodeType *n1,nodeType *n2,int a)
{
	ni *temp;
	struct symbTab *top4;
	char *s;
	switch(n1->ni)
	{
		case IDENT:
			s = n1->nodeType.op.name;			
			for(top2 = next; top4 < &next[val]; top2++)
			{
				if((strcmp(top4->name,s)==0))
				{
					if(!(strcmp(top2->type,"int")==0))
						printf("type error at %d, should be a %s type",a,"int");
					break;	
				}
			}
			break;
		case BOOLIT:
			printf("type error at %d, should be a %s type",a,"int");
			break;
		case FACTOR:
			temp = n1->op.operand[2];
			type_expression(temp,a);
			break;
	}
	switch(n2->ni)
	{
		case IDENT:
			s = n2->nodeType.op.name;			
			for(top2 = next; top4 < &next[size]; top2++)
			{
				if((strcmp(top2->name,s)==0))
				{
					if(!(strcmp(top4->type,"int")==0))
						printf("type error at %d, should be a %s type",a,"int");
					break;	
				}
			}
			break;
		case BOOLIT:
			printf("type error at %d, should be a %s type",a,"int");
			break;
		case FACTOR:
			temp = n2->op.operand[2];
			type_expression(temp,a);
			break;
	}
}

