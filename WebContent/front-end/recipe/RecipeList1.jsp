<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.recipe.model.*"%>
<%@ page import="com.recipe_cont.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.recipe.model.*"%>

<% 
   List<RecipeVO> list = (List)request.getAttribute("list");
   request.setAttribute("list",list);
%>
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService" />

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>最新食譜</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
			
			body{
				background: #efede8;
				padding-top: 50px;
			}
			.page-top-title-wrapper{
				background: #fff;
				margin-bottom: 5px;
				border:1px solid #d3d0c9;
			}
			.recipe-row-wrapper{
				margin-bottom: 10px;
			}
			.recipe-row-wrapper img{
				width:230px;
				height:200px;
			}
			.recipe-item-wrapper{
				background: #fff;
				padding: 15px;
				border:1px solid #d3d0c9;
				height:230px;
			}
			.recipe-item-wrapper-right{
				padding: 15px 15px 15px 15px;
				background: #fff;
				border:1px solid #d3d0c9;
				height:230px;
			}
			.recipe-item-wrapper h3{
				margin:0px 0px 5px 0px;	
			}
			.recipe-item-wrapper-right h3{
				margin:0px 0px 5px 0px;
			}
			.recipe-item-left{
				padding:0px;
			}
			.recipe-item-right{
				padding:0px;
			}
			.recipe-intro{
				color:#706864;
				height:60px;
				word-break:break-all;
			}
			.recipe-food-mater{
				color:#b6b0a5;
				word-break:break-all;
				height:40px;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12 page-top-title-wrapper">
					<h4 class="title-item-top">${title}</h4>
				</div>
			</div>
	<%@ include file="page1.file" %> 
	
	<c:forEach var="recipeVO" items="${list}" varStatus="s" step="2" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> 
			<div class="row recipe-row-wrapper">
				<div class="col-xs-12 col-sm-6 recipe-item-wrapper">
					<div class="col-xs-12 col-sm-5 recipe-item-left">
					<a href="<%=request.getContextPath()%>/recipe/recipe.do?action=getOne_For_Display&recipe_no=${recipeVO.recipe_no}">
						<img src="<%=request.getContextPath()%>/recipe/showRecipe_pic.do?recipe_no=${recipeVO.recipe_no}">
					</a>
					</div>
					<div class="col-xs-12 col-sm-7 recipe-item-right">
					<a href="<%=request.getContextPath()%>/recipe/recipe.do?action=getOne_For_Display&recipe_no=${recipeVO.recipe_no}">
						<h3>${recipeVO.recipe_name}</h3>
						</a>
						<p>by <a href="#">${memberSvc.getOneMember(recipeVO.mem_no).mem_name}</a></p>
						<p class="recipe-intro">${recipeVO.recipe_intro}</p>
						<p class="recipe-food-mater">食材：${recipeVO.food_mater}</p>
						<p>
							<i class="glyphicon glyphicon-eye-open">${recipeVO.recipe_total_views}</i>
							<i class="glyphicon glyphicon-heart">${recipeVO.recipe_like}</i>
						</p>
					</div>
				</div>
				<c:if test="${s.index+1 < list.size()}">
				<div class="col-xs-12 col-sm-6 recipe-item-wrapper-right">
					<div class="col-xs-12 col-sm-5 recipe-item-left">
						<img src="<%=request.getContextPath()%>/recipe/showRecipe_pic.do?recipe_no=${list.get(s.index+1).recipe_no}">
					</div>
					<div class="col-xs-12 col-sm-7 recipe-item-right">
						<h3>${list.get(s.index+1).recipe_name}</h3>
						<p>by <a href="#">${memberSvc.getOneMember(list.get(s.index+1).mem_no).mem_name}</a></p>
						<p class="recipe-intro">${list.get(s.index+1).recipe_intro}</p>
						<p class="recipe-food-mater">食材：${list.get(s.index+1).food_mater}</p>
						<p>
							<i class="glyphicon glyphicon-eye-open">555</i>
							<i class="glyphicon glyphicon-heart">200</i>
						</p>
					</div>
				</div>
				</c:if>
			</div>
		</c:forEach>

			

		<%@ include file="page2.file" %>
		</div>
		
		
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	</body>
</html>