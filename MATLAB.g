// nix-shell -p antlr4 -p jdk8 -p python39 -p python39Packages.virtualenv

grammar MATLAB;

source: script_file | function_file;

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

for_block: 'for' id '=' expr statement_end block 'end' statement_end;

if_block: 'if' expr statement_end block ('elseif' expr statement_end block)* ('else' statement_end block)? 'end' statement_end;

try_block: 'try' block 'catch' id statement_end block 'end' statement_end;

switch_block: 'switch' expr statement_end ('case' expr statement_end block)* ('otherwise' statement_end block)? 'end' statement_end;

parfor_block: 'pafor' id '=' expr ':' expr statement_end block 'end' statement_end;

parfor_parens_block: 'parfor' '(' id '=' expr ':' expr ',' expr ')' statement_end block 'end' statement_end;

function_block
    : 'function' id '=' id '(' id_list ')' statement_end argument_validation? block 'end' statement_end
    | 'function' '[' id_list ']' '=' id '(' id_list ')' statement_end argument_validation? block 'end' statement_end
    | 'function' id '(' id_list ')' statement_end argument_validation? block 'end' statement_end
    | 'function' id '(' id_list ')' statement_end
    ;

argument_validation: 'arguments' (id '(' index_list ')' '{' id_list '}')* 'end' statement_end;

return_stmt: 'return' statement_end;

break_stmt: 'break' statement_end;

continue_stmt: 'continue' statement_end;

global_stmt: 'global' id_list statement_end;

assign_stmt: lhs_expr '=' expr statement_end;
// This is a little more liberal than it should be.
// A proper subset of exprs are valid on the LHS.

expr_stmt: expr statement_end;

statement_end: ',' | ';' | nl;

lhs_expr
    : id ('.' (id | '(' id ')'))*
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
    | lambda
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
// It must be an id or dotted id.
// For example,
// `obj()()`, `(obj())()` are not valid, even if `obj()` is a function
// Likewise, the left-hand side of a dot cannot be a general expression;
// it must be an id, dotted id, or function.
// For example, 
// `(obj).field` is not valid.
// However, they do allow the special case of a function,
// `obj().field` to work.

rest
    : '.' id rest?
    | '.(' id ')' rest?
    | ('(' index_list ')' | '{' index_list '}') (('.' id | '.(' id ')') rest?)?
    ;
dotted_or_array_index_or_fn_call: (id | superclass_method '(' expr_list ')') rest?;

superclass_method: id '@' id;

function_reference: '@' (id | superclass_method);

metaclass: '?' id;

lambda: '@' '(' id_list ')' expr;

expr_list: (expr (',' expr)*)?;

paren_expr: '(' expr ')';

cell_array: '{' expr_list_cs '}';

array: '[' expr_list_cs (';' expr_list_cs)* ']';

expr_list_cs: (expr (','? expr)*)?;

index_list: (index_val (',' index_val)*)?;

index_val: expr | ':' | 'end';

id_list: (id (',' id)*)?;

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

id: ID;
ID: [a-zA-Z_] [a-zA-Z0-9_]*;
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
