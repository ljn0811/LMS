package kr.happyjob.study.tut.controller;

import java.util.HashMap;
import java.util.Iterator;
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
import kr.happyjob.study.tut.model.LecturePlanVO;
import kr.happyjob.study.tut.service.LecturePlanService;


@Controller
@RequestMapping("/tut/")
public class LecturePlanController {
   
   @Autowired
   LecturePlanService lecturePlanService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   /**
    * 강의계획서 초기화면
    */
   @RequestMapping("lecturePlan.do")
   public String lecturePlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".LecturePlan");
      logger.info("   - paramMap : " + paramMap);
		
      
      int userno = (int) session.getAttribute("user_no");
      paramMap.put("user_no", userno);
      LecturePlanVO lecUserInfo = lecturePlanService.lecUserinfo(paramMap);
      List<LecturePlanVO> listData = lecturePlanService.lecturePlan(paramMap);
      
      
      model.addAttribute("lecUserInfo",lecUserInfo);
      model.addAttribute("listData",listData);
      
      logger.info("+ End " + className + ".LecturePlan");

      return "tut/lecturePlan";
   } 
   
   // 강의계획서 목록 불러오기
   @RequestMapping("lecturePlanList.do")
	public String lecturePlanList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlanList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LecturePlanVO> listData = lecturePlanService.lecturePlanList(paramMap);
		int listCnt = lecturePlanService.lecturePlanCnt(paramMap);
		
		model.addAttribute("listData",listData);
		model.addAttribute("listCnt",listCnt);
		
		logger.info("+ End " + className + ".lecturePlanList");

		return "tut/lecturePlanList";
	}	
   
	@RequestMapping("lecturePlanDetail.do")
	@ResponseBody
	public Map<String, Object> lecturePlanDetail( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlanDetail");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		List<LecturePlanVO> weekPlan = lecturePlanService.weekList(paramMap);
		LecturePlanVO selinfo = lecturePlanService.lecturePlanDetail(paramMap);
		int checkWeek = lecturePlanService.checkWeek(paramMap);
		returnmap.put("selinfo", selinfo);
		returnmap.put("weekPlan", weekPlan);
		returnmap.put("checkWeek", checkWeek);
		 
		logger.info("+ End " + className + ".lecturePlanDetail");

		return returnmap;
	}	
	

	// 강의 계획서 등록
	@RequestMapping("lecturePlanSave.do")
	@ResponseBody
	public Map<String, Object> registerListControlSave( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlanSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String lecType = (String) paramMap.get("lec_type");
		String lecNm = (String) paramMap.get("lec_nm");
		String action = (String) paramMap.get("action");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";

		if("I".equals(action)) {						
			sreturn = lecturePlanService.lecturePlanSave(paramMap);
		} else if("U".equals(action)) {
			sreturn = lecturePlanService.lecturePlanUpdate(paramMap);
		} else if("D".equals(action)) {
			sreturn = lecturePlanService.lecturePlanDelete(paramMap);
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
		
		logger.info("+ End " + className + ".lecturePlanSave");

		return returnmap;
	}	
	
	//주간계획 저장
	@RequestMapping("lecturePlanWeekPlanSave.do")
	@ResponseBody
	public Map<String, Object> lecturePlanWeekPlanSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	        HttpServletResponse response, HttpSession session,@RequestParam(value="week[]") List<String> week,@RequestParam(value="learn_plan[]") List<String> learn_plan,@RequestParam(value="learn_content[]") List<String> learn_content) throws Exception {
	        
	        logger.info("week:"+ week);
	        logger.info("learn_plan:"+ learn_plan);
	        logger.info("learn_content:"+ learn_content);

	        logger.info("+ Start " + className + ".lecturePlanWeekPlanSave");
	        logger.info("   - paramMap : " + paramMap);
	        
	        String resultMsg = "저장 되었습니다.";
	        String result = "SUCCESS";
	        
	        for (int i = 0; i < week.size(); i++) {
	        	 System.out.println("for문 들어오니::::");
	            paramMap.put("week",week.get(i));
	            paramMap.put("learn_plan",learn_plan.get(i));
	            paramMap.put("learn_content",learn_content.get(i));
	            
	            for(String weekcheck: week){
	            	System.out.println("weekc:::"+weekcheck);
	            }
	            
	            System.out.println("chekweek:::"+lecturePlanService.checkWeek(paramMap));
	            System.out.println("week::::"+paramMap.get("week"));
	            System.out.println("lec_no::::"+paramMap.get("lec_no"));
	            // 체크해서 값이 없으면 insert 있으면 수정
	            // if (lecturePlanService.checkWeek(paramMap) > 0) {
	            if (paramMap.get("action").equals("X") ) {
	            	
	            	System.out.println("weekupdate:::"+lecturePlanService.weekUpdate(paramMap));
	            	lecturePlanService.weekUpdate(paramMap);
	            
	            } else {
	            
	            	lecturePlanService.weekRegister(paramMap);
	            }

	        }
	        
	        Map<String, Object> resultMap = new HashMap<String, Object>();
	        resultMap.put("result", result);
	        resultMap.put("resultMsg", resultMsg);
	        
	        logger.info("+ End " + className + ".lecturePlanWeekPlanSave");
	        
	        return resultMap;
		}
	
	
		//주간 계획삭제
		@RequestMapping("lecturePlanWeekPlanDelete.do")
		@ResponseBody
		public Map<String, Object> lecturePlanWeekPlanDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".lecturePlanWeekPlanDelete");
			logger.info("   - paramMap : " + paramMap);

			String result = "SUCCESS";
			String resultMsg = "삭제 되었습니다.";
			
			// 상세코드 삭제
			lecturePlanService.weekDelete(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".lecturePlanWeekPlanDelete");
			
			return resultMap;
		}	
}