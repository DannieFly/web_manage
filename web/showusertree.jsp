<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sb" uri="/struts-bootstrap-tags" %>
<%@ include file="includes/header.jsp" %>
<title>我的分类树|文献管理系统</title>
<!--include treemenu>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/libs/treemenu/css/treemenu.css"/>
<script src="${pageContext.request.contextPath}/resources/libs/treemenu/js/treemenu.js"></script-->
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/libs/fancytree/css/skin-bootstrap/ui.fancytree.css"/>
<script src="${pageContext.request.contextPath}/resources/libs/fancytree/js/jquery.fancytree-all.js"></script>
<!--initiate treemenu-->
<script>
    var glyph_opts = {
        map: {
            doc: "glyphicon glyphicon-file",
            docOpen: "glyphicon glyphicon-file",
            checkbox: "glyphicon glyphicon-unchecked",
            checkboxSelected: "glyphicon glyphicon-check",
            checkboxUnknown: "glyphicon glyphicon-share",
            dragHelper: "glyphicon glyphicon-play",
            dropMarker: "glyphicon glyphicon-arrow-right",
            error: "glyphicon glyphicon-warning-sign",
            expanderClosed: "glyphicon glyphicon-menu-right",
            expanderLazy: "glyphicon glyphicon-menu-right",  // glyphicon-plus-sign
            expanderOpen: "glyphicon glyphicon-menu-down",  // glyphicon-collapse-down
            folder: "glyphicon glyphicon-folder-close",
            folderOpen: "glyphicon glyphicon-folder-open",
            loading: "glyphicon glyphicon-refresh glyphicon-spin"
        }
    };
    $(document).ready(function () {
        var $tree = $("#tree");
        $tree.fancytree({
            extensions: ["glyph"],
            glyph: glyph_opts,
            activate: function (event, data) {
                $(".fancytree-active").children(".fancytree-title").popover({
                    placement: "right",
                    title: "节点论文",
                    content: "hello"
                });
            }
        });
        $tree.fancytree("getRootNode").visit(function (node) {
            node.setExpanded(true);
        });
        $(".fancytree-title").each(function (index, element) {
            var content;
            var title = element.text();
            $.ajax({
                url:"<s:url action="getPapersByTreeNodeName"/>",
                data:{nodeName:title},
            });
            this.popover({
                placement: "right",
                title: "节点论文",
                content: content
            });
        })
    });
</script>
<%@include file="includes/header2.jsp" %>
<div id="tree">
  <s:property value="frontEndTree" escapeHtml="false"/>
</div>
<%@ include file="includes/footer.jsp" %>
