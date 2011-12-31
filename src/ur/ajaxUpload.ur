type handle = int

sequence handles

table scratch : { Handle : handle,
                  Filename : option string,
                  MimeType : string,
                  Content : blob,
                  Created : time }
  PRIMARY KEY Handle

(* Clean up files that go unclaimed for 30 minutes. *)
task periodic 900 = fn () =>
    tm <- now;
    dml (DELETE FROM scratch
         WHERE Created < {[addSeconds tm (-(30 * 60))]})

datatype claim_result =
         NotFound
       | Found of { Filename : option string,
                    MimeType : string,
                    Content : blob }

fun claim h =
    ro <- oneOrNoRows1 (SELECT scratch.Filename, scratch.MimeType, scratch.Content
                        FROM scratch
                        WHERE scratch.Handle = {[h]});
    case ro of
        None => return NotFound
      | Some r =>
        dml (DELETE FROM scratch
             WHERE Handle = {[h]});
        return (Found r)

fun peek h =
    ro <- oneOrNoRows1 (SELECT scratch.Filename, scratch.MimeType, scratch.Content
                        FROM scratch
                        WHERE scratch.Handle = {[h]});
    return (case ro of
                None => NotFound
              | Some r => Found r)

fun render {SubmitLabel = sl, OnBegin = ob, OnSuccess = os, OnError = oe} =
    iframeId <- fresh;
    submitId <- fresh;
    submitId' <- return (AjaxUploadFfi.idToString submitId);
    let
        fun upload r =
            if Option.isNone (checkMime (fileMimeType r.File)) then
                return <xml><body>{AjaxUploadFfi.notifyError (AjaxUploadFfi.stringToId submitId')}</body></xml>
            else
                h <- nextval handles;
                dml (INSERT INTO scratch (Handle, Filename, MimeType, Content, Created)
                     VALUES ({[h]}, {[fileName r.File]}, {[fileMimeType r.File]}, {[fileData r.File]}, CURRENT_TIMESTAMP));
                return <xml><body>
                  {AjaxUploadFfi.notifySuccess (AjaxUploadFfi.stringToId submitId') h}
                </body></xml>
    in
        return <xml>
          <form>
            <upload{#File}/>
            <submit value={Option.get "" sl} action={upload} id={submitId} onmousedown={ob} onkeydown={os} onmouseup={oe}/>
          </form>
          {AjaxUploadFfi.tweakForm (Option.isNone sl) iframeId submitId}
        </xml>
    end
