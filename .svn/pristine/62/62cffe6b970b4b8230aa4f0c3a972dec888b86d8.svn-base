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
import kr.happyjob.study.std.service.PersonalInfoService;
import kr.happyjob.study.std.model.PersonalInfoVO;

@Controller
@RequestMapping("/std/")
public class PersonalInfoController {
	         
	@Autowired
	PersonalInfoService personalInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**개인정보 초기화면*/
	@RequestMapping("personalInfo.do")
	public String personalInfo( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".personalInfo");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".personalInfo");

		return "std/personalInfo";
	}
	
	/**개인정보 상세 */
    @RequestMapping("personalInfoDtl.do")
	@ResponseBody
	public Map<String, Object> personalInfoDtl( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".personalInfoDtl");
		logger.info("   - paramMap : " + paramMap);
		
		int userno = (int) session.getAttribute("user_no");
		paramMap.put("userno", userno);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		PersonalInfoVO selinfo = personalInfoService.personalInfoDtl(paramMap);
		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".personalInfoDtl");

		return returnmap;
	}	
	
    /**개인정보수정 */
    @RequestMapping("personalInfoUpdate.do")
	@ResponseBody
	public Map<String, Object> personalInfoUpdate( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".personalInfoUpdate");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		paramMap.put("userno", userno);	
		
		
		if("U".equals(action)) {
			sreturn = personalInfoService.personalInfoUpdate(paramMap);
			
			if (sreturn >= 0) {
		        result = "S";        
		        resultmsg = "수정이 완료되었습니다.";
		    } else {
		        result = "F";        
		        resultmsg = "수정이 실패하였습니다.";
		    }
		} 
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".personalInfoUpdate");

		return returnmap;
	}	
    
    /**비밀번호변경 */
    @RequestMapping("personalInfoUpdatePwd.do")
	@ResponseBody
	public Map<String, Object> personalInfoUpdatePwd( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".personalInfoUpdatePwd");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		paramMap.put("userno", userno);	
		
		
		if("U".equals(action)) {
			sreturn = personalInfoService.personalInfoUpdatePwd(paramMap);
			
			if (sreturn >= 0) {
		        result = "S";        
		        resultmsg = "변경이 완료되었습니다.";
		    } else {
		        result = "F";        
		        resultmsg = "변경에 실패하였습니다.";
		    }
		} 
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".personalInfoUpdatePwd");

		return returnmap;
	}	
   
    
    /**이메일 중복 체크 */
    @RequestMapping("checkEmail.do")
	@ResponseBody
	public Map<String, Object> checkEmail( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".checkEmail");
		logger.info("   - paramMap : " + paramMap);
		
		int userno = (int) session.getAttribute("user_no");
		paramMap.put("userno", userno);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int emailCnt = personalInfoService.checkEmail(paramMap);
		returnmap.put("emailCnt", emailCnt);
		
		logger.info("+ End " + className + ".checkEmail");

		return returnmap;
	}
    
    /**회원탈퇴 */
    @RequestMapping("deleteUser.do")
	@ResponseBody
	public Map<String, Object> deleteUser( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteUser");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		paramMap.put("userno", userno);	
		
		
		if("D".equals(action)) {
			sreturn = personalInfoService.deleteUser(paramMap);
			
			if (sreturn >= 0) {
		        result = "S";        
		        resultmsg = "탈퇴가 완료되었습니다.";
		    } else {
		        result = "F";        
		        resultmsg = "탈퇴에 실패하였습니다.";
		    }
		} 
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".deleteUser");

		return returnmap;
	}	
    
 }
