/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_MINIPASCAL_TAB_H_INCLUDED
# define YY_YY_MINIPASCAL_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    BEG = 258,
    PROG = 259,
    FUNC = 260,
    PROC = 261,
    INTEGER = 262,
    ID = 263,
    SEMICOLON = 264,
    PERIOD = 265,
    VAR = 266,
    COLON = 267,
    LP = 268,
    RP = 269,
    LS = 270,
    RS = 271,
    COMMA = 272,
    ARR = 273,
    OF = 274,
    IF = 275,
    THEN = 276,
    ELSE = 277,
    END = 278,
    ASSGN = 279,
    RETURN = 280,
    READ = 281,
    WRITELN = 282,
    ASSERT = 283,
    WHILE = 284,
    DO = 285,
    RELOP = 286,
    ADDOP = 287,
    OR = 288,
    MULOP = 289,
    NOT = 290,
    STRING_LITERAL = 291,
    SIZE = 292,
    DATATYPE = 293
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MINIPASCAL_TAB_H_INCLUDED  */
