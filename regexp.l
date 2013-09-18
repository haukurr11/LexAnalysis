%option c++
%option yylineno
%option noyywrap
%option caseless

%{
#define MaxLexemeSize 32
#include "token.h"

OpType Oper=op_NONE;
DataType Type=dt_NONE;
%}

letter [a-zA-Z]
real_num [0-9]+\.[0-9]+
int_num [0-9]+
%%
[ \t]+   { printf(""); }
"+"     {Oper = op_PLUS;   Type = dt_OP;    return(tc_ADDOP);}
"-"     {Oper = op_MINUS;  Type = dt_OP;    return(tc_ADDOP);}
"or"    {Oper = op_OR;     Type = dt_OP;    return(tc_ADDOP);}
"="     {Oper = op_EQ;     Type = dt_OP;    return(tc_RELOP);}
"<>"    {Oper = op_NE;     Type = dt_OP;    return(tc_RELOP);}
"<"     {Oper = op_LT;     Type = dt_OP;    return(tc_RELOP);}
"<="    {Oper = op_LE;     Type = dt_OP;    return(tc_RELOP);}
">="    {Oper = op_GE;     Type = dt_OP;    return(tc_RELOP);}
">"     {Oper = op_GT;     Type = dt_OP;    return(tc_RELOP);}
":="    {Oper = op_NONE;   Type = dt_OP;    return(tc_ASSIGNOP);}
";"     {Oper = op_NONE;   Type = dt_NONE;  return(tc_SEMICOL);}
":"     {Oper = op_NONE;   Type = dt_NONE;  return(tc_COLON);}
","     {Oper = op_NONE;   Type = dt_NONE;  return(tc_COMMA);}
"."     {Oper = op_NONE;   Type = dt_NONE;  return(tc_DOT);}
"("     {Oper = op_NONE;   Type = dt_NONE;  return(tc_LPAREN);}
")"     {Oper = op_NONE;   Type = dt_NONE;  return(tc_RPAREN);}
"["     {Oper = op_NONE;   Type = dt_NONE;  return(tc_LBRACKET);}
"]"     {Oper = op_NONE;   Type = dt_NONE;  return(tc_RBRACKET);}
EOF     {Oper = op_NONE;   Type = dt_NONE;  return(tc_EOF);}
ERROR   {Oper = op_NONE;   Type = dt_NONE;  return(tc_ERROR);}
ERROR2  {Oper = op_NONE;   Type = dt_NONE;  return(tc_ERROR2);}
"program"  { Oper = op_NONE; Type = dt_KEYWORD; return(tc_PROGRAM);}
{real_num} { Oper = op_NONE; Type = dt_REAL; return(tc_NUMBER);}
{int_num}  { Oper = op_NONE; Type = dt_INTEGER;return(tc_NUMBER);}
%%

int main(void) {
  FlexLexer* lexer = new yyFlexLexer();
  lexer->yylex();
  return 0;
}
