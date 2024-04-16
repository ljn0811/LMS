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
import kr.happyjob.study.adm.service.ClassroomService;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Controller
@RequestMapping("/adm/")
public class ClassroomController {

	@Autowired
	ClassroomService classroomService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 강의실관리 초기화면
	 */
	@RequestMapping("classroom.do")
	public String classRoom(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".notice");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".notice");

		return "adm/classroom";
	}

	// 강의실관리 목록 불러오기
	@RequestMapping("classroomList.do")
	public String classroomList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".classroomList");
		logger.info("   - paramMap : " + paramMap);

		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;

		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);

		System.out.println("타나요?" + paramMap);
		List<ClassroomVO> listData = classroomService.classroomList(paramMap);
		int listCnt = classroomService.classroomCnt(paramMap);

		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);

		logger.info("+ End " + className + ".classroomList");

		return "adm/classroomList";
	}

	// 신규등록
	@RequestMapping("classroomSave.do")
	@ResponseBody
	public Map<String, Object> classroomSave(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".classroomsave");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		String action = (String) paramMap.get("action");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		System.out.println("저장저장저장" + paramMap.get("classroom_no"));

		if ("I".equals(action)) {
			sreturn = classroomService.classroomSave(paramMap);
		} else if ("U".equals(action)) {
			sreturn = classroomService.classroomUpdate(paramMap);
		} else if ("D".equals(action)) {
			classroomService.lectureClassroomNoNull(paramMap);
			sreturn = classroomService.classroomDelete(paramMap);
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

		logger.info("+ End " + className + ".classroomsave");

		return returnmap;
	}

	// 상세정보
	@RequestMapping("classroomdtl.do")
	@ResponseBody
	public Map<String, Object> classroomdtl(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".classroomdtl");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		ClassroomVO selinfo = classroomService.classroomdtl(paramMap);
		returnmap.put("selinfo", selinfo);

		logger.info("+ End " + className + ".classroomdtl");

		return returnmap;
	}

	@RequestMapping("listClsEquip.do")
	public String listClsEquip(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listComnDtlCod");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
																					// 페이지
																					// 번호
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize; // 페이지 시작 row 번호

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 공통 상세코드 목록 조회
		List<ClassroomVO> listClassroomEquipment = classroomService.listClassroomEquipment(paramMap);
		model.addAttribute("listClassroomEquipment", listClassroomEquipment);

		// 공통 상세코드 목록 카운트 조회
		int totalCount = classroomService.equipmentCnt(paramMap);
		model.addAttribute("totalCntClsEquip", totalCount);

		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageClsEquip", currentPage);

		logger.info("+ End " + className + ".listComnDtlCod");

		return "/adm/classroomEquipmentList";
	}

}
