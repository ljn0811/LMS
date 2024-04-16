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

import kr.happyjob.study.adm.model.TutorInfoVO;
import kr.happyjob.study.adm.service.TutorService;

@Controller
@RequestMapping("/adm/")
public class TutorController {

	@Autowired
	TutorService tutorService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("tutorControl.do")
	public String tutorControl(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".tutorControl");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".tutorControl");

		return "adm/tutorInfo";
	}
	
	@RequestMapping("tutorList.do")
	public String employmentList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".tutorList");
			logger.info("   - paramMap : " + paramMap);

			int cpage = Integer.valueOf((String) paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
			int startpos = (cpage - 1) * pagesize;

			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);			
			
			
			List<TutorInfoVO> listData = tutorService.tutorList(paramMap);
			int listCnt = tutorService.tutorCnt(paramMap);
			model.addAttribute("listData", listData);
			model.addAttribute("listCnt", listCnt);
			

			logger.info("+ End " + className + ".tutorList");

			return "adm/tutorList";
	}
	
	@RequestMapping("tutorModify.do")
	@ResponseBody
	public Map<String, Object> tutorModify(@RequestParam Map<String, Object> paramMap) throws Exception{
		logger.info("+ Start " + className + ".tutorModify");
		logger.info("   - paramMap : " + paramMap);		
		
		int result = 0;
		String resultMsg = "";
		String action = (String) paramMap.get("action");
		
		if("U".equals(action)){
			result = tutorService.tutorUpdate(paramMap);					
		}else if("D".equals(action)){
			result = tutorService.tutorDelete(paramMap);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(result >= 0){
			if("U".equals(action)){
				resultMsg = "승인  되었습니다.";
			}else if("D".equals(action)){
				resultMsg = "삭제  되었습니다.";
			}
		}else{
			if("U".equals(action)){
				resultMsg = "승인 실패했습니다.";
			}else if("D".equals(action)){
				resultMsg = "삭제 실패했습니다.";
			}
		}
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".tutorModify");
		return resultMap;
	}
		
}
