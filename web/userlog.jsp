<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sb" uri="/struts-bootstrap-tags" %>
<%@ include file="includes/header.jsp" %>
<title><%
  String sruid = request.getParameter("id");
  int iruid = -1;
  if (sruid != null)
    iruid = Integer.valueOf(sruid);
  if (userp != null && userp.getId() == iruid)
    out.print("我");
  else
  {%>
  <s:property value="%{(user.name == null) ? (user.username) : (user.name)}"/>
  <%}%>的动态|文献管理系统</title>
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/resources/libs/datatables/css/dataTables.bootstrap.min.css">
<script type="text/javascript" charset="utf8"
        src="${pageContext.request.contextPath}/resources/libs/datatables/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf8"
        src="${pageContext.request.contextPath}/resources/libs/datatables/js/dataTables.bootstrap.min.js"></script>
<!-- initiate datatable and ajax -->
<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {

        $(".table").dataTable({
            lengthMenu: [25, 50, 100, 150, 300],
            pageLength: 50,
            language: {
                "sProcessing": "处理中...",
                "sLengthMenu": "每页显示 _MENU_ 项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "表格内搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            },
            "ordering": false
        });
    });
</script>
<%@include file="includes/header2.jsp" %>
<div class="col-md-12">
  <ol class="breadcrumb">
    <li><a href="<s:url action="showUserDetails"><s:param name="id" value="%{id}"/></s:url>">个人中心</a></li>
    <li class="active">动态</li>
  </ol>
  <table class="table table-bordered table-striped table-hover dtno">
    <thead>
    <tr>
      <th>时间</th>
      <th>事件</th>
    </tr>
    </thead>
    <tbody>
    <s:iterator value="logs">
      <tr>
        <td>
          <s:property value="time"/>
        </td>
        <td>
          <s:property value="event" escapeHtml="false"/>
        </td>
      </tr>
    </s:iterator>
    </tbody>
  </table>
</div>
<%@ include file="includes/footer.jsp" %>