#include "scanner.h"
#include <iostream>

int main() {
  SymbolTable* st = new SymbolTable();
  Scanner* sc = new Scanner(st,std::cin,std::cout);
  Token* t;
  do {
    t = sc->nextToken();
  }while(t->getTokenCode() != tc_EOF );
  st->print(st);
  return 0;
}
