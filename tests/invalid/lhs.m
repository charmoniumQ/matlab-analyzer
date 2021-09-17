% no func-call should be in LHS
a.b() = x;

%%%%%%%%%%

% No function call in LHS
[a(), b, c] = x;

%%%%%%%%%%

% No expr in LHS
[a + b, c] = x;
