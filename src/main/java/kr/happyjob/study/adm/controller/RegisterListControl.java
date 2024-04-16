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

import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.adm.model.RegisterListControlVO;
import kr.happyjob.study.adm.service.RegisterListControlService;

@Controller
@RequestMapping("/adm/")
public class RegisterListControl {
   
   @Autowired
   RegisterListControlService registerListControlService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   /**
    * 강의계획서 초기화면
    */
   @RequestMapping("registerListControl.do")
   public String registerListControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".registerListControl");
      logger.info("   - paramMap : " + paramMap);
		
      
      int userno = (int) session.getAttribute("user_no");
      paramMap.put("user_no", userno);
      RegisterListControlVO lecUserInfo = registerListControlService.lecUserinfo(paramMap);
      List<RegisterListControlVO> listData = registerListControlService.registerListControlPlan(paramMap);
      
      
      model.addAttribute("lecUserInfo",lecUserInfo);
      model.addAttribute("listData",listData);
      
      logger.info("+ End " + className + ".registerListControl");

      return "adm/registerListControl";
   } 
   
   // 강의계획서 목록 불러오기
   @RequestMapping("registerListControlList.do")
	public String registerListControlList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".registerListControlList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<RegisterListControlVO> listData = registerListControlService.registerListControlList(paramMap);
		int listCnt = registerListControlService.registerListControlCnt(paramMap);
		
		model.addAttribute("listData",listData);
		model.addAttribute("listCnt",listCnt);
		
		logger.info("+ End " + className + ".registerListControlList");

		return "adm/registerListControlList";
	}	
   
	@RequestMapping("registerListControlDetail.do")
	@ResponseBody
	public Map<String, Object> registerListControlDetail( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".registerListControlDetail");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		List<ClassroomVO> classroomList = registerListControlService.classroomList(paramMap);
		RegisterListControlVO selinfo = registerListControlService.registerListControlDetail(paramMap);
		returnmap.put("selinfo", selinfo);
		returnmap.put("classroomList", classroomList);
		
		logger.info("+ End " + className + ".registerListControlDetail");

		return returnmap;
	}	
 
	// 강의 계획서 등록
	@RequestMapping("registerListControlSave.do")
	@ResponseBody
	public Map<String, Object> registerListControlSave( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".registerListControlSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String lecType = (String) paramMap.get("lec_type");
		String lecNm = (String) paramMap.get("lec_nm");
		String action = (String) paramMap.get("action");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";

		if("I".equals(action)) {						
			sreturn = registerListControlService.registerListControlSave(paramMap);
		} else if("U".equals(action)) {
			sreturn = registerListControlService.registerListControlUpdate(paramMap);
		} else if("D".equals(action)) {
			sreturn = registerListControlService.registerListControlDelete(paramMap);
		}
		
		if(sreturn >= 0) {
			result = "S";			
			if("D".equals(action)) {
				resultmsg = "삭제 되었습니다.";
			} else {
				resultmsg = "저장 되었습니다.";
			}
			
		} else {
			result = "F";			
			if("D".equals(action)) {
				resultmsg = "삭제 실패 했습니다.";
			} else {
				resultmsg = "저장에 실패 했습니다.";
			}
			
		}
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		paramMap.put("lec_type", lecType);
		paramMap.put("lec_nm", lecNm);
		
		logger.info("+ End " + className + ".registerListControlSave");

		return returnmap;
	}	
}