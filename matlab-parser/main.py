import json
import typer
import antlr4
# https://github.com/antlr/antlr4/blob/master/doc/python-target.md
from .gen.MATLABLexer import MATLABLexer
from .gen.MATLABParser import MATLABParser
from . import util


app = typer.Typer()

@app.command()
def tokenize(
        filepath: str = typer.Argument(
            "/dev/stdin",
            exists=True,
            file_okay=True,
            readable=True,
        )
) -> None:
    input_stream = antlr4.FileStream(filepath)
    lexer = MATLABLexer(input_stream)
    token_type_map = {
        symbolic_id + len(lexer.literalNames) - 1: symbolic_name
        for symbolic_id, symbolic_name in enumerate(lexer.symbolicNames)
    }
    while True:
        token = lexer.nextToken()
        type_ = token_type_map.get(token.type, "literal")
        print(f"{type_} {json.dumps(token.text)}")
        if token.type == token.EOF:
            break


@app.command()
def parse(
        filepath: str = typer.Argument(
            ...,
            exists=True,
            file_okay=True,
            readable=True,
        )
) -> None:
    input_stream = antlr4.FileStream(filepath)
    lexer = MATLABLexer(input_stream)
    stream = antlr4.CommonTokenStream(lexer)
    parser = MATLABParser(stream)

    stack = [parser.source()]
    depth = 0
    while stack:
        node = stack.pop()
        if isinstance(node, antlr4.tree.Tree.TerminalNodeImpl):
            print(f"{depth * ' '}{json.dumps(node.getText())}")
        elif isinstance(node, str):
            depth -= 1
            print(f"{depth * ' '})")
        else:
            rule_name = MATLABParser.ruleNames[node.getRuleIndex()]
            if node.children:
                print(f"{depth * ' '}({rule_name}")
                stack.append("end")
                stack.extend(node.children[::-1])
                depth += 1
            else:
                print(f"{depth * ' '}({rule_name})")


def main() -> None:
    app()
