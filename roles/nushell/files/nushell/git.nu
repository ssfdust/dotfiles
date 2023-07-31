export def __git_prompt_git [...rest] {
    with-env [GIT_OPTIONAL_LOCKS 0] {
        ^git $rest
    }
}

# get the main branch of the git repo
export def git_main_branch [] {
    let found = false;
    if (is_git_available) {
        let main_branch = (
            for branch in ["main" "trunk"] {
                let git_ref = (do -i {git show-ref --verify $"refs/heads/($branch)"})
                if ($git_ref != "") {
                    return $branch
                }
            }
        )
        if ($main_branch | is-empty) {echo master} else {echo $main_branch}
    }
}

# check whether we are in a git repo
export def is_git_available [] {
    let path_array = (pwd | path split)
    let path_array_len = (echo $path_array | length)
    let test_git_array = []
    if ($path_array_len > 1) {
        let test_git_array = (0..$path_array_len | each { |x| $path_array | range 0..$x | append .git | str trim | path join })
        let found_array_len = (echo $test_git_array | uniq | skip until {|it| echo $it | path exists} | length)
        echo ($found_array_len > 0)
    } else {
        echo .git | path exists
    }
}

# get current git branch
export def git_current_branch [] {
    if (is_git_available) {
        let git_ref = (^git symbolic-ref "--quiet" HEAD)
        if ($git_ref != "") {
            echo $git_ref | str replace "refs/" "" | str replace "heads/" "" | str trim
        } else {
            __git_prompt_git rev-parse "--short" HEAD
        }
    } else {}
}

export def _git_log_prettily [arg] {
    if ($arg != "") {
        git log $"--pretty=($arg)"
    } else {}
}
export alias g = git

export alias ga = git add
export alias gaa = git add --all
export alias gapa = git add --patch
export alias gau = git add --update
export alias gav = git add --verbose
export alias gap = git apply
export alias gapt = git apply --3way

export alias gb = git branch
export alias gba = git branch -a
export alias gbd = git branch -d

export alias gbD = git branch -D
export alias gbl = git blame -b -w
export alias gbnm = git branch --no-merged
export alias gbr = git branch --remote
export alias gbs = git bisect
export alias gbsb = git bisect bad
export alias gbsg = git bisect good
export alias gbsr = git bisect reset
export alias gbss = git bisect start

export alias gc = git commit -v
export alias gc! = git commit -v --amend
export alias gcn! = git commit -v --no-edit --amend
export alias gca = git commit -v -a
export alias gca! = git commit -v -a --amend
export alias gcan! = git commit -v -a --no-edit --amend
export alias gcans! = git commit -v -a -s --no-edit --amend
export alias gcam = git commit -a -m
export alias gcsm = git commit -s -m
export alias gcas = git commit -a -s
export alias gcasm = git commit -a -s -m
export alias gcb = git checkout -b
export alias gcf = git config --list
export alias gcl = git clone --recurse-submodules
export alias gclean = git clean -id
export alias gcm = git checkout (git_main_branch)
export alias gcd = git checkout develop
export alias gcmsg = git commit -m
export alias gco = git checkout
export alias gcor = git checkout --recurse-submodules
export alias gcount = git shortlog -sn
export alias gcp = git cherry-pick
export alias gcpa = git cherry-pick --abort
export alias gcpc = git cherry-pick --continue
export alias gcs = git commit -S
export alias gcss = git commit -S -s
export alias gcssm = git commit -S -s -m

export alias gd = git diff
export alias gdca = git diff --cached
export alias gdcw = git diff --cached --word-diff
export alias gdct = git describe --tags (git rev-list --tags --max-count=1)
export alias gds = git diff --staged
export alias gdt = git diff-tree --no-commit-id --name-only -r
export alias gdw = git diff --word-diff

export alias gfo = git fetch origin

# delete branchs which are not main or development related
export def gbda [] { 
    git branch --no-color --merged | grep -vE $"^(char left_paren)\\+|\\*|\\s*(char left_paren)(git_main_branch)|development|develop|devel|dev(char right_paren)\\s*$(char right_paren)" | xargs -n 1 git branch -d
}

# find a file in current git directory
export def gfg [filename] {git ls-files | lines | where $it =~ $filename}

export alias gg = git gui citool
export alias gga = git gui citool --amend

# push some branch to origin forcely (default: current branch)
export def ggf [...rest] {
    let branch = (if ((echo $rest | length) != 1) { git_current_branch } else { echo $rest })
    git push --force origin $"($branch)"
}

# push some branch to origin forcely with lease (default: current branch)
export def ggfl [...rest] {
    let branch = (if ((echo $rest | length) != 1) { git_current_branch } else { echo $rest })
    git push --force-with-lease origin $"($branch)"
}

# pull some branch from origin (default: current branch)
export def ggl [...rest] {
    if ((echo $rest | length) in [0 1]) {
        let branch = (if ((echo $rest | length) != 1) { git_current_branch } else { echo $rest })
        git pull origin $"($branch)"
    } else {
        git pull origin $rest
    }
}

