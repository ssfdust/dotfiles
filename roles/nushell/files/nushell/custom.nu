# Show system process information
export def ps [
    --bytes (-b) # Show memory size in bytes
] {
    let ps_out = (^ps -ewwo pid,ppid,%cpu,user,label,rss=mem,vsz,etimes,command | lines | parse -r '(?P<pid>\d+)\s+(?P<ppid>\d+)\s+(?P<cpu>[0-9.%]+)\s+(?P<user>\w+)\s+(?P<selinux>[^\s]+)\s+(?P<memory>\d+)\s+(?P<virtual>\d+)\s+(?P<created>[^\s]+)\s+(?P<command>.*)' | into decimal pid created memory virtual | update memory { |r| $r.memory * 1024 } | update virtual { |r| $r.virtual * 1024 } | update created {|r| ((date now | date format "%s" | into decimal) - $r.created) | into string | into datetime -z l })
    let se_out = ($ps_out | get selinux | where $it != '-' | parse '{se_user}:{se_role}:{se_type}:{se_range}')
    let ps_out = ($ps_out | reject selinux)
    let ps_out = ($ps_out | select pid ppid cpu user | merge $se_out  | merge ($ps_out | reject pid ppid cpu user))

    if $bytes {
        echo $ps_out 
    } else {
        echo $ps_out | into filesize memory virtual
    }
}

# Show system process order by memory
export def ps_sort_mem [
    --bytes (-b) # Show memory size in bytes
] {
    let sort_data = (ps -b | group-by command | agg [ (col pid | max ) (col memory | sum ) (col virtual | sum) ] | sort-by memory)
    if $bytes {
        echo $sort_data
    } else {
        echo $sort_data | into filesize memory virtual | into int pid | select pid command virtual memory
    }
}

# Show file security context
export def lsz [
    --bytes (-b) # Show filesize in bytes
    ...name
] {
    let ls_out = (/usr/bin/ls -lZ --color --full-time $name | lines | parse -r '[\w-](?P<mode>[^\s]+)\s+(?P<link_nums>\d+)\s+(?P<user>[^\s]+)\s+(?P<group>[^\s]+)\s+(?P<selinux>[^\s]+)\s+(?P<size>\d+)\s+(?P<modified>\d+-\d+-\d+\s\d+:\d+:\d+\.\d+\s\+\d+)\s+(?P<name>.*)')
    let ls_out = ($ls_out | get name | ansi strip | path type | wrap type | merge $ls_out)
    let se_out = ($ls_out | get selinux | where $it != '-' | parse '{se_user}:{se_role}:{se_type}:{se_range}')
    let ls_out = ($ls_out | reject selinux)
    let ls_out = ($ls_out | select mode link_nums user group | merge $se_out |  merge ($ls_out | reject mode link_nums user group))
    if $bytes {
        echo $ls_out
    } else {
        echo $ls_out | into filesize size | into datetime modified
    }
}

# List uninstalled packages from package file
export def list_uninst_from [path: string] {
    let packages = (open -r ($path | path expand) | lines | str replace 'AUR/' "")
    let installed_packages = (pacman -Q | lines | parse "{pkg} {ver}" | get pkg)
    $packages | filter {|x| $x not-in $installed_packages}
}

# wrapped lf command
export def-env lf [...args] {
    let tmp = (mktemp)
    let fid = (mktemp)

    ^lf -command $"$printf $id > "($fid)"" $"-last-dir-path=($tmp)" $args
    let id = (open -r $fid)
    let archivemount_dir = $"/tmp/__lf_archivemount_($id)"

    if ($archivemount_dir | path exists) {
        open -r $archivemount_dir | lines | each {|x| sudo umount $x; rmdir $x }
        rm -f $archivemount_dir
    }

    if ($tmp | path exists) {
        let dir = (open -r $tmp)
        if (($dir | path type) == "dir" and (pwd) != $dir) {
            cd $dir
        }
        rm -f $tmp
    }
}

# create zellij session named `x`
export def zellijx [] {
    let x_num = (do -s { zellij list-sessions } | complete | get stdout | lines | find --regex '^x$' | length)
    if ($x_num == 1) {
        zellij attach x
    } else {
        zellij -s x
    }
}
