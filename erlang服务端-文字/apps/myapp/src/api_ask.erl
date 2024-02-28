%% coding: utf-8
-module(api_ask).
-compile(export_all).
init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.
allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.


content_types_provided(Req, State) ->
  {[
    {<<"application/json">>, func_rooms_members_data}
  ], Req, State}.

  make_request(Url,ApiKey, Body) ->
  
    CA=#{messages =>[#{role => user,content => Body}],model => <<"gpt-3.5-turbo">>,temperature => 0.7},

    Body1 = jsx:encode(CA),
  
    Headers = [{"Authorization", "Bearer "++ApiKey}],
    Request = {Url, Headers, "application/json", Body1},
    Options = [{body_format, binary}],
    Res = httpc:request(post, Request, [], Options),

      case Res of
        {ok, {{_,200,_}, _, ResBody}} ->
            jsx:decode(ResBody);
        Error ->
            error_logger:info_msg("openai error:~n~p~n", [Error]),
            timer:sleep(10000)
           % request_(Url, BodyMap, ReTry-1)
    end.

func_rooms_members_data(Req, State) ->
  P0 = cowboy_req:qs(Req),
  Ask = maps:get(<<"ask">>, jsx:decode(uri_string:unquote(P0), [])),

  ApiKey = "sk-xxxx",
  Url = "https://api.openai.com/v1/chat/completions",

  #{<<"choices">> := Choices} = make_request(Url, ApiKey, Ask),
  [#{<<"message">> := #{<<"content">> := Content}}] = Choices,
  
  Vv =    jsx:encode([{<<"code">>, 0}, {<<"msg">>, <<"succ"/utf8>>}, {<<"data">>, Content}]),
    

  {Vv, Req, State}.

%   Python 轮训
% import requests  1秒1次 付费用户 1秒10次 100次 1000次  通过多个key可以轮训使用

% api_keys = [
%     "YOUR_API_KEY_1",
%     "YOUR_API_KEY_2",
%     "YOUR_API_KEY_3",
% ]

% for api_key in api_keys:
%     response = requests.get("https://api.openai.com/v1/completions",
%                              headers={"Authorization": "Bearer {}".format(api_key)})

%     if response.status_code == 200:
%         print(response.json())
%     else:
%         print(response.status_code)