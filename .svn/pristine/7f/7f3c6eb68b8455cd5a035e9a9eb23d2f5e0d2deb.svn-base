package kr.happyjob.study.qanda.controller;

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

import kr.happyjob.study.qanda.model.QandaVO;
import kr.happyjob.study.qanda.model.QnaCommentVO;
import kr.happyjob.study.qanda.service.QandaService;

@Controller
@RequestMapping("/qanda/")
public class QandaBController {
	         
	@Autowired
	QandaService qnaService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * QnA 초기화면
	 */
	@RequestMapping("qandaB.do")
	public String notice( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qandaB");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".qandaB");

		return "/qanda/qandaB";
	}
	
	/**
	 * QnA 리스트
	 */
	@RequestMapping("qandaListB.do")
	public String qandaList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qandaListB");
		logger.info("   - paramMap : " + paramMap);
		
		int cPage = Integer.valueOf((String)paramMap.get("cPage"));
		int pageSize = Integer.valueOf((String)paramMap.get("pageSize"));
		int startPos = (cPage - 1) * pageSize;
		
		paramMap.put("startPos", startPos);
		paramMap.put("pageSize", pageSize);
		
		List<QandaVO> listdata = qnaService.qandaList(paramMap);
		int listcnt = qnaService.qandaCnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		
		logger.info("+ End " + className + ".qandaListB");

		return "qanda/qandaListB";
	}	
	
	/**
	 * Q&A 작성
	 */
	@RequestMapping("qnaSaveB.do")
	@ResponseBody
	public Map<String, Object> qnaSave(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaSaveB");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int sReturn = 0;
		String result = "";
		String resultMsg = "";	
		
		if("I".equals(action)) {
			//저장
			sReturn = qnaService.qnaSave(paramMap);
		} else if("U".equals(action)) {
			//수정
			sReturn = qnaService.qnaUpdate(paramMap);
		} else if("D".equals(action)) {
			//댓글 삭제
			int commentDelete = qnaService.commentDeleteOne(paramMap);
			//글 삭제
			sReturn = qnaService.qnaDelete(paramMap);
		}
		
		if(sReturn >= 0) {
			result = "S";			
			if("D".equals(action)) {
				resultMsg = "삭제 되었습니다.";
			} else {
				resultMsg = "저장 되었습니다.";
			}
			
		} else {
			result = "F";			
			if("D".equals(action)) {
				resultMsg = "삭제 실패 했습니다.";
			} else {
				resultMsg = "저장에 실패 했습니다.";
			}			
		}
		
		returnMap.put("result",result);
		returnMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".qnaSaveB");

		return returnMap;
	}	
	
	/**
	 * Q&A 상세조회
	 */
	@RequestMapping("qnaDtlB.do")
	@ResponseBody
	public Map<String, Object> qnaDtl( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaDtlB");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		
		//상세 조회
		QandaVO qnaInfo = qnaService.qnaDtl(paramMap);
		
		//댓글 목록
		List<QnaCommentVO> commentList = qnaService.commentList(paramMap);
		
		returnMap.put("qnaInfo", qnaInfo);
		returnMap.put("commentList", commentList);
		
		logger.info("+ End " + className + ".qnaDtlB");

		return returnMap;
	}
	
	@RequestMapping("qnaCommentSaveB.do")
	@ResponseBody
	public Map<String, Object> qnaCommentSave(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".qnaCommentSaveB");
		logger.info("   - paramMap : " + paramMap);
		
		int result = qnaService.qnaCommentSave(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String resultMsg = "";
		
		if(result >= 0){
			resultMsg = "댓글이 등록되었습니다.";
		}
		
		resultMap.put("resultMsg", resultMsg);		
		
		logger.info("+ End " + className + ".qnaCommentSaveB");
		
		return resultMap;
	}
	
	@RequestMapping("commentDeleteB.do")
	@ResponseBody
	public Map<String, Object> commentDelete(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("+ Start " + className + ".commentDeleteB");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = qnaService.commentDeleteOne(paramMap);
		
		String resultMsg = "";
		
		if(result >= 0){
			resultMsg = "댓글이 삭제되었습니다.";
		}
		
		resultMap.put("resultMsg", resultMsg);		
		
		logger.info("+ End " + className + ".commentDeleteB");
		
		return resultMap;
	}
	
}
