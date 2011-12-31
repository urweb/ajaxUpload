#include <ctype.h>

#include <ajaxUpload.h>

uw_Basis_string uw_AjaxUploadFfi_tweakForm(uw_context ctx, uw_Basis_bool autoSubmit, uw_Basis_string iframeId, uw_Basis_string submitId) {
  return uw_Basis_mstrcat(ctx,
                          "<iframe id=\"",
                          iframeId,
                          "\" name=\"",
                          iframeId,
                          "\" src=\"#\" style=\"width:0;height:0;border:0px solid #fff;\"></iframe>\n<script type=\"text/javascript\">var subm = document.getElementById(\"",
                          submitId,
                          "\"); subm.parentNode.target = \"",
                          iframeId,
                          "\"; var onSub = subm.onmousedown; subm.onmousedown = undefined; subm.parentNode.onsubmit = function() { onSub(); return true; }; subm.withHandle = subm.onkeydown; subm.onkeydown = undefined; subm.withError = subm.onmouseup; subm.onmouseup = undefined; ",
                          autoSubmit
                          ? "subm.style.visibility = \"hidden\"; for (var node = subm.previousSibling; node.tagName != \"INPUT\"; node = node.previousSibling); node.onchange = function() { subm.parentNode.submit(); }; "
                          : "",
                          "</script>",
                          NULL);
}

uw_Basis_string uw_AjaxUploadFfi_notifySuccess(uw_context ctx, uw_Basis_string submitId, uw_Basis_int handle) {
  return uw_Basis_mstrcat(ctx,
                          "<script type=\"text/javascript\">var subm = window.top.document.getElementById(\"",
                          submitId,
                          "\"); window.top.event = {keyCode : ",
                          uw_Basis_htmlifyInt(ctx, handle),
                          "}; subm.withHandle(); </script>",
                          NULL);
}

uw_Basis_string uw_AjaxUploadFfi_notifyError(uw_context ctx, uw_Basis_string submitId) {
  return uw_Basis_mstrcat(ctx,
                          "<script type=\"text/javascript\">var subm = window.top.document.getElementById(\"",
                          submitId,
                          "\"); subm.withError(); </script>",
                          NULL);
}

uw_Basis_string uw_AjaxUploadFfi_idToString(uw_context ctx, uw_Basis_string s) {
  return s;
}

uw_Basis_string uw_AjaxUploadFfi_stringToId(uw_context ctx, uw_Basis_string s) {
  char *s2 = s;

  if (*s2 == '-')
    ++s2;

  for (++s2; *s2; ++s2)
    if (!isdigit(*s2))
      uw_error(ctx, FATAL, "AjaxUploadFfi.stringToId: Invalid ID");

  return s;
}
