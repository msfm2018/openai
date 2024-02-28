%%%-------------------------------------------------------------------
%% @doc myapp public API
%% @end
%%%-------------------------------------------------------------------

-module(myapp_app).

-behaviour(application).


%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% APIapi_user_rooms
%%====================================================================
%%面向企业 api
start(_StartType, _StartArgs) ->

  Dispatch = cowboy_router:compile([
    {'_', [
        {"/api_ask", api_ask, []}  ,   
        {"/", toppage_h, []}
    ]}
  ]),
{ok, _} = cowboy:start_clear(http, [{port, 3001}], #{
		env => #{dispatch => Dispatch}
	}),


  myapp_sup:start_link().


%%--------------------------------------------------------------------
stop(_State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================
