% end is a keyword
end = 3;

%%%%%%%%%%

% no func-call should be in LHS
a.b() = 3;

%%%%%%%%%%

% target can't be expression
a.b()();

%%%%%%%%%%

% target can't be expression
a.(b)();

%%%%%%%%%%

% tilde cannot be in RHS
[~];

%%%%%%%%%%

% line wrap must be escaped in this case
(a -
b)
