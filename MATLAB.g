grammar MATLAB;

source: function_file | script_file;

script_file: statement* EOF;

function_file: function_block_rule* EOF;

statement
    : 'while' expr statement_end block 'end' statement_end # while_block
    | 'for' ident '=' expr statement_end block 'end' statement_end # for_block
    | if_block_rule # if_block
    | 'try' block 'catch' ident statement_end block 'end' statement_end # try_block
    | switch_block_rule # switch_block
    | parfor_block_rule # parfor_block
    | function_block_rule # function_block
    | 'return' statement_end # return_stmt
    | 'break' statement_end # break_stmt
    | 'continue' statement_end # continue_stmt
    | 'global' ident_list_c statement_end # global_stmt
    | expr statement_end # expr_stmt
    | lhs_expr '=' expr statement_end # assign_stmt
    | statement_end # empty_stmt
    ;

block: statement*;

if_block_rule
    : 'if' expr statement_end
        block
      ('elseif' expr statement_end
        block)*
      ('else' statement_end
        block)?
      'end' statement_end
    ;

switch_block_rule
    : 'switch' expr statement_end
        ('case' expr statement_end
          block)*
        ('otherwise' statement_end
          block)?
      'end' statement_end
    ;

parfor_block_rule
    : 'pafor' ident '=' expr ':' expr statement_end block 'end' statement_end
    | 'parfor' '(' ident '=' expr ':' expr ',' expr ')' statement_end block 'end' statement_end
    ;

function_block_rule
    : 'function' ident '=' ident '(' ident_list_c ')' statement_end argument_validentation? block 'end' statement_end
    | 'function' '[' ident_list_c ']' '=' ident '(' ident_list_c ')' statement_end argument_validentation? block 'end' statement_end
    | 'function' ident '(' ident_list_c ')' statement_end argument_validentation? block 'end' statement_end
    | 'function' ident '(' ident_list_c ')' statement_end
    ;

argument_validentation: 'arguments' (ident '(' index_list ')' '{' ident_list_c '}')* 'end' statement_end;

statement_end: ',' | ';' | nl;

lhs_expr
    : ident ('.' (ident | '(' ident ')'))*
    | lhs_expr '(' (index_val (',' index_val)*) ')'
    | lhs_expr '{' (index_val (',' index_val)*) '}'
    | '[' lhs_array_elem (',' lhs_array_elem)* ']'
    // note that an empty array is not supported by MATLAB
    ;

lhs_array_elem: lhs_expr | '~';

// See https://www.mathworks.com/help/matlab/matlab_prog/matlab-operators-and-special-characters.html#bvg3oy_-5
expr
    : expr bin_operator expr # bin_op
    | pre_unary_operator expr # pre_unary
    | expr post_unary_operator # post_unary
    | '@' (ident | superclass_method) # fn_reference
    | '?' ident # metaclass
    | '@' '(' ident_list_c ')' expr # lambda_
    | dots_or_call_rule # dots_or_call
    | '(' expr ')' # parens_expr
    | '{' expr_list_cs '}' # cell_array
    | '[' expr_list_cs (';' expr_list_cs)* ']' # array
    | int_rule # int_
    | float_rule # float_
    | string_rule # string
    ;

// It's not documented anywhere, but trial and error shows
// the target of a fn-call or array-index cannot be a general expression;
// It must be an ident or dotted ident.
// For example,
// `obj()()`, `(obj())()` are not valident, even if `obj()` is a fn
// Likewise, the left-hand sidente of a dot cannot be a general expression;
// it must be an ident, dotted ident, or fn.
// For example, 
// `(obj).field` is not valident.
// However, they do allow the special case of a fn,
// `obj().field` to work.

dots_or_call_rest
    : '.' ident dots_or_call_rest?
    | '.(' ident ')' dots_or_call_rest?
    | ('(' index_list ')' | '{' index_list '}') (('.' ident | '.(' ident ')') dots_or_call_rest?)?
    ;
dots_or_call_rule: (ident | superclass_method '(' expr_list_c ')') dots_or_call_rest?;

superclass_method: ident '@' ident;

expr_list_c: (expr (',' expr)*)?;

expr_list_cs: (expr (','? expr)*)?;

index_list: (index_val (',' index_val)*)?;

index_val: expr | ':' | 'end';

ident_list_c: (ident (',' ident)*)?;

// https://www.mathworks.com/help/matlab/matlab_prog/matlab-operators-and-special-characters.html#bvg3oy_-2
bin_operator
    : '+'
    | '-'
    | '*'
    | '/'
    | '\\'
    | '^'
    | '.*'
    | './'
    | '.\\'
    | '.^'
    | '=='
    | '~='
    | '<'
    | '<='
    | '>'
    | '>='
    | '&'
    | '|'
    | '&&'
    | '||'
    | ':'
    ;

pre_unary_operator
    : '-'
    | '~'
    ;

post_unary_operator
    : '\''
    | '.\''
    ;

int_rule: INT;
INT: [0-9]+;

float_rule: FLOAT;
FLOAT
    : [0-9]+ '.' [0-9]*
    | '.' [0-9]+
    ;

string_rule: STRING+;
STRING
    : '"' ~["]* '"'
    | '\'' ~[']* '\''
    ;

ident: IDENT;
IDENT: [a-zA-Z_] [a-zA-Z0-9_]*;
// This is a little more liberal than it should be, since ~ can only appear on the LHS

// TODO: preserve whitespace and comments
LINE_COMMENT: '%' ~[\n]* -> skip;
SHELL_COMMAND: '!' ~[\n]* [\r]? [\n] -> skip;
BLOCK_COMMENT: '%{' .*? '%}' -> skip;
WS: [ \t]+ -> skip;

LINE_CONTINUATION: '...' ~[\r\n]* [\r]? [\n] -> skip;
nl: NL+;
NL: [\r]? [\n];

// L_BRACKET: '[' -> pushMode(PAIRED_DELIM);
// R_BRACKET: ']' -> popMode;
// L_BRACE: '{' -> pushMode(PAIRED_DELIM);
// R_BRACE: '}' -> popMode;

// mode PAIRED_DELIM;
// LINE_CONTINUATION: '...' ~[\r\n]* [\r]? [\n] -> skip;
// NL: [\r]? [\n] -> skip;

// Grossness:
// Func-call vs array-indexing
// "Command forms" (not keywords)
// Quoting
// Function without return
// Arrays separated by comma-or-space and semi
// Do not require an end statement
