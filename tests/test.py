from pathlib import Path
from .gen.MATLABLexer import MATLABLexer
from .gen.MATLABParser import MATLABParser

delim = "%%%%%%%%%%"

def lex_and_parse():
    # TODO

def test_good() -> None:
    for example in Path("test_good.m").read_text().split():
        example = example.strip() + "\n"
        lex_and_parse(good)

def test_bad() -> None:
    for example in Path("test_good.m").read_text().split():
        example = example.strip() + "\n"
        with pytest.raises(TODO):
            lex_and_parse(good)
