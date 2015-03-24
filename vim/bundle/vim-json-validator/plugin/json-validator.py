#! /usr/bin/python3

try:
    import vim
    import sys
    import simplejson
except Exception as e:
    exit()


def markErrors(e, offset):
    """@todo: Docstring for function.

    :e: SimpleJson exception
    :offset: line offset within the file.
    :returns: @todo

    """
    coords = {
        "sline": e.lineno,
        "eline": e.endlineno,
        "scol": e.colno,
        "ecol": e.endcolno,
        "pos":  e.pos,
        "msg": e.msg,
    }

    # adjust for position in the buffer.
    if coords['sline']:
        coords['sline'] += offset
    else:
        coords['sline'] = 0

    if coords['eline']:
        coords['eline'] += offset
    else:
        coords['eline'] = 0

    print("JSON Error: line {sline} col {scol} ({pos}): {msg}".format(**coords))

    print(repr(coords))

    format_str = '''call matchadd('JSONValidateError','''

    if not coords['eline'] or coords['sline'] == coords['eline']:
        format_str += '''"\%{sline}l\%>{scol}c\%<{ecol}c"'''
    else:
        format_str += '''"\>%{sline}l\%<{eline}l"'''

    format_str += ', 100)'

    id = vim.command(format_str.format(**coords))

json = ''

if len(sys.argv) > 1:
    mark = '<>'
else:
    mark = '[]'

(sline, scol) = vim.current.buffer.mark(mark[0])
(eline, ecol) = vim.current.buffer.mark(mark[1])

# sort out diffent indexing.
# pythons vim module uses 0 indexed but vimL does not.
sline -= 1
eline -= 1
scol -= 1
ecol -= 1

buff_cur = vim.current.buffer

if sline < eline:
    json = buff_cur[sline:eline + 1]
    json[0] = json[0][scol:]
    json[-1] = json[-1][:ecol + 1]
elif sline == eline:
    json = buff_cur[sline][scol:ecol + 1]

json = [s.strip() for s in json]

# clear out matches from previous runs
for id in [m['id'] for m in vim.eval('getmatches()')
           if m['group'] == 'JSONValidateError']:
    vim.command('call matchdelete({})'.format(id))

try:
    simplejson.loads('\n'.join(json), strict=False)
except simplejson.JSONDecodeError as e:
    markErrors(e, sline)
except:
    print("Unknown error")
else:
    print("JSON OK")
