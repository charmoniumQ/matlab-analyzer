from pathlib import Path
import os
from typing import Tuple, Callable
import antlr4  # type: ignore
import antlr4_grun.main as antlr4_grun_main  # type: ignore
import pytest  # type: ignore

# run with pytest

separator = "%%%%%%%%%%"
project_dir = Path(__file__).parent.relative_to(os.getcwd())


@pytest.fixture(scope="session")
def built_grammar() -> Tuple[antlr4.Lexer, antlr4.Parser]:
    tmp_dir = project_dir / "build"
    grammar_path = project_dir / "MATLAB.g"
    antlr4_grun_main.compile(grammar_path, tmp_dir, antlr_jar_path=None)
    return antlr4_grun_main.get_lexer_parser(tmp_dir, "MATLAB")


def lex_and_parse(
    built_grammar: Tuple[antlr4.Lexer, antlr4.Parser],
    source: str,
    rule: str,
) -> bool:
    Lexer, Parser = built_grammar
    input_stream = antlr4.InputStream(source)
    lexer = Lexer(input_stream)
    stream = antlr4.CommonTokenStream(lexer)
    parser = Parser(stream)
    stack = [getattr(parser, rule)()]
    while stack:
        node = stack.pop()
        if isinstance(node, antlr4.tree.Tree.TerminalNodeImpl):
            pass
        else:
            if node.exception is not None:
                break
            children = [] if node.children is None else node.children
            stack.extend(children[::-1])
    else:
        return True
    return False


valid_matlab_files = [
    str(file)
    for file in (project_dir / "tests" / "valid").iterdir()
]

@pytest.mark.parametrize("file", valid_matlab_files)
def test_accept_valid_matlab(
    file: Path,
    built_grammar: Tuple[antlr4.Lexer, antlr4.Parser],
) -> None:
    for example in Path(file).read_text().split(separator):
        assert lex_and_parse(built_grammar, example, "source")


invalid_matlab_files = [
    str(file)
    for file in (project_dir / "tests" / "invalid").iterdir()
]

@pytest.mark.parametrize("file", invalid_matlab_files)
def test_reject_invalid_matlab(
    file: Path,
    built_grammar: Tuple[antlr4.Lexer, antlr4.Parser],
) -> None:
    for example in Path(file).read_text().split(separator):
        assert not lex_and_parse(built_grammar, example, "source")
