from pathlib import Path
import os
from typing import Tuple, Callable, Any
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


class BailErrorStrategy:
    def syntaxError(self, *args: Any) -> None:
        raise SyntaxError()

    def reportContextSensitivity(self, *args) -> None:
        pass

    def reportAmbiguity(self, *args) -> None:
        pass

    def reportAttemptingFullContext(self, *args) -> None:
        pass


def lex_and_parse(
    built_grammar: Tuple[antlr4.Lexer, antlr4.Parser],
    source: str,
    rule: str,
) -> bool:
    Lexer, Parser = built_grammar
    lexer = Lexer(antlr4.InputStream(source))
    parser = Parser(antlr4.CommonTokenStream(lexer))
    parser.removeErrorListeners()
    parser.addErrorListener(BailErrorStrategy())
    try:
        tree = getattr(parser, rule)()
    except SyntaxError:
        return False
    else:
        return True


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
