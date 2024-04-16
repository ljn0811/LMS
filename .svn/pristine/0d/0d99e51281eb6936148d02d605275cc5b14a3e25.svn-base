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

import kr.happyjob.study.adm.model.StudentVO;
import kr.happyjob.study.adm.service.StudentService;
import kr.happyjob.study.std.model.LectureVO;
import kr.happyjob.study.system.model.ComnGrpCodModel;


@Controller
@RequestMapping("/adm/")
public class StudentController {
	         
	@Autowired
	StudentService studentService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**학생관리 초기화면*/
	@RequestMapping("studentControl.do")
	public String studentControl(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentControl");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".studentControl");

		return "adm/studentControl";
	}
	
	/**강의목록 */
	@RequestMapping("studentLectureList.do")
	public String studentLectureList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pageSize"));
		int startpos = (cpage - 1) * pagesize;
		int userno = (int) session.getAttribute("user_no");
		
	    paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		paramMap.put("userno", userno);
	
		List<StudentVO> listdata = studentService.studentLectureList(paramMap);
		int listcnt = studentService.studentLectureListCnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		
		logger.info("+ End " + className + ".studentLectureList");

		return "adm/studentLectureList";
	}
	
	/**학생목록 */
	@RequestMapping("studentList.do")
	public String studentList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pageSize"));
		int startpos = (cpage - 1) * pagesize;
		int userno = (int) session.getAttribute("user_no");
		
	    paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		paramMap.put("userno", userno);
	
		List<StudentVO> listdata = studentService.studentList(paramMap);
		int listcnt = studentService.studentListCnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		
		logger.info("+ End " + className + ".studentList");

		return "adm/studentList";
	}
	
	/**학생정보 단건조회 */
	@RequestMapping("selectStudent.do")
	@ResponseBody
	public Map<String, Object> selectStudent (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectStudent");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		
		StudentVO selectData = studentService.selectStudent(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("selectData", selectData);
		
		logger.info("+ End " + className + ".selectStudent");
		
		return resultMap;
	}
	
	/**수강내역 */
	@RequestMapping("selectLectureList.do")
	public String selectLectureList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int userno = (int) session.getAttribute("user_no");
		paramMap.put("userno", userno);
	
		List<StudentVO> listdata = studentService.selectLectureList(paramMap);
		int listcnt = studentService.selectLectureListCnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		
		logger.info("+ End " + className + ".selectLectureList");

		return "adm/selectLectureList";
	}
	
	/**미수강내역 */
	@RequestMapping("notLectureList.do")
	@ResponseBody
	public Map<String, Object> notLectureList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".notLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int userno = (int) session.getAttribute("user_no");
		paramMap.put("userno", userno);
	
		List<StudentVO> listdata = studentService.notLectureList(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("listdata", listdata);
		
		
		logger.info("+ End " + className + ".notLectureList");

		return resultMap;
	}
	
	/**수강등록 */
    @RequestMapping("adminLectureSave.do")
	@ResponseBody
	public Map<String, Object> adminLectureSave( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".adminLectureSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = Integer.valueOf((String)paramMap.get("user_no"));
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		paramMap.put("userno", userno);
		
        if("U".equals(action)) {
			sreturn = studentService.adminLectureUpdate(paramMap);
		} 
		
		if(sreturn >= 0) {
			int insertResult = studentService.adminLinsertStudentInfo(paramMap);
		    
			if (insertResult >= 0) {
		        result = "S";        
		        resultmsg = "수강등록이 완료 되었습니다.";
		    } else {
		        result = "F";        
		        resultmsg = "수강등록에 실패하였습니다.";
		    }
		} else if(sreturn == -1){
			result = "E";
			resultmsg = "수강인원이 마감되었습니다.";
		}
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".adminLectureSave");

		return returnmap;
	}	
}
