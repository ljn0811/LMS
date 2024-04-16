package kr.happyjob.study.tut.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.tut.model.LearningMaterialsVO;
import kr.happyjob.study.tut.service.LearningMaterialsService;

@Controller
@RequestMapping("/tut/")
public class LearningMaterialsController {
	         
		@Autowired
		LearningMaterialsService learningMaterialsService;
		
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		
		/**
		 * 공지사항 초기화면
		 */
		@RequestMapping("learningMaterials.do")
		public String learningMaterials( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".learningMaterials");
			logger.info("   - paramMap : " + paramMap);

			
			int userno = (int) session.getAttribute("user_no");
		    paramMap.put("user_no", userno);
			LearningMaterialsVO learningMaterialsUserinfo = learningMaterialsService.learningMaterialsUserinfo(paramMap);
			
			model.addAttribute("learningMaterialsUserinfo",learningMaterialsUserinfo);
			
			logger.info("+ End " + className + ".learningMaterials");

			return "tut/learningMaterials";
		}
		
		@RequestMapping("learningMaterialsList.do")
		public String learningMaterialsList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".learningMaterialsList");
			logger.info("   - paramMap : " + paramMap);
			
			int cpage = Integer.valueOf((String)paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
			int startpos = (cpage - 1) * pagesize;
			
			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);
			
			List<LearningMaterialsVO> listData = learningMaterialsService.learningMaterialsList(paramMap);
			int listCnt = learningMaterialsService.learningMaterialsCnt(paramMap);
			
			model.addAttribute("listData",listData);
			model.addAttribute("listCnt",listCnt);
//			model.addAttribute("gridtype", paramMap.get("usertype"));
			
			
			logger.info("+ End " + className + ".learningMaterialsList");

			return "tut/learningMaterialsList";
		}	

		@RequestMapping("learningMaterialsDetail.do")
		@ResponseBody
		public Map<String, Object> learningMaterialsDetail( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".learningMaterialsDetail");
			logger.info("   - paramMap : " + paramMap);
			System.out.println("checkParam::::"+ paramMap.get("material_no"));
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			LearningMaterialsVO selinfo = learningMaterialsService.learningMaterialsDetail(paramMap);
			returnmap.put("selinfo", selinfo);
			
			logger.info("+ End " + className + ".learningMaterialsDetail");

			return returnmap;
		}	
				
		@RequestMapping("learningMaterialsSaveFile.do")
		@ResponseBody
		public Map<String, Object> learningMaterialsSaveFile( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".learningMaterialsSaveFile");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			String action = (String) paramMap.get("action");
			int userno = (int) session.getAttribute("user_no");
			int sreturn = 0;
			String result = "";
			String resultmsg = "";
			
			
			paramMap.put("user_no", userno);		
//			
//			for( String test : paramMap.keySet()){
//				System.out.println("test:::"+ test);
//			}
//			for( Object value : paramMap.values()){
//				System.out.println("value:::"+ value);
//			}
			
			if("I".equals(action)) {						
				sreturn = learningMaterialsService.learningMaterialsSaveFile(paramMap, request);
			} else if("U".equals(action)) {
				sreturn = learningMaterialsService.learningMaterialsUpdateFile(paramMap, request);
			} else if("D".equals(action)) {
				sreturn = learningMaterialsService.learningMaterialsDeleteFile(paramMap);
			}
			
			if(sreturn >= 0) {
				result = "S";			
				if("D".equals(action)) {
					resultmsg = "삭제 되었습니다.";
				} else {
					resultmsg = "저장 되었습니다.";
				}
				
			} else {
				result = "F";			
				if("D".equals(action)) {
					resultmsg = "삭제 실패 했습니다.";
				} else {
					resultmsg = "저장에 실패 했습니다.";
				}
				
			}
			
			returnmap.put("result",result);
			returnmap.put("resultmsg",resultmsg);
			
			logger.info("+ End " + className + ".learningMaterialsSaveFile");

			return returnmap;
		}		
		
		@RequestMapping("learningMaterialsDownload.do")
		public void learningMaterialsDownload( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".learningMaterialsDownload");
			logger.info("   - paramMap : " + paramMap);		
			
			LearningMaterialsVO selectone = learningMaterialsService.learningMaterialsDetail(paramMap);
			
			//물리경로 조회해서 담기 
			String file = selectone.getFile_path();
			  
			byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
			  
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectone.getFile_name(),"UTF-8")+"\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte); 
			response.getOutputStream().flush();
		    response.getOutputStream().close();
		
			logger.info("+ End " + className + ".learningMaterialsDownload");
			
			return;		

		}	
}
