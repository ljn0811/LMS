package kr.happyjob.study.std.controller;

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
import kr.happyjob.study.std.service.LectureService;
import kr.happyjob.study.std.model.LectureVO;

@Controller
@RequestMapping("/std/")
public class LectureController {
	         
	@Autowired
	LectureService lectureService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**강의목록 초기화면*/
	@RequestMapping("lectureList.do")
	public String lectureList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureList");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".lectureList");

		return "std/lecture";
	}
	
	
	/**강의목록 */
	@RequestMapping("lecture.do")
	public String lecture( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecture");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		int userno = (int) session.getAttribute("user_no");
		
	    paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		paramMap.put("userno", userno);
	
		List<LectureVO> listdata = lectureService.lectureList(paramMap);
		int listcnt = lectureService.lectureCnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		
		logger.info("+ End " + className + ".lecture");

		return "std/lectureList";
	}
	
	
	/**강의상세목록 */
    @RequestMapping("lectureDtl.do")
	@ResponseBody
	public Map<String, Object> lectureDtl( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureDtl");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		LectureVO selinfo = lectureService.lectureDtl(paramMap);
		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".lectureDtl");

		return returnmap;
	}	
	
    
    /**수강신청 */
    @RequestMapping("lectureSave.do")
	@ResponseBody
	public Map<String, Object> lectureSave( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		paramMap.put("userno", userno);	
		
		
		if("U".equals(action)) {
			sreturn = lectureService.lectureUpdate(paramMap);
		} 
		
		if(sreturn >= 0) {
			int insertResult = lectureService.insertStudentInfo(paramMap);
		    
			if (insertResult >= 0) {
		        result = "S";        
		        resultmsg = "수강신청이 완료 되었습니다.";
		    } else {
		        result = "F";        
		        resultmsg = "수강신청에 실패하였습니다.";
		    }
		} else if(sreturn == -1){
			result = "E";
			resultmsg = "수강인원이 마감되었습니다.";
		}
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".lectureSave");

		return returnmap;
	}	
    
    
    /**신청취소 */
    @RequestMapping("lectureDelete.do")
	@ResponseBody
	public Map<String, Object> lectureDelete( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureDelete");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int lecno = Integer.valueOf((String)paramMap.get("lec_no"));
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		paramMap.put("userno", userno);	
		paramMap.put("lecno", lecno);
		
		if("D".equals(action)) {
			sreturn = lectureService.lectureDelete(paramMap);
		} 
		
		if(sreturn >= 0) {
			result = "S";	
		    int insertResult = lectureService.deleteStudentInfo(paramMap);
		    
		   
	        if (insertResult >= 0) {
	            result = "S";        
	            resultmsg = "신청이 취소 되었습니다.";
	        }
	        } else {
	            result = "F";        
		        resultmsg = "신청취소에 실패하였습니다.";
	        }
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".lectureDelete");

		return returnmap;
	}	
    
 }
