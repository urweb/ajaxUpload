function tweakForm(autoSubmit, iframeId, submitId) {
    return "<iframe id=\""
        + iframeId
        + "\" name=\""
        + iframeId
        + "\" src=\"#\" style=\"width:0;height:0;border:0px solid #fff;\"></iframe>\n<script type=\"text/javascript\">var subm = document.getElementById(\""
        + submitId
        + "\"); subm.parentNode.target = \""
        + iframeId
        + "\"; if (subm.begin == undefined) { subm.begin = subm.onmousedown; subm.onmousedown = undefined; } subm.parentNode.onsubmit = function() { subm.begin(); return true; }; if (subm.withHandle == undefined) { subm.withHandle = subm.onkeydown; subm.onkeydown = undefined; } "
        + (autoSubmit
           ? "subm.style.visibility = \"hidden\"; for (var node = subm.previousSibling; node.tagName != \"INPUT\"; node = node.previousSibling); node.onchange = function() { subm.parentNode.submit(); }; "
           : "")
        + "</script>";
}

function idToString(x) {
    return x;
}
