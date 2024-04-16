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

import kr.happyjob.study.adm.model.TestListPubModel;
import kr.happyjob.study.adm.model.TestPubModel;
import kr.happyjob.study.adm.model.TestQueModel;
import kr.happyjob.study.adm.service.TestPubService;
import kr.happyjob.study.notice.model.Noticevo;

@Controller
@RequestMapping("/adm/")
public class TestPubController {

	@Autowired
	TestPubService testPubService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 시험 문제 관리 초기화면
	 */
	@RequestMapping("testPub.do")
	public String initTestPub(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initTestPub");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".initTestPub");

		return "adm/testPub";
	}

	/**
	 * 시험 문제 관리 목록 조회
	 */
	@RequestMapping("listTestPub.do")
	public String listTestPub(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listTestPub");
		logger.info("   - paramMap : " + paramMap);

		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;

		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);

		List<TestPubModel> listdata = testPubService.listTestPub(paramMap);
		int listcnt = testPubService.countListTestPub(paramMap);

		model.addAttribute("listdata", listdata);
		model.addAttribute("listcnt", listcnt);

		logger.info("+ End " + className + ".listTestPub");

		return "adm/testPubList";
	}

	/**
	 * 시험 목록 조회
	 */
	@RequestMapping("testListPub.do")
	public String testListPub(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".testListPub");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		List<TestListPubModel> testListPub = testPubService.testListPub(paramMap);
		model.addAttribute("testListPub", testListPub);

		int totalCount = testPubService.countTestListPub(paramMap);
		model.addAttribute("totalTestListPub", totalCount);

		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageTestListPub", currentPage);

		logger.info("+ End " + className + ".listTestPub");
		return "adm/testListPub";
	}

	/** 시험 상세 조회 */
	@RequestMapping("testListPubDtl.do")
	@ResponseBody
	public Map<String, Object> testListPubDtl(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".testListPubDtl");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		TestListPubModel selinfo = testPubService.testListPubDtl(paramMap);
		returnmap.put("selinfo", selinfo);

		logger.info("+ End " + className + ".testListPubDtl");

		return returnmap;
	}

	@RequestMapping("testListPubSave.do")
	@ResponseBody
	public Map<String, Object> testListPubSave(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".testListPubSave");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";

		paramMap.put("userno", userno);

		if ("I".equals(action)) {
			sreturn = testPubService.testListPubSave(paramMap);
		} else if ("U".equals(action)) {
			sreturn = testPubService.testListPubUpdate(paramMap);
		} else if ("D".equals(action)) {
			sreturn = testPubService.testListPUbDelete(paramMap);
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

		logger.info("+ End " + className + ".testListPubSave");

		return returnmap;
	}

	@RequestMapping("testQueSave.do")
	@ResponseBody
	public Map<String, Object> testQueSave(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".testQueSave");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";

		paramMap.put("userno", userno);

		if ("I".equals(action)) {
			sreturn = testPubService.testQueSave(paramMap);
		} else if ("U".equals(action)) {
			sreturn = testPubService.testQueUpdate(paramMap);
		} else if ("D".equals(action)) {
			sreturn = testPubService.testQueDelete(paramMap);
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

		logger.info("+ End " + className + ".testQueSave");

		return returnmap;
	}

	/**
	 * 시험 문제 관리 목록 조회
	 */
	@RequestMapping("listTestQue.do")
	public String listTestQue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listTestQue");
		logger.info("   - paramMap : " + paramMap);

		List<TestQueModel> listdata = testPubService.listTestQue(paramMap);

		model.addAttribute("listdata", listdata);

		logger.info("+ End " + className + ".listTestQue");

		return "adm/testQueList";
	}

	/** 시험 상세 조회 */
	@RequestMapping("testQueDtl.do")
	@ResponseBody
	public Map<String, Object> testQueDtl(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".testQueDtl");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		TestQueModel selinfo = testPubService.testQueDtl(paramMap);
		returnmap.put("selinfo", selinfo);

		logger.info("+ End " + className + ".testQueDtl");

		return returnmap;
	}
}
