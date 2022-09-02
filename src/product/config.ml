(*
  This file is part of scilla.

  Copyright (c) 2018 - present Zilliqa Research Pvt. Ltd.

  scilla is free software: you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation, either version 3 of the License, or (at your option) any later
  version.

  scilla is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
  A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with
  scilla.  If not, see <http://www.gnu.org/licenses/>.
*)
open Core

type replacement = {
  filename : string;
  line : int;
  replacee : string;  (** Identifier that should be replaced. *)
  replacement : string;
}
[@@deriving yojson]

type config = { replacements : replacement list } [@@deriving yojson]

let from_file filename =
  try Yojson.Safe.from_file filename |> config_of_yojson with
  | Sys_error err -> Error err
  | Yojson.Json_error err ->
      Error (Printf.sprintf "%s is broken:\n%s" filename err)
  | _ -> Error (Printf.sprintf "%s is broken" filename)