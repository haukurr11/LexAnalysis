#include "token.h"

Token::Token(void)
{
 m_symtabEntry = NULL;
}

Token::~Token()
{
  delete m_symtabEntry;
}

TokenCode Token::getTokenCode(void) const
{
  return m_tokenCode;
}

DataType Token::getDataType(void) const
{
  return m_dataType;
}

OpType  Token::getOpType(void) const
{
  return m_opType;
}

SymbolTableEntry* Token::getSymTabEntry(void) const
{
  return m_symtabEntry;
}

void Token::setTokenCode(const TokenCode tc)
{
   m_tokenCode = tc;
}

void Token::setDataType(const DataType dt)
{
   m_dataType = dt;
}

void Token::setOpType(const OpType op)
{
  m_opType = op;
}

void Token::setSymTabEntry(SymbolTableEntry* entry)
{
  m_symtabEntry = entry;
}

std::string Token::opTypeToString(void)
{
  return opStrings[m_opType];
}


std::string Token::tokenCodeToString(void)
{
  return tokenCodeStrings[m_tokenCode];
}
