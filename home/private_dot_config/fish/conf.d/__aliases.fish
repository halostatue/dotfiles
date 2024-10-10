if command --query eza
    function ls --description 'alias ls eza (with auto --git)'
        if git rev-parse --is-inside-work-tree &>/dev/null
            command eza --git $argv
        else
            command eza $argv
        end
    end

    function lg --description 'alias lg eza --git'
        command eza --git $argv
    end

    function l --description 'alias l eza -lah'
        ls -lah $argv
    end

    function la --description 'alias la eza -a'
        ls -a $argv
    end

    function ll --description 'alias ll eza -l'
        ls -l $argv
    end
end
