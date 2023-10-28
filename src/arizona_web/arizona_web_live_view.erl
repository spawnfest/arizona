%% @author William Fank Thomé <willilamthome@hotmail.com>
%% @copyright 2023 William Fank Thomé
%% @doc LiveView.

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
-module(arizona_web_live_view).

%% Types
-export_type([ bindings/0, render_state/0 ]).

-type bindings() :: arizona_template_adapter:bindings().
-type render_state() :: arizona_template_adapter:state().

%% Callbacks
-optional_callbacks([]).

-callback render(Bindings) -> {Bindings, RenderState}
    when Bindings :: bindings()
       , RenderState :: render_state()
       .