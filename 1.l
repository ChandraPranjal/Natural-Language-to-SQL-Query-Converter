%{
    #include "y.tab.h"
    #include "var.h"
%}

%%
"Please " {return PL;}
"show all the databases" {return SD;}
"show all the tables" {return ST;}
"give me "  {return SEL;}
"all information "  {return ALL;}
"of "[a-zA-Z]+ {strcpy(tname,yytext);return FT;}
"create table "[a-zA-z]+" " {strcpy(tname,yytext);return CRT;}
"with columns "([a-zA-Z, ]+) {strcpy(tcols,yytext);return CTC;} 
"insert data in "[a-zA-Z]+" " {strcpy(tname,yytext);return IINT;}
"with values "([a-zA-Z0-9,'' ]+) {strcpy(tcols,yytext);return IV;}
"columns "([a-zA-Z]+",")*[a-zA-Z]+" "   {strcpy(tcols,yytext);return COLS;}
" where "([a-zA-Z0-9,'' ]+) {strcpy(conds,yytext);return WC;}
"." {return END;}
"the " {}
\n {return 0;}
%%

int yywrap()
{
    // printf("LKKLK");
    return 0;
}