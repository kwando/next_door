-module(next_door_ffi).

-export([arp_table/0]).

arp_table() ->
    erlang:list_to_binary(
        os:cmd('arp -na')).
