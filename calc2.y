%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>
%}

%token NUMBER
%right '^'
%nonassoc UNARY_MINUS

%%

command : exp   {printf("%d\n",$1);}
        ;

exp     : exp '+' term  {$$ = $1 + $3;}
        | exp "-" term  {$$ = $1 - $3;}
        | term  {$$ = $1;}
        ;

term    : term '*' term2       {$$ = $1 * $3;}
        | term '/' term2       {if($3==0)yyerror("error");else{$$ = $1 / $3;}}
        | term '%' term2       {$$ = $1 % $3;}
        | term2        {$$ = $1;}
        ;

term2   : factor '^' term2      {$$=pow($1,$3);}
        | factor                {$$=$1;}
        ;

factor  : NUMBER        {$$ = $1;}
        | '-' factor %prec UNARY_MINUS {$$=-$2;}
        | '(' exp ')'   {$$ = $2;}
        ;

%%

main()
{ return yyparse();
}

int yylex(void)
{ int c;
  while((c = getchar()) == ' ')   ;      /* delete all spaces */
  if ( isdigit(c) ) {
    ungetc(c, stdin);                 /* put c back */
    scanf("%d",&yylval);
    return(NUMBER);
  }
  if ( c == '\n') return 0;
  return(c);
}

int yyerror(char * s)
{ fprintf(stderr,"%s\n",s);
  return 0;
}
