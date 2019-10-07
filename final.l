%{
    int yywrap();
    #define YYSTYPE double
    void yyerror(char*);
    #include "final.tab.h"
	#include <math.h>
%}
 
%%
 
     /* a-z為變量 */   
[a-z]   {
            yylval = *yytext - 'a';
            return VARIABLE;
        }
		
	/*2進制數*/
\.?[01]+B|[01]+\.[01]*B {
            yytext = strtok(yytext, "B");
			float tmp=0;
			int i;
			char *buffF;
			char *buffB;
			buffF = strtok(yytext, ".");
			/*char* buffF,buffB, tmpS;
			tmpS = strtok(yytext, ".");
			for(i = strlen(*tmpS);i>0;i--){
				tmp += (tmpS[strlen(*tmpS)-i]-'0')*pow(2,i-1);
			}
			yylval = tmpS;
			while(tmpS!=NULL){
				tmpS = strtok(NULL, ".");
				buffB = tmpS;
			}*/
			for(i = strlen(buffF);i>0;i--){
				tmp += (buffF[strlen(buffF)-i]-'0')*pow(2.0,i-1);
			}
			buffB = strtok(NULL, ".");
			if(buffB){
				for(i = strlen(buffB);i>0;i--)
					tmp += (buffB[strlen(buffB)-i]-'0')*pow(0.5,i);
				}
			}
			/*for(i = strlen(yytext);i>0;i--){
				tmp += (yytext[strlen(yytext)-i]-'0')*pow(2,i-1);
			}*/
			yylval = tmp;
            return BINARY;
        }
		
    /*16進制數*/
0x\.?[a-f0-9]+|0x[a-f0-9]+\.[a-f0-9]* {
            yylval=strtol(yytext, NULL, 16);
            return HEXADECIMAL;
        }
 
    /* 整數或小數 */
\.?[0-9]+|[0-9]+\.[0-9]*    {
            yylval = atof(yytext);
            return INTEGER;
        }
 
    /* 運算符 */
[-+()=/*&|~!^@\n]  {return *yytext;}
    /* 三角函數 */
sin {
    return SIN;
    }
 
cos {
    return COS;
    }
tan {
    return TAN;
    }
    /* 空白被忽略 */
[ \t]    ;
 
    /* 其他字符都是非法的 */
.    yyerror("wrong\n");
 
%%
int yywrap()
{return 1;}