
%{
#include <stdio.h>
#include <ctype.h>
%}


%union {int n;}
%type <n> exp term factor number digit

%%

command : exp                   {printf("%d\n",$1);}
        ;

exp     : exp '+' term  {$$ = $1 + $3;}
        | exp '-' term  {$$ = $1 - $3;}
        | term  	{$$ = $1;}
        ;

term    : term '*' factor       {$$ = $1 * $3;}
        | factor        	{$$ = $1;}
        ;

factor  : number        {$$ = $1;}
        | '(' exp ')'   {$$ = $2;}
        ;
 
number  : digit         {$$ = $1;}
        | number digit  {$$ = $1*10 + $2;}
        ;

digit   : '0'                            {$$ = 0;}
        | '1'                            {$$ = 1;}
        | '2'                            {$$ = 2;}
        | '3'                            {$$ = 3;}
        | '4'                            {$$ = 4;}
        | '5'                            {$$ = 5;}
        | '6'                            {$$ = 6;}
        | '7'                            {$$ = 7;}
        | '8'                            {$$ = 8;}
        | '9'                            {$$ = 9;}
        ;

%%

main(void){
	return yyparse();
}

int yylex(void){
	int c;
	while((c = getchar()) == ' ')   ; 
	if ( c == '\n') return 0;
	return(c);
}

int yyerror(char * s)
{ fprintf(stderr,"%s\n",s);
  return 0;
}
