<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.recipe.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    RecipeService recipeSvc = new RecipeService();
    List<RecipeVO> list = recipeSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<%-- <jsp:useBean id="recipeSvc" class="com.recipe.model.RecipeService"/> --%>

<html>
<head>
<title>所有食譜資料 - listAllRecipe.jsp</title>
</head>
<body bgcolor='white'>
<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>所有食譜資料 - listAllRecipe.jsp</h3>
		<a href="select_page.jsp">回首頁</a>
		</td>
	</tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li>${message}</li>
		</c:forEach>
	</ul>
	</font>
</c:if>

<table border='1' bordercolor='#CCCCFF' width='1800'>
	<tr>
		<th>食譜編號</th>
		<th>食譜圖片</th>
		<th>作者</th>
		<th>食譜名稱</th>
		<th>食譜簡介</th>
		<th>食材</th>
		<th>食譜按讚人數</th>
		<th>食譜總人氣</th>
		<th>食譜周人氣</th>
		<th>食譜上傳時間</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="recipeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle'>
			<td>${recipeVO.recipe_no}</td>
			<td>圖片</td>
			<td>${recipeVO.mem_no}</td>
			<td>${recipeVO.recipe_name}</td>
			<td>${recipeVO.recipe_intro}</td>
			<td>${recipeVO.food_mater}</td>
			<td>${recipeVO.recipe_like}</td>
			<td>${recipeVO.recipe_total_views}</td>
			<td>${recipeVO.recipe_week_views}</td>
			<td>${recipeVO.recipe_time}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/recipe/recipe.do">
			     <input type="submit" value="修改">
			     <input type="hidden" name="recipe_no" value="${recipeVO.recipe_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/recipe/recipe.do">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="recipe_no" value="${recipeVO.recipe_no}">
			    <input type="hidden" name="action"value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
