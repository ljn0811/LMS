package kr.happyjob.study.tut.controller;

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

import kr.happyjob.study.tut.model.LectureStudentVO;
import kr.happyjob.study.tut.service.LectureStudentService;

@Controller
@RequestMapping("/tut/")
public class LectureStudentController {   
   
	@Autowired
	LectureStudentService lectureStudentService;
	
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   /**
    * 수강생 관리 초기화면
    */
   @RequestMapping("lectureStudentInfo.do")
   public String lectureStudentInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".lectureStudentInfo");
      logger.info("   - paramMap : " + paramMap);
	
     
      logger.info("+ End " + className + ".lectureStudentInfo");

      return "tut/lectureStudent";
   } 
   
   @RequestMapping("lectureList.do")
   public String lectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".lectureList");
      logger.info("   - paramMap : " + paramMap);
      
      int cpage = Integer.valueOf((String)paramMap.get("cpage"));
      int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
	  int startpos = (cpage - 1) * pagesize;
	  
	  paramMap.put("startpos", startpos);
	  paramMap.put("pagesize", pagesize);
	  
	  List<LectureStudentVO> listData = lectureStudentService.lectureList(paramMap);
	  int listCnt = lectureStudentService.lectureCnt(paramMap);	
      
      model.addAttribute("listData", listData);
      model.addAttribute("listCnt", listCnt);
      
      logger.info("+ End " + className + ".lectureList");

      return "tut/lectureList";
   }
   
   @RequestMapping("lectureStudentList.do")
   public String lectureStudentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".studentList");
      logger.info("   - paramMap : " + paramMap);
      
      System.out.println(paramMap.toString());
      
     int cpage = Integer.valueOf((String)paramMap.get("cpage"));
      int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
	  int startpos = (cpage - 1) * pagesize;
	  
	  paramMap.put("startpos", startpos);
	  paramMap.put("pagesize", pagesize);
	  
	  List<LectureStudentVO> listData = lectureStudentService.lectureStudentList(paramMap);
	  int totalCount = lectureStudentService.lectureStudentCnt(paramMap);	
      
      model.addAttribute("listData", listData);
      model.addAttribute("totalCount", totalCount);
      
      logger.info("+ End " + className + ".studentList");

      return "tut/lectureStudentList";
   }
   
   @RequestMapping("updateApv.do")
   @ResponseBody
   public int updateApv(@RequestParam Map<String, Object> paramMap) throws Exception{
	   logger.info("+ Start " + className + ".studentList");
	   logger.info("   - paramMap : " + paramMap);
	   
	   int result = lectureStudentService.updateApv(paramMap);
	   
	   logger.info("+ End " + className + ".studentList");
	   return result;
   }
   
}