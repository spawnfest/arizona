%% @author William Fank Thomé <willilamthome@hotmail.com>
%% @copyright 2023 William Fank Thomé
%% @doc Cowboy server adapter.

%% Copyright 2023 William Fank Thomé
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
-module(arizona_server_adapter_cowboy).

-behaviour(arizona_server_adapter).
-behaviour(cowboy_handler).

%% arizona_server_adapter callbacks
-export([ start/1, stop/1 ]).

%% cowboy_handler callbacks
-export([ init/2 ]).

%% Macros
-define(LISTENER, arizona_http_listener).

%%%=====================================================================
%%% arizona_server_adapter callbacks
%%%=====================================================================

start(Args) ->
    URL = maps:get(url, Args),
    Dispatch = cowboy_router:compile([{'_', routes()}]),
    % @see: https://ninenines.eu/docs/en/ranch/2.1/manual/ranch_tcp/
    RanchOpts = [
        {ip, maps:get(ip, URL)},
        {port, maps:get(port, URL)}
    ],
    Opts = #{env => #{dispatch => Dispatch}},
    case cowboy:start_clear(?LISTENER, RanchOpts, Opts) of
        {ok, _} ->
            ok;
        {error, Reason} ->
            {error, Reason}
    end.

stop(_State) ->
    ok = cowboy:stop_listener(?LISTENER).

%%%=====================================================================
%%% cowboy_handler callbacks
%%%=====================================================================

init(Req, State) ->
    Bindings = #{name => <<"World">>},
    HTML = arizona_web_live_view_example:render(Bindings),
    Headers = #{<<"content-type">> => <<"text/html">>},
    Res = cowboy_req:reply(200, Headers, HTML, Req),
    {ok, Res, State}.

%%%=====================================================================
%%% Internal functions
%%%=====================================================================

% @todo: static routes should not be hardcoded.
routes() ->
    [
        {"/assets/[...]", cowboy_static, {priv_dir, arizona, "static/assets"}},
        {"/favicon.ico", cowboy_static, {priv_file, arizona, "static/favicon.ico"}},
        {"/robots.txt", cowboy_static, {priv_file, arizona, "static/robots.txt"}},
        {'_', ?MODULE, []}
    ].
