package kr.happyjob.study.adm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import kr.happyjob.study.adm.model.PfsLectureListVO;
import kr.happyjob.study.adm.model.ProfessorListVO;
import kr.happyjob.study.adm.service.SurveyService;

@Controller
@RequestMapping("/adm/")
public class SurveyController {
	
	@Autowired
	SurveyService surveyService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/** 설문조사 초기화면 */
	@RequestMapping("surveyControl.do")
	public String surveyControl(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".surveyControl");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".surveyControl");
		
		return "adm/surveyPage";
	}
	
	// 강사목록 불러오기
	@RequestMapping("professorList.do")
	public String professorList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".professorList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<ProfessorListVO> listData = surveyService.professorList(paramMap);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listcnt", listData.size());
		
		logger.info("+ End " + className + ".professorList");
		
		return "adm/surveyList";
	}
	
	// 강사별 강의목록 불러오기
	@RequestMapping("listPfsLecture.do")
	public String listPfsLecture(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listPfsLecture");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (currentPage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<PfsLectureListVO> listData = surveyService.pfsLectureList(paramMap);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listcnt", listData.size());
		
		logger.info("+ End " + className + ".listPfsLecture");
		
		return "adm/surveyPfsLecturePage";
	}

}







































