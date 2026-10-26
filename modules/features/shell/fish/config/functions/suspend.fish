function suspend --wraps='sudo zzz' --description 'alias suspend=sudo zzz'
    sudo zzz $argv
end
