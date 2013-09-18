#include "symtab.h"

bool compareSTE(SymbolTableEntry* a,SymbolTableEntry* b) {
    return(a->lexeme < b->lexeme);
}

SymbolTable::SymbolTable(void)
{
}

SymbolTable::~SymbolTable(void)
{ 
  EntryList::iterator it = m_table.begin();
  for(; it != m_table.end(); ++it) {
    delete *it;
  }
}

SymbolTableEntry* SymbolTable::insert(const std::string lexeme)
{
  SymbolTableEntry* ste = new SymbolTableEntry();
  ste->lexeme = lexeme;
  m_table.push_back(ste);
  return ste;
}

SymbolTableEntry* SymbolTable::lookup(const std::string& lexeme)
{
  EntryList::iterator it = m_table.begin();
  for(;it != m_table.end(); ++it) {
    if((*it)->lexeme == lexeme)
      return *it;
  }
  return NULL;
}



int main() {
  SymbolTable* st = new SymbolTable();
  SymbolTable::print(st);
}
