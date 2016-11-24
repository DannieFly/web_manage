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
      <th width="40%">篇名</th>
      <th width="20%">作者</th>
      <th width="20%">发表时间</th>
      <%if(userp != null) {%>
      <th width="20%">收藏</th>
      <%}%>
    </tr>
    </thead>
    <tbody>
    <s:iterator value="papers">
      <tr>
        <td>
          <a href='<s:url action="showPaperDetails"><s:param name="id" value="id" /></s:url>'>
            <s:property value="%{title}"/>
          </a>
        </td>
        <td><s:iterator value="authors"><s:property/>&nbsp;</s:iterator></td>
        <td><s:property value="%{publishDate}"/></td>
        <%
          if(userp != null)
          {
        %>
        <td>
          <select id="ps_<s:property value="%{id}"/>" style="width: 75%; min-width: 0px; float: left"
                  class="form-control select select-primary clct" title="收藏状态" >
            <option value="0">未收藏</option>
            <option value="1">计划读</option>
            <option value="2">已粗读</option>
            <option value="3">已精读</option>
          </select>
          <div class="loading-icon">
            <span id="ms_<s:property value="%{id}"/>" class="glyphicon loader hidden primary"
                  style="font-size: 20px;text-align: center;"></span>
          </div>
        </td>
        <%
          }
        %>
      </tr>
    </s:iterator>
    </tbody>
  </table>
</s:else>
<%@ include file="includes/footer.jsp" %>
