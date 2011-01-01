-module (chatter_client).
-author ("Ricky Elrod <ricky@elrod.me>").
-export ([send_message/3]).

send_message(Router, Target, Message) ->
    chatter_router:send_msg(Router, Target, Message).