# push some branch to origin (default: current branch)
export def ggp [...rest] {
    if ((echo $rest | length) in [0 1]) {
        let branch = (if ((echo $rest | length) != 1) { git_current_branch } else { echo $rest })
        git push origin $"($branch)"
    } else {
        git push origin $rest
    }
}

# sync some branch with origin (default: current branch)
export def ggpnp [...rest] {
    if ((echo $rest | length) == 0) {
        ggl;ggp
    } else {
        ggl $rest;ggp $rest
    }
}

# pull some branch from origin and then rebase (default: current branch)
export def ggu [...rest] {
    let branch = (if ((echo $rest | length) != 1) { git_current_branch } else { echo $rest })
    git pull --rebase origin $"($branch)"
}

export alias ggpur = ggu
export alias ggpull = git pull origin $"(git_current_branch)"
export alias ggpush = git push origin $"(git_current_branch)"

export alias ggsup = git branch $"--set-upstream-to=origin/(git_current_branch)"
export alias gpsup = git push --set-upstream origin (git_current_branch)

export alias ghh = git help

export alias gignore = git update-index --assume-unchanged

export alias gk = ^gitk --all --branches
export alias gke = ^gitk --all (git log -g --pretty=%h | lines)

export alias gl = git pull
export alias glg = git log --stat
export alias glgp = git log --stat -p
export alias glgg = git log --graph
export alias glgga = git log --graph --decorate --all
export alias glgm = git log --graph --max-count=10
export alias glo = git log --oneline --decorate
export alias glol = git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
export alias glols = git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat
export alias glod = git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'
export alias glods = git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short
export alias glola = git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all
export alias glog = git log --oneline --decorate --graph
export alias gloga = git log --oneline --decorate --graph --all
export alias glp = _git_log_prettily

export alias gm = git merge
export alias gmom = git merge $"origin/(git_main_branch)"
export alias gmt = git mergetool --no-prompt
export alias gmtvim = git mergetool --no-prompt --tool=vimdiff
export alias gmum = git merge $"upstream/(git_main_branch)"
export alias gma = git merge --abort

export alias gp = git push
export alias gpd = git push --dry-run
export alias gpf = git push --force-with-lease
export alias gpf! = git push --force
export alias gpr = git pull --rebase
export alias gpu = git push upstream
export alias gpv = git push -v

export alias gr = git remote
export alias gra = git remote add
export alias grb = git rebase
export alias grba = git rebase --abort
export alias grbc = git rebase --continue
export alias grbd = git rebase develop
export alias grbi = git rebase -i
export alias grbm = git rebase (git_main_branch)
export alias grbo = git rebase --onto
export alias grbs = git rebase --skip
export alias grev = git revert
export alias grh = git reset
export alias grhh = git reset --hard
export alias groh = git reset $"origin/(git_current_branch)" --hard
export alias grm = git rm
export alias grmc = git rm --cached
export alias grmv = git remote rename
export alias grrm = git remote remove
export alias grs = git restore
export alias grset = git remote set-url
export alias grss = git restore --source
export alias grst = git restore --staged
export alias grt = cd $"(git rev-parse --show-toplevel | lines)"
export alias gru = git reset --
export alias grup = git remote update
export alias grv = git remote -v

export alias gsb = git status -sb
export alias gsd = git svn dcommit
export alias gsh = git show
export alias gsi = git submodule init
export alias gsps = git show --pretty=short --show-signature
export alias gsr = git svn rebase
export alias gss = git status -s
export alias gst = git status

export alias gsta = git stash push

export alias gstaa = git stash apply
export alias gstc = git stash clear
export alias gstd = git stash drop
export alias gstl = git stash list
export alias gstp = git stash pop
export alias gsts = git stash show --text
export alias gstu = gsta --include-untracked
export alias gstall = git stash --all
export alias gsu = git submodule update
export alias gsw = git switch
export alias gswc = git switch -c

export alias gts = git tag -s
# alias gtl = gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl

export alias gunignore = git update-index --no-assume-unchanged
# revert WIP
export def gunwip [] {
    let wip_msg = (git log -n 1 | where $it =~ --wip--)
    if ($wip_msg != "") {git reset HEAD~1} else { }
}
export alias gup = git pull --rebase
export alias gupv = git pull --rebase -v
export alias gupa = git pull --rebase --autostash
export alias gupav = git pull --rebase --autostash -v
export alias glum = git pull upstream (git_main_branch)

export alias gwch = git whatchanged -p --abbrev-commit --pretty=medium

# commit work in progress
export def gwip [] {
    git add -A
    do -i {git rm (git ls-files --deleted)}
    git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"
}
export def gpoat [] { git push origin --all;git push origin --tags }

export alias gam = git am
export alias gamc = git am --continue
export alias gams = git am --skip
export alias gama = git am --abort
export alias gamscp = git am --show-current-patch
