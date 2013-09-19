#include "scanner.h"
#include <iostream>

int main() {
  SymbolTable* st = new SymbolTable();
  Scanner* sc = new Scanner(st,std::cin,std::cout);
  Token* t;
  do {
    t = sc->nextToken();
    std::cout << t->tokenCodeToString() << " ";
  }while(t->getTokenCode() != tc_EOF );
  std::cout << "\n\n";
  st->print(st);
  return 0;
}
