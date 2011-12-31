function tweakFormCode(autoSubmit, iframeId, submitId) {
    var subm = document.getElementById(submitId);
    if (subm == null && thisScript != null && thisScript.parentNode != null && thisScript.parentNode.getElementsByTagName) {
        var subms = thisScript.parentNode.getElementsByTagName("input");
        for (var i = 0; i < subms.length; ++i)
            if (subms[i].id == submitId) {
                subm = subms[i];
                break;
            }
    }
    if (subm == null) er("Can't find AjaxUpload control!");

    subm.parentNode.target = iframeId;

    if (subm.begin == undefined) {
        subm.begin = subm.onmousedown;
        subm.onmousedown = undefined;
    }

    subm.parentNode.onsubmit = function() {
        subm.begin();
        return true;
    };

    if (subm.withHandle == undefined) {
        subm.withHandle = subm.onkeydown;
        subm.onkeydown = undefined;
    }

    if (subm.withError == undefined) {
        subm.withError = subm.onmouseup;
        subm.onmouseup = undefined;
    }

    if (autoSubmit) {
        subm.style.visibility = "hidden";
        for (var node = subm.previousSibling; node.tagName != "INPUT"; node = node.previousSibling);
        node.onchange = function() { subm.parentNode.submit(); };
    }
}

function tweakForm(autoSubmit, iframeId, submitId) {
    return "<iframe id=\""
        + iframeId
        + "\" name=\""
        + iframeId
        + "\" src=\"#\" style=\"width:0;height:0;border:0px solid #fff;\"></iframe>\n<script type=\"text/javascript\">tweakFormCode("
        + autoSubmit
        + ",\""
        + iframeId
        + "\",\""
        + submitId
        + "\");</script>";
}

function idToString(x) {
    return x;
}
