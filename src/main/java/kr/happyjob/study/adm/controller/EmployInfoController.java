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
import kr.happyjob.study.adm.model.EmployInfoVO;
import kr.happyjob.study.adm.service.EmploymentService;

@Controller
@RequestMapping("/adm/")
public class EmployInfoController {

	@Autowired
	EmploymentService employmentService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("employmentInfo.do")
	public String employmentInfo(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".employmentInfo");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".employmentInfo");

		return "adm/employInfo";
	}
	
		@RequestMapping("employmentList.do")
		public String employmentList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".searchEmployment");
			logger.info("   - paramMap : " + paramMap);

			int cpage = Integer.valueOf((String) paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
			int startpos = (cpage - 1) * pagesize;

			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);

			System.out.println("타나요?" + paramMap);
			List<EmployInfoVO> listData = employmentService.employmentList(paramMap);
			int listCnt = employmentService.employmentCnt(paramMap);

			model.addAttribute("listData", listData);
			model.addAttribute("listCnt", listCnt);

			logger.info("+ End " + className + ".classroomList");

			return "adm/employmentList";
		}
		
		@RequestMapping("lectureUserList.do")
		public String lectureUserList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".searchEmployment");
			logger.info("   - paramMap : " + paramMap);
			
			int cpage = Integer.valueOf((String) paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
			int startpos = (cpage - 1) * pagesize;
			
			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);
			
			List<EmployInfoVO> listData = employmentService.lectureUserList(paramMap);
			int listCntUser = employmentService.lectureUserCnt(paramMap);
			
			model.addAttribute("listData", listData);
			model.addAttribute("listCntUser", listCntUser);
			
			logger.info("+ End " + className + ".classroomList");
			
			return "adm/lectureUserList";
		}
		
		// 신규등록
		@RequestMapping("employInfoSave.do")
		@ResponseBody
		public Map<String, Object> employInfoSave(@RequestParam Map<String, Object> paramMap, Model model,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".employInfosave");
			logger.info("   - paramMap : " + paramMap);

			Map<String, Object> returnmap = new HashMap<String, Object>();

			String action = (String) paramMap.get("action");
			int sreturn = 0;
			String result = "";
			String resultmsg = "";

			if ("I".equals(action)) {
				sreturn = employmentService.employInfoSave(paramMap);
			} else if ("U".equals(action)) {
				sreturn = employmentService.employInfoUpdate(paramMap);
				System.out.println(sreturn);
			} else if ("D".equals(action)) {
				sreturn = employmentService.employInfoDelete(paramMap);
			}

			if (sreturn >= 0) {
				result = "S";
				if ("D".equals(action)) {
					resultmsg = "삭제 되었습니다.";
				} else {
					resultmsg = "저장 되었습니다.";
				}

			} else {
				result = "F";
				if ("D".equals(action)) {
					resultmsg = "삭제 실패 했습니다.";
				} else {
					resultmsg = "저장에 실패 했습니다.";
				}

			}

			returnmap.put("result", result);
			returnmap.put("resultmsg", resultmsg);

			logger.info("+ End " + className + ".employInfosave");

			return returnmap;
		}
		
		// 상세정보
		@RequestMapping("lectureUserdtl.do")
		@ResponseBody
		public Map<String, Object> lectureUserdtl(@RequestParam Map<String, Object> paramMap, Model model,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".lectureUserdtl");
			logger.info("   - paramMap : " + paramMap);

			Map<String, Object> returnmap = new HashMap<String, Object>();

			EmployInfoVO selinfo = employmentService.lectureUserdtl(paramMap);
			returnmap.put("selinfo", selinfo);

			logger.info("+ End " + className + ".lectureUserdtl");

			return returnmap;
		}
		
		@RequestMapping("employInfodtl.do")
		@ResponseBody
		public Map<String, Object> employInfodtl(@RequestParam Map<String, Object> paramMap, Model model,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".employInfodtl");
			logger.info("   - paramMap : " + paramMap);

			Map<String, Object> returnmap = new HashMap<String, Object>();

			EmployInfoVO selinfo = employmentService.employInfodtl(paramMap);
			returnmap.put("selinfo", selinfo);

			logger.info("+ End " + className + ".employInfodtl");

			return returnmap;
		}

		
	
}
