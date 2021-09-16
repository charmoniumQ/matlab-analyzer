function a = test_good()
end

%%%%%%%%%%

function [a] = test_good2()
end

%%%%%%%%%%

function test_good3()
end

%%%%%%%%%%

if blah, foo; end

%%%%%%%%%%

[~] = foo();

%%%%%%%%%%

[~, a] = foo();

%%%%%%%%%%

[a{1:}] = b(c{:});

%%%%%%%%%%

a(end, 3:, :4, :);

%%%%%%%%%%

a.b;

%%%%%%%%%%

a.(b);

%%%%%%%%%%

a.(b)();

%%%%%%%%%%

a.(b).(c);

%%%%%%%%%%

a.b();

%%%%%%%%%%

a().b;

%%%%%%%%%%

a().(b);

%%%%%%%%%%

a().b();

%%%%%%%%%%

a@b();

%%%%%%%%%%

-A';

%%%%%%%%%%

@(a, b) a + b;

%%%%%%%%%%

;;

%%%%%%%%%%

[a b, c; 1, 2 3;;]

%%%%%%%%%%

% `...` is line continuation character
a - ...
b;

%%%%%%%%%%

% No line-continuation needed in the case of arrays.
[
  a
]

%%%%%%%%%%

%{
this is a block comment
}
