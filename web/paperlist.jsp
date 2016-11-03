<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sb" uri="/struts-bootstrap-tags" %>
<% Boolean useDatatable = true;%>
<%@ include file="includes/header.jsp" %>
<s:if test="%{papers.isEmpty()}">
  <h4 class="text-center">数据库中没有论文╮（╯＿╰）╭
    <%
      // todo
    %>主人快来<a href="addpaper.jsp">添加论文</a>吧！</h4>
</s:if>
<s:else>
  <%
    if (userp != null)
    {
  %>
  <div class="col-md-3 col-md-offset-9">
    <a href="addpaper.jsp" class="btn btn-primary btn-block btn-lg">
      <span class="glyphicon glyphicon-plus"></span>&nbsp;新增论文
    </a>
  </div>
  </div>
  <div class="row" style="margin-top: 30px">
  <%
    }
  %>
  <table class="table table-bordered table-striped table-hover">
    <thead>
    <tr>
      <th style='vertical-align: middle;' width="50%">篇名
        <span class="glyphicon glyphicon-question-sign" data-toggle="tooltip" data-placement="top"
              title="点击书名查看详情"></span>
      </th>
      <th style='vertical-align: middle;' width="20%">作者</th>
      <th style='vertical-align: middle;' width="20%">发表时间</th>
      <th style='vertical-align: middle;' width="10%">收藏</th>
    </tr>
    </thead>
    <tbody>
    <s:iterator value="papers">
      <tr>
        <td style='vertical-align: middle;'>
          <a href='<s:url action="showPaperDetails"><s:param name="id" value="id" /></s:url>'>
            <s:property value="%{title}"/>
          </a>
        </td>
        <td style='vertical-align: middle;'><s:iterator value="authors"><s:property/>&nbsp;</s:iterator></td>
        <td style='vertical-align: middle;'><s:property value="%{publishDate}"/></td>
        <td style='vertical-align: middle;'>
          <!--  <button class="btn btn-sm btn-danger">
              点击收藏 -->
          <select id="Choice" title="收藏状态" class="form-control select select-primary select-block">
            <option value="未收藏" >未收藏</option>
            <option value="计划读">计划读</option>
            <option value="已粗读">已粗读</option>
            <option value="已精读">已精读</option>
          </select>
          <!-- </button> -->
        </td>
      </tr>
    </s:iterator>
    </tbody>
  </table>
</s:else>
<%@ include file="includes/footer.jsp" %>
