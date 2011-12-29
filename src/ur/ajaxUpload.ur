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
    return (case ro of
                None => NotFound
              | Some r => Found r)

fun render {} =
    iframeId <- fresh;
    submitId <- fresh;
    let
        fun upload r =
            h <- nextval handles;
            dml (INSERT INTO scratch (Handle, Filename, MimeType, Content, Created)
                 VALUES ({[h]}, {[fileName r.File]}, {[fileMimeType r.File]}, {[fileData r.File]}, CURRENT_TIMESTAMP));
            return <xml>OK!</xml>
    in
        return <xml>
          <form>
            <upload{#File}/>
            <submit action={upload} id={submitId}/>
          </form>
          {AjaxUploadFfi.tweakForm iframeId submitId}
        </xml>
    end
