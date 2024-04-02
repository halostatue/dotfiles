if command --query eza
    function lg --description 'alias lg eza --git'
        eza --git $argv
    end

    function l --description 'alias l eza -lah'
        eza -lah $argv
    end

    function la --description 'alias la eza -a'
        eza -a $argv
    end

    function ll --description 'alias ll eza -l'
        eza -l $argv
    end
end

if command --query gmv
    alias mv 'command gmv --interactive --verbose'
end

if command --query grm
    alias rm 'command grm --interactive --verbose'
end

if command --query gcp
    alias cp 'command gcp --interactive --verbose'
end
