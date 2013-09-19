#include "scanner.h"
#include "lex.yy.cc"

Scanner::Scanner(SymbolTable* symbols, std::istream& input, std::ostream& output)
{
 m_symbolTable = symbols;
 m_lexer = new yyFlexLexer(&input,&output);
}

Scanner::~Scanner()
{
  delete m_lexer;
}

void Scanner::setCurrentToken(TokenCode tc, DataType dt, OpType op)
{
  m_currentToken.setTokenCode(tc);
  m_currentToken.setDataType(dt);
  m_currentToken.setOpType(op);
}

void Scanner::setCurrentToken(TokenCode tc, DataType dt, const std::string& lexeme)
{
  m_currentToken.setTokenCode(tc);
  m_currentToken.setDataType(dt);
  SymbolTableEntry* ste = m_symbolTable->lookup(lexeme);
  if(ste == NULL)
    ste = m_symbolTable->insert(lexeme);
  m_currentToken.setSymTabEntry(ste);
}

SymbolTable* Scanner::getSymbolTable(void)
{
  return m_symbolTable;
}

Token* Scanner::nextToken(void)
{
  TokenCode tCode;
  std::string lex;
  do {
  tCode = static_cast<TokenCode>(m_lexer->yylex());
  } while(tCode == tc_SPACE || tCode == tc_COMMENT ||
         tCode == tc_NEWLINE || tCode == tc_TAB);
  lex = m_lexer->YYText();
  std::transform( lex.begin(), lex.end(), lex.begin(),::tolower );
  if(tCode == tc_ID || tCode == tc_NUMBER) {
    setCurrentToken(tCode,Type,lex);
  }
  else {
    setCurrentToken(tCode,Type,Oper);
  }
  return &m_currentToken;
}
