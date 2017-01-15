package com.recipe_cont.controler;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.stream.JsonReader;
import com.recipe.model.RecipeService;
import com.recipe.model.RecipeVO;
import com.recipe_cont.model.Recipe_contService;
import com.recipe_cont.model.Recipe_contVO;
import com.recipe_cont.model.*;

import util.ImageUtil;
import util.SendResponse;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
@WebServlet("/recipe_cont/recipe_cont_android.do")

public class Recipe_contServletAndroid extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		Recipe_contService recipe_contSvc = new Recipe_contService();
		BufferedReader br = req.getReader();
		StringBuffer jsonIn = new StringBuffer();
		String line = null;
		
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		
		if (gson.fromJson(jsonIn.toString(), JsonObject.class) == null) {
			return;
		}

		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);

		String action = jsonObject.get("action").getAsString();
		System.out.println("Recipe_cont action = " + action);
		StringBuffer outStr = new StringBuffer();
		
		if ("getOne_For_Display".equals(action) || "getOne_For_Update".equals(action)) { // 來自select_page.jsp的請求

		}
		
		if("showRecipe_cont_pic".equals(action)){
			
			OutputStream os = res.getOutputStream();
			String recipe_no = jsonObject.get("recipe_no").getAsString();
			int step = jsonObject.get("step").getAsInt();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			
			Recipe_contVO recipe_contVO = recipe_contSvc.getOneRecipe_cont(recipe_no, step);
			
			byte[] step_pic = recipe_contVO.getStep_pic();
			System.out.println("recipe_no " + recipe_no + " step " + step + " imageSize " + imageSize);

			if (step_pic != null) {

				step_pic = ImageUtil.shrink(step_pic, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(step_pic.length);
			} else {
				InputStream in = getServletContext().getResourceAsStream("/noImages/noimage.jpg");
				step_pic = new byte[in.available()];
				in.read(step_pic);
				in.close();
			}
			os.write(step_pic);
			return;
		}
		
		if ("update".equals(action)) {
			
		}
		
		if ("insert".equals(action)) {
			
			String recipe_contJson = jsonObject.get("recipe_contVO").getAsString();
			Recipe_contVO recipe_contVO = gson.fromJson(recipe_contJson, Recipe_contVO.class);
			System.out.println("================新增食譜步驟========================");
			System.out.println("recipe_contVO.getRecipe_no():"+recipe_contVO.getRecipe_no());
			System.out.println("recipe_contVO.getStep_cont():"+recipe_contVO.getStep_cont());
			System.out.println("recipe_contVO.getStep().toString():"+recipe_contVO.getStep().toString());
			
			recipe_contVO = recipe_contSvc.addRecipe_cont(recipe_contVO.getRecipe_no(), recipe_contVO.getStep(),
					recipe_contVO.getStep_pic(), recipe_contVO.getStep_cont());
			RecipeService recipeSvc = new RecipeService();
			RecipeVO recipeVO = new RecipeVO();
			recipeVO = recipeSvc.getOneRecipe(recipe_contVO.getRecipe_no());
			recipeSvc.updateRecipe(recipeVO.getRecipe_no(),recipeVO.getRecipe_name(),
					recipeVO.getRecipe_intro(),recipeVO.getFood_mater(),
					recipeVO.getRecipe_pic(),"已發布"); //新增食譜步驟之後，recipe_edit狀態改為已發布 

			outStr.append(gson.toJson(recipe_contVO));
			SendResponse.writeText(res, outStr.toString());			
		}
		

		
		if ("deleteImage".equals(action)) { 

		}

	}
	
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
//		System.out.println("filename=" + filename); // 測試用
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}

}
