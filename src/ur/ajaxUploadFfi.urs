val tweakForm : bool -> id -> id -> xbody
val notifySuccess : id -> int -> xbody
val notifyError : id -> xbody

val idToString : id -> string
val stringToId : string -> id
