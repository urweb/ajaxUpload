fun main () =
    au <- AjaxUpload.render ();
    return <xml><body>
      {au}
    </body></xml>
