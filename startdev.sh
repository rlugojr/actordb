#!/bin/sh
case $1 in
    valgrind)
        export VALGRIND_MISC_FLAGS="-v --fair-sched=yes --trace-children=yes  --tool=memcheck  --suppressions=../otp/erts/emulator/valgrind/suppress.standard --show-possibly-lost=no"
        exec ../otp/bin/cerl -valgrind -pa ebin deps/*/ebin -config etc/app.config -s actordb_core -args_file etc/vm.args
        ;;
    debug)
        exec ../otp/bin/cerl -debug -pa ebin deps/*/ebin -config etc/app.config -s actordb_core -args_file etc/vm.args
        ;;
    *)
        exec erl +C multi_time_warp -pa ebin deps/*/ebin -config etc/app.config -s actordb_core -args_file etc/vm.args +stbt db 
esac


