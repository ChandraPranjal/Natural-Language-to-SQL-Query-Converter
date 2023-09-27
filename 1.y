%{
    #include<stdio.h> 
    #include<string.h>
    #include "var.h"
    int sd,st,ssfT,scfT,ssfTw,scfTw,crT,iinT = 0,e=0, valid=1 ;
%}

%union{char *strval;}
%token <strval> PL SD ST SEL ALL FT CRT CTC IINT IV COLS WC END
%%
start : PL s END
        | s END

s : SD  {sd = 1;}
  | ST {st = 1;}
  | CRT CTC {crT=1;}
  | IINT IV {iinT=1;}
  | SEL x
  ;

x : ALL FT {ssfT=1;}
  | COLS FT {scfT=1;}
  | ALL FT WC {ssfTw=1;}
  | COLS FT WC {scfTw=1;}
  ;
%%

int yyerror()
{
    printf("INCORRECT");
    valid=0;
    return 0;
}

int main(void)
{
    yyparse();
    char *query;
    if(valid == 0)
        return 0;
    else{
    if(sd == 1)
    {
        char q[] = "SHOW DATABASES\0";
        query = q;
    }
    else if(st == 1)
    {
        char q[] = "SHOW TABLES\0";
        query = q;
    }
    else if(ssfT==1)
    {
        char q[64] = "SELECT * FROM ";
        strcat(q,&tname[3]);
        query=q;
    }
    else if(crT==1)
    {
        char q[128] = "CREATE TABLE ";
        strcat(q,&tname[13]);
        strcat(q,"(");
        strcat(q,&tcols[13]);
        strcat(q,")");
        query=q;
    }
    else if(iinT==1)
    {
        char q[128] = "INSERT INTO ";
        strcat(q,&tname[15]);
        strcat(q,"VALUES(");
        strcat(q,&tcols[12]);
        strcat(q,")");
        query=q;
    }
    else if(scfT==1)
    {
    char q[128] = "SELECT ";
    strcat(q,&tcols[8]);
    strcat(q,"FROM ");
    strcat(q,&tname[3]);
    query=q;
    }
    else if(ssfTw==1)
    {
        char q[128] = "SELECT * FROM ";
        strcat(q,&tname[3]);
        strcat(q," WHERE ");
        strcat(q,&conds[7]);
        query=q;
    }
    else if(scfTw==1)
    {
        char q[128] = "SELECT ";
        strcat(q,&tcols[8]);
        strcat(q,"FROM ");
        strcat(q,&tname[3]);
        strcat(q," WHERE ");
        strcat(q,&conds[7]);
        query=q;
    }
    fprintf(stdout, "%s;",query);
    }
    return 0;
}