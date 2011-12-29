(** A simple widget for uploading files to the server without reloading the current page *)

type handle
(* Unique ID for a file that has been uploaded *)

datatype claim_result =
         NotFound (* That file was either claimed by someone else or was uploaded too long ago and never claimed. *)
       | Found of { Filename : option string,
                    MimeType : string,
                    Content : blob }

val claim : handle -> transaction claim_result
(* In server-side code, claim ownership of a [handle]'s contents, deleting the persistent record of the file data. *)

val render : {OnBegin : transaction {},
              (* Run this when an upload begins. *)
              OnSuccess : handle -> transaction {}
              (* Run this after a successful upload. *)}
             -> transaction xbody
(* Produce HTML for a file upload control *)
