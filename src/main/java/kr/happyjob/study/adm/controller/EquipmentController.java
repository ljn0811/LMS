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
import kr.happyjob.study.adm.model.EquipmentVO;
import kr.happyjob.study.adm.service.EquipmentService;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Controller
@RequestMapping("/adm/")
public class EquipmentController {

	@Autowired
	EquipmentService equipmentService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("equipmentControl.do")
	public String classRoom(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".notice");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".notice");

		return "adm/equipment";
	}
	
	@RequestMapping("equipmentList.do")
	public String equipmentList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equipmentList");
		logger.info("	- paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;

		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<EquipmentVO> listData = equipmentService.equipmentList(paramMap);
		System.out.println("::::" + listData);
		int listCnt = equipmentService.equipmentCnt(paramMap);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);
				
		return "adm/equipmentList";
		
	}
	
	@ResponseBody
	@RequestMapping("equipmentDtlList.do")
	public Map<String, Object> equipmentDtlList(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listComnDtlCod");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.parseInt((String)paramMap.get("cpage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pagesize"));			// 페이지 사이즈
		int startpos = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("startpos", startpos);
		paramMap.put("pageSize", pageSize);
		
		// 공통 상세코드 목록 조회
		List<EquipmentVO> equipmentDtlModel = equipmentService.equipmentDtlList(paramMap);
//		model.addAttribute("equipmentDtlModel", equipmentDtlModel);
		System.out.println("모델:::" + equipmentDtlModel);
		
		// 공통 상세코드 목록 카운트 조회
		int totalCount = equipmentService.equipmentDtlCnt(paramMap);
//		model.addAttribute("totalCntEquiDtlCod", totalCount);
		System.out.println(totalCount);
		
//		model.addAttribute("pageSize", pageSize);
//		model.addAttribute("currentPageEquiDtlCod",currentPage);
		
		resultMap.put("equipmentDtlModel", equipmentDtlModel);
		resultMap.put("totalCntEquiDtl", totalCount);
		resultMap.put("pageSize", pageSize);
		resultMap.put("currentPageEquiDtlCod", currentPage);
		
		logger.info("+ End " + className + ".equipmentDtlCod");
		
		return resultMap;
		
	}
	
	@RequestMapping("equipmentSave.do")
	@ResponseBody
	public Map<String, Object> equipmentSave(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".classroomsave");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		String action = (String) paramMap.get("action");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";

		if ("I".equals(action)) {
			sreturn = equipmentService.equipmentSave(paramMap);
		} else if ("U".equals(action)) {
			sreturn = equipmentService.equipmentUpdate(paramMap);
		} else if ("D".equals(action)) {
			sreturn = equipmentService.equipmentDelete(paramMap);
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

		logger.info("+ End " + className + ".equipmentsave");

		return returnmap;
	}
	
	@RequestMapping("equipmentdtl.do")
	@ResponseBody
	public Map<String, Object> equipmentdtl(@RequestParam Map<String, Object> paramMap, Model model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".equipmentdtl");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		EquipmentVO selinfo = equipmentService.equipmentdtl(paramMap);
		returnmap.put("selinfo", selinfo);

		logger.info("+ End " + className + ".equipmentdtl");

		return returnmap;
	}
}
