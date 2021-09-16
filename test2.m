% Bad

end = 3; % end is a keyword

a.b() = 3; % no func-call should be in LHS

a.b()(); % target can't be expression

a.(b)(); % target can't be expression

[~]; % tilde cannot be in RHS

(a -
b) % line wrap must be escaped in this case

% Good

function a = foo()
end

function [a] = foo()
end

function foo()
end

if blah, foo; end

[~] = foo();

[~, a] = foo();

[a{1:}] = b(c{:});

a(end, 3:, :4, :);

a.b;

a.(b);

a.(b)();

a.(b).(c);

a.b();

a().b;

a().(b);

a().b();

a@b();

-A';

@(a, b) a + b;

;;

[a b, c; 1, 2 3;;]

a - ...
b;

% Note, that no line-continuation needed in the case of arrays.
[
  a
]
