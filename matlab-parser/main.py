import typer
import antlr4
# https://github.com/antlr/antlr4/blob/master/doc/python-target.md
from .gen.MATLABLexer import MATLABLexer
from .gen.MATLABParser import MATLABParser


app = typer.Typer()

escape_chars = {
    "\n": "\\n",
    "\r": "\\r",
    "\t": "\\t",
    "\v": "\\v",
    "\\": "\\\\",
    "<": "\\<",
    ">": "\\>",
}
def escape(string):
    for escape_char, escape_seq in escape_chars.items():
        string = string.replace(escape_char, escape_seq)
    return string


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
        print(type_, escape(token.text))
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
    tree = parser.source()
    import IPython; IPython.embed()


def main() -> None:
    app()
