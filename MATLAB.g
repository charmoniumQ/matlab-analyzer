grammar MATLAB;

source: function_file | script_file;

script_file: statement* EOF;

function_file: function_block* EOF;

statement
    : while_block
    | for_block
    | if_block
    | try_block
    | switch_block
    | parfor_block
    | parfor_parens_block
    | function_block
    | return_stmt
    | break_stmt
    | continue_stmt
    | global_stmt
    | expr_stmt
    | assign_stmt
    | statement_end
    ;

block: statement*;

while_block: 'while' expr statement_end block 'end' statement_end;

for_block: 'for' ident '=' expr statement_end block 'end' statement_end;

if_block: 'if' expr statement_end block ('elseif' expr statement_end block)* ('else' statement_end block)? 'end' statement_end;

try_block: 'try' block 'catch' ident statement_end block 'end' statement_end;

switch_block: 'switch' expr statement_end ('case' expr statement_end block)* ('otherwise' statement_end block)? 'end' statement_end;

parfor_block: 'pafor' ident '=' expr ':' expr statement_end block 'end' statement_end;

parfor_parens_block: 'parfor' '(' ident '=' expr ':' expr ',' expr ')' statement_end block 'end' statement_end;

function_block
    : 'function' ident '=' ident '(' ident_list ')' statement_end argument_validentation? block 'end' statement_end
    | 'function' '[' ident_list ']' '=' ident '(' ident_list ')' statement_end argument_validentation? block 'end' statement_end
    | 'function' ident '(' ident_list ')' statement_end argument_validentation? block 'end' statement_end
    | 'function' ident '(' ident_list ')' statement_end
    ;

argument_validentation: 'arguments' (ident '(' index_list ')' '{' ident_list '}')* 'end' statement_end;

return_stmt: 'return' statement_end;

break_stmt: 'break' statement_end;

continue_stmt: 'continue' statement_end;

global_stmt: 'global' ident_list statement_end;

assign_stmt: lhs_expr '=' expr statement_end;
// This is a little more liberal than it should be.
// A proper subset of exprs are valident on the LHS.

expr_stmt: expr statement_end;

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
    : expr bin_op expr
    | pre_unary expr
    | expr post_unary
    | function_reference
    | metaclass
    | lambda_
    | dotted_or_array_index_or_fn_call
    | paren_expr
    | cell_array
    | array
    | int_
    | float_
    | string
    ;

// It's not documented anywhere, but trial and error shows
// the target of a function-call or array-index cannot be a general expression;
// It must be an ident or dotted ident.
// For example,
// `obj()()`, `(obj())()` are not valident, even if `obj()` is a function
// Likewise, the left-hand sidente of a dot cannot be a general expression;
// it must be an ident, dotted ident, or function.
// For example, 
// `(obj).field` is not valident.
// However, they do allow the special case of a function,
// `obj().field` to work.

rest
    : '.' ident rest?
    | '.(' ident ')' rest?
    | ('(' index_list ')' | '{' index_list '}') (('.' ident | '.(' ident ')') rest?)?
    ;
dotted_or_array_index_or_fn_call: (ident | superclass_method '(' expr_list ')') rest?;

superclass_method: ident '@' ident;

function_reference: '@' (ident | superclass_method);

metaclass: '?' ident;

lambda_: '@' '(' ident_list ')' expr;

expr_list: (expr (',' expr)*)?;

paren_expr: '(' expr ')';

cell_array: '{' expr_list_cs '}';

array: '[' expr_list_cs (';' expr_list_cs)* ']';

expr_list_cs: (expr (','? expr)*)?;

index_list: (index_val (',' index_val)*)?;

index_val: expr | ':' | 'end';

ident_list: (ident (',' ident)*)?;

// https://www.mathworks.com/help/matlab/matlab_prog/matlab-operators-and-special-characters.html#bvg3oy_-2
bin_op
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

pre_unary
    : '-'
    | '~'
    ;

post_unary
    : '\''
    | '.\''
    ;

int_: INT;
INT: [0-9]+;

float_: FLOAT;
FLOAT
    : [0-9]+ '.' [0-9]*
    | '.' [0-9]+
    ;

string: STRING+;
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
