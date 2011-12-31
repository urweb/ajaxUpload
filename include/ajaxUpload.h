#include <urweb.h>

uw_Basis_string uw_AjaxUploadFfi_tweakForm(uw_context, uw_Basis_bool autoSubmit, uw_Basis_string iframeId, uw_Basis_string submitId);
uw_Basis_string uw_AjaxUploadFfi_notifySuccess(uw_context, uw_Basis_string submitId, uw_Basis_int handle);
uw_Basis_string uw_AjaxUploadFfi_notifyError(uw_context, uw_Basis_string submitId);

uw_Basis_string uw_AjaxUploadFfi_idToString(uw_context, uw_Basis_string);
uw_Basis_string uw_AjaxUploadFfi_stringToId(uw_context, uw_Basis_string);
