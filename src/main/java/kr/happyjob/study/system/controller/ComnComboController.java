package kr.happyjob.study.system.controller;

import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.system.service.ComnComboService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/system/")
public class ComnComboController {
	
	@Autowired
	ComnComboService comnComboService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 *  공통 콤보 
	 */
	@RequestMapping("selectComCombo.do")
	@ResponseBody
	public Map<String, Object> selectComCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectComCombo");
		logger.info("   - paramMap : " + paramMap);

		String ComType = (String) paramMap.get("comtype");
			
		List<comcombo> comComboModel = new ArrayList<>();
		
		logger.info("   - ComType : " + ComType);
		
		
		
		
		if("lecbyuser".equals(ComType)) {
			// 현재 로그인한 사용자가 강의하는 강의 
			paramMap.put("userno", session.getAttribute("user_no"));
			comComboModel = comnComboService.selectlecbyuserlist(paramMap);
		} else if("leclist".equals(ComType)) {
			// 강의 목록
			comComboModel = comnComboService.selectlecbyuserlist(paramMap);
		} else if("usr".equals(ComType)) {
			// usertype별 사용자 정보
			comComboModel = comnComboService.selectuserlist(paramMap);
		} else if("lusr".equals(ComType)) {
			// 강의 유무별  사용자(강사) 정보
			comComboModel = comnComboService.selectlecuserlist(paramMap);
		} else if("cls".equals(ComType)) {
			// 강의실 목록 
			comComboModel = comnComboService.selectclasslist(paramMap);
		} else if("lecyn".equals(ComType)) {
			// 현재 종료되지 않은 강의명
			comComboModel = comnComboService.selectlecynlist(paramMap);
		} else if("test".equals(ComType)) {
			// 테스트 목록  
			comComboModel = comnComboService.selecttestlist(paramMap);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);
		
		logger.info("+ End " + className + ".selectComCombo");
		
		return resultMap;
	}
	
	

}
