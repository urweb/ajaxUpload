#include <ajaxUpload.h>

uw_Basis_string uw_AjaxUploadFfi_tweakForm(uw_context ctx, uw_Basis_string iframeId, uw_Basis_string submitId) {
  return uw_Basis_mstrcat(ctx,
                          "<iframe id=\"",
                          iframeId,
                          "\" name=\"",
                          iframeId,
                          "\" src=\"#\"></iframe>\n<script type=\"text/javascript\">var subm = document.getElementById(\"",
                          submitId,
                          "\"); subm.parentNode.target = \"",
                          iframeId,
                          "\";</script>",
                          NULL);
}
