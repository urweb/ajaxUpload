sequence ids

table images : { Id : int, MimeType : string, Content : blob }
  PRIMARY KEY Id

fun choice b =
    status <- source <xml/>;
    au <- AjaxUpload.render {SubmitLabel = if b then None else Some "Upload it!",
                             OnBegin = set status <xml>Uploading</xml>,
                             OnSuccess = fn h =>
                                            let
                                                fun addImage () =
                                                    r <- AjaxUpload.claim h;
                                                    case r of
                                                        AjaxUpload.NotFound => return None
                                                      | AjaxUpload.Found r =>
                                                        id <- nextval ids;
                                                        dml (INSERT INTO images (Id, MimeType, Content)
                                                             VALUES ({[id]}, {[r.MimeType]}, {[r.Content]}));
                                                        return (Some id)
                                            in
                                                ido <- rpc (addImage ());
                                                case ido of
                                                    None => alert "Newly uploaded image not found!"
                                                  | Some id =>
                                                    let
                                                        fun image () =
                                                            r <- oneRow1 (SELECT images.MimeType, images.Content
                                                                          FROM images
                                                                          WHERE images.Id = {[id]});
                                                            returnBlob r.Content (blessMime r.MimeType)
                                                    in
                                                        set status <xml><img src={url (image ())}/></xml>
                                                    end
                                            end};
    return <xml><body>
      {au}
      <hr/>
      <dyn signal={signal status}/>
    </body></xml>

fun main () = return <xml><body>
  <a link={choice False}>Normal</a><br/>
  <a link={choice True}>Auto-submit</a>
</body></xml>
