%% @author {{author_name}} <{{author_email}}>
%% @copyright {{copyright_year}} {{author_name}}
%% @doc Error controller.

%% Copyright {{copyright_year}} {{author_name}}
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
-module({{name}}_web_controller_error).

%% API
-export([ invalid_route/2 ]).

%%%=====================================================================
%%% API
%%%=====================================================================

invalid_route([_Method, _Path], Req0) ->
    Req = arizona_server:set_status_code(404, Req0),
    {ok, Req}.
