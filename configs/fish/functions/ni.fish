function ni --wraps='nh os rollback -t' --description 'alias ni=nh os rollback -t'
    nh os rollback -t $argv
end
