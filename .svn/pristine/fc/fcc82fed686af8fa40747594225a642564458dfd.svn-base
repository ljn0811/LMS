package kr.happyjob.study.adm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adm.model.AdminInfoVO;
import kr.happyjob.study.adm.model.TutorInfoVO;
import kr.happyjob.study.adm.service.AdminInfoService;

@Controller
@RequestMapping("/adm/")
public class AdminInfoController {

	@Autowired
	AdminInfoService adminService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("adminControl.do")
	public String adminControl(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".adminControl");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".adminControl");

		return "adm/adminInfo";
	}
	
	@RequestMapping("adminList.do")
	public String adminList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".adminList");
			logger.info("   - paramMap : " + paramMap);

			int cpage = Integer.valueOf((String) paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
			int startpos = (cpage - 1) * pagesize;

			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);			
			
			
			List<TutorInfoVO> listData = adminService.adminList(paramMap);
			int listCnt = adminService.adminCnt(paramMap);
			model.addAttribute("listData", listData);
			model.addAttribute("listCnt", listCnt);
			

			logger.info("+ End " + className + ".adminList");

			return "adm/adminList";
	}
	
	@RequestMapping("adminDetail.do")	  
	@ResponseBody 
	public Map<String, Object> adminDetail(@RequestParam Map<String, Object> paramMap) throws Exception{ 
		  
		logger.info("+ Start " + className + ".adminDetail"); 
		logger.info("   - paramMap : " + paramMap);
	  
		AdminInfoVO adminInfo = adminService.adminDetail(paramMap); 
	  
		Map<String, Object> resultMap = new HashMap<String, Object>();	  
		
	  
	  	resultMap.put("adminInfo", adminInfo); 
	  
	  	logger.info("+ End " + className + ".adminDetail"); 
	  	
	  	return resultMap; 
	 }
	
	
	 @RequestMapping("adminModify.do")	  
	 @ResponseBody 
	 public Map<String, Object> adminDelete(@RequestParam Map<String, Object> paramMap) throws Exception{ 
		  
		 logger.info("+ Start " + className + ".adminModify"); 
		 logger.info("   - paramMap : " + paramMap);
		 
		int result = 0;
		String resultMsg = "";
		String action = (String) paramMap.get("action");
			
		if("U".equals(action)){
			result = adminService.adminUpdate(paramMap);					
		}else if("D".equals(action)){
			result = adminService.adminDelete(paramMap);
		}	  
	  
		Map<String, Object> resultMap = new HashMap<String, Object>();
	  
		if(result >= 0){
			if("U".equals(action)){
				resultMsg = "수정  되었습니다.";
			}else if("D".equals(action)){
				resultMsg = "삭제  되었습니다.";
			}
		}else{
			if("U".equals(action)){
				resultMsg = "수정에 실패했습니다.";
			}else if("D".equals(action)){
				resultMsg = "삭제 실패했습니다.";
			}
		}
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
	  
	  	logger.info("+ End " + className + ".adminModify"); 
	  	
	  	return resultMap; 
	 }
}
