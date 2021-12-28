import sys
try:
    from ptpython.repl import embed
except ImportError:
    # print("ptpython is not available: falling back to standard prompt")
    pass
else:
    sys.exit(embed(globals(), locals()))
