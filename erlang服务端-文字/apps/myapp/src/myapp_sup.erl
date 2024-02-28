%%%-------------------------------------------------------------------
%% @doc myapp top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(myapp_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
%%init([]) ->
%%    {ok, {{one_for_all, 0, 1}, []}}.
init([]) ->
  % {ok, Pools} = application:get_env(myapp, mysql_poolboy),

  % Name = proplists:get_value(name, Pools),
  % PoolOptions = proplists:get_value(poolConf, Pools),
  % MySqlOptions = proplists:get_value(sqlConf, Pools),




  {ok, {{one_for_one, 5, 10},
    [
%%      启动mysql池
      % mysql_poolboy:child_spec(pool1, PoolOptions, MySqlOptions)


    ]
  }}.


%%====================================================================
%% Internal functions
%%====================================================================
