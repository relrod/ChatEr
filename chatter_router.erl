-module (chatter_router).
-author ("Ricky Elrod <ricky@elrod.me>").
-export ([route_message/0, start/0, stop/1, send_msg/3]).

start() ->
    spawn(chatter_router, route_message, []).

stop(Router) ->
    Router ! shutdown.

send_msg(Router, Target, Message) ->
    Router ! {send_msg, Target, Message}.

route_message() ->
    receive
        {send_msg, Target, Message} ->
            Target ! {receive_msg, Message},
            route_message();
        {receive_msg, Message} ->
            io:format("Received: ~p~n", [Message]),
            route_message();
        shutdown ->
            io:format("Shutting router process down.~n");
        CatchAll ->
            io:format("[WARN] Received: ~p~n", [CatchAll])
    end.