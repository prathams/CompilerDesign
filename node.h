typedef enum {
        MUL_OP,
        DIV_OP,
        MOD_OP,
        PLUS_OP,
        MINUS_OP,
        EQ_OP,
        NEQ_OP,
        L_OP,
        G_OP,
        LEQ_OP,
        GEQ_OP
}Arith_Ops;
enum NodeName { START, PROGRAM, DECLARATION, TYPE, STATEMENTSEQUENCE, STATEMENT, ASGN, IF, ELSE, WHILE, WRITEINT, EXPR, SIMPLEEXPR, TERM, FACTOR, INT, BOOL, IDENT, NUM, BOOLLIT };

typedef enum { typeLit, typeVar, typeOp, typeStr } nodeEnum;

//Literal node type
typedef struct {
	int value;
} litNodeType;

//Variable node type
typedef struct {
	char* name; //index in symbol table
} varNodeType;

//String node type for decalarations
typedef struct {
	char* name;
} strNodeType;

//Operator node type
typedef struct {
	int operation;
	int num_ops;
	struct nodeTypeTag **operands;
} opNodeType;

typedef struct nodeTypeTag {
	nodeEnum type;
	NodeName ni;
	int item;
	int nodeIdentifier;
	union {
		litNodeType literal;
		varNodeType variable;
		opNodeType op;
		strNodeType str;
	};
} nodeType;
