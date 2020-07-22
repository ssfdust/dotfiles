function commits#list_commits()
    let git = 'git'
    let commits = systemlist(git .' log --oneline | head -n10')
    if (len(commits) > 0 && match(commits[0], 'fatal: not a git repository') > -1)
        return []
    endif
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction
