%option c++
%option yylineno
%option noyywrap
%option caseless

%{
#define MaxLexemeSize 32
#define TOOLONG(s) strlen(s)>MaxLexemeSize
#include "token.h"

OpType Oper=op_NONE;
DataType Type=dt_NONE;
%}

letter [a-zA-Z]
digit [0-9]

id {letter}({letter}|{digit})*

digits {digit}{digit}*
int_num {digits}

optional_fraction (\.{int_num})?
optional_exponent (E(\+|-)?{int_num})?
real_num {int_num}{optional_fraction}{optional_exponent}

open_comment \{
close_comment \}
comment_body [^{}]*
comment {open_comment}{comment_body}{close_comment}

program (?i:program)
var (?i:var)
real (?i:real)
integer (?i:integer)
begin (?i:begin)
end (?i:end)

%%
[ \t\n]+   {}
{comment} {}

{program} {Oper = op_NONE; Type = dt_KEYWORD;  return(tc_PROGRAM);}
{var}     {Oper = op_NONE; Type = dt_KEYWORD;  return(tc_VAR);}
{real}    {Oper = op_NONE; Type = dt_KEYWORD;  return(tc_REAL);}
{integer} {Oper = op_NONE; Type = dt_KEYWORD;  return(tc_INTEGER);}
{begin}   {Oper = op_NONE; Type = dt_KEYWORD;  return(tc_BEGIN);}
{end}     {Oper = op_NONE; Type = dt_KEYWORD;  return(tc_END);}

"="     {Oper = op_EQ; Type = dt_OP; return(tc_RELOP);}
"<>"    {Oper = op_NE; Type = dt_OP; return(tc_RELOP);}
"<"     {Oper = op_LT; Type = dt_OP; return(tc_RELOP);}
"<="    {Oper = op_LE; Type = dt_OP; return(tc_RELOP);}
">="    {Oper = op_GE; Type = dt_OP; return(tc_RELOP);}
">"     {Oper = op_GT; Type = dt_OP; return(tc_RELOP);}

"+"     {Oper = op_PLUS;  Type = dt_OP; return(tc_ADDOP);}
"-"     {Oper = op_MINUS; Type = dt_OP; return(tc_ADDOP);}
"or"    {Oper = op_OR;    Type = dt_OP; return(tc_ADDOP);}

"*"     {Oper = op_MULT;   Type = dt_OP; return(tc_MULOP);}
"/"     {Oper = op_DIVIDE; Type = dt_OP; return(tc_MULOP);}
"div"   {Oper = op_DIV;    Type = dt_OP; return(tc_MULOP);}
"mod"   {Oper = op_MOD;    Type = dt_OP; return(tc_MULOP);}
"and"   {Oper = op_AND;    Type = dt_OP; return(tc_MULOP);}

":="    {Oper = op_NONE; Type = dt_OP;   return(tc_ASSIGNOP);}
";"     {Oper = op_NONE; Type = dt_NONE; return(tc_SEMICOL);}
":"     {Oper = op_NONE; Type = dt_NONE; return(tc_COLON);}
","     {Oper = op_NONE; Type = dt_NONE; return(tc_COMMA);}
"."     {Oper = op_NONE; Type = dt_NONE; return(tc_DOT);}
"("     {Oper = op_NONE; Type = dt_NONE; return(tc_LPAREN);}
"["     {Oper = op_NONE; Type = dt_NONE; return(tc_LBRACKET);}
")"     {Oper = op_NONE; Type = dt_NONE; return(tc_RPAREN);}
"]"     {Oper = op_NONE; Type = dt_NONE; return(tc_RBRACKET);}
"then"  {Oper = op_NONE; Type = dt_NONE; return(tc_THEN);}
"else"  {Oper = op_NONE; Type = dt_NONE; return(tc_ELSE);}
"if"	{Oper = op_NONE; Type = dt_NONE; return(tc_IF);}
<<EOF>> {Oper = op_NONE; Type = dt_NONE; return(tc_EOF);}

{int_num}  {Oper = op_NONE; Type = dt_INTEGER; return(tc_NUMBER);}
{real_num} {Oper = op_NONE; Type = dt_REAL;    return(tc_NUMBER);}

{id} {Oper = op_NONE; Type = dt_ID; 
      if(TOOLONG(yytext)) return(tc_ERROR2); return(tc_ID);}
. {Oper = op_NONE;  Type = dt_NONE;  return(tc_ERROR);}
%%

