import collections
from typing import TypeVar

Value = TypeVar("Value")


class DotDict(collections.UserDict[str, Value]):
    """Dict that is accessible through dot-notation (like JavaScript)."""
    data = {}
    def __getattr__(self, attr: str) -> Value:
        return self.data[attr]
    def __setattr__(self, attr: str, value: Value) -> None:
        self.data[attr] = value
    def __delattr__(self, attr: str) -> None:
        del self.data[attr]
