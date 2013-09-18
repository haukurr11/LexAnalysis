#include "scanner.h"
#include "lex.yy.cc"

Scanner::Scanner(SymbolTable* symbols, std::istream& input, std::ostream& output)
{
}

Scanner::~Scanner()
{
}

void Scanner::setCurrentToken(TokenCode tc, DataType dt, OpType op)
{
}

void Scanner::setCurrentToken(TokenCode tc, DataType dt, const std::string& lexeme)
{
}

SymbolTable* Scanner::getSymbolTable(void)
{
}

Token* Scanner::nextToken(void)
{
}

int main() {

}
