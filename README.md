# matlab-grammar

This is an [ANTLR4] specification of MATLAB. This specification is, by
necessity, more concise, complete, and precise than everything else I have
found.

[ANTLR4]: https://antlr.org

| Grammar                                                     | accept lambda (@) expressions | accept tilde (~) on LHS | reject expr on LHS | accept array on LHS | accept `...` |
|-------------------------------------------------------------|-------------------------------|-------------------------|--------------------|---------------------|--------------|
| https://github.com/charmoniumQ/matlab-parser (this project) | Y                             | Y                       | Y                  | Y                   | Y            |
| https://github.com/mattmcd/ParseMATLAB                      | N                             | N                       | Y                  | N                   | N            |
| https://github.com/vinodkhare/antlr-matlab-grammar/         | Y                             | Y                       | Y                  | Y                   | Y            |
| https://github.com/Octane-Labs/matlab-parser/               | N                             | N                       | Y                  | N                   | Y            |
| https://github.com/jol-jol/pymatlabparser                   | Y                             | N                       | N                  | Y                   | N            |


Note that I don't currently care about precedence in binary operations, so I don't attempt to read that correctly.

## Developing

To test, install [nix] run

[nix]: https://nixos.org

```
nix develop
./test_all.sh
./test_one.sh <FILE TO TEST>
```
