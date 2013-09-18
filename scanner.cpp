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
  m_currentToken.setSymTabEntry(m_symbolTable->insert(lexeme));
}

SymbolTable* Scanner::getSymbolTable(void)
{
  return m_symbolTable;
}

Token* Scanner::nextToken(void)
{
  TokenCode tCode = static_cast<TokenCode>(m_lexer->yylex());
  setCurrentToken(tCode,Type,Oper);
  std::string lex = m_lexer->YYText();
  std::cout << "lex:" << lex << "\n";
  if(tCode == tc_ID || tCode == tc_NUMBER) {
    m_currentToken.setSymTabEntry(m_symbolTable->insert(lex));
  }
  return &m_currentToken;
}
