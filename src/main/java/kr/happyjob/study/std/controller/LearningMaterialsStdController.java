package kr.happyjob.study.std.controller;

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
import kr.happyjob.study.std.service.LearningMaterialsStdService;
import kr.happyjob.study.tut.model.ReportControlVO;
import kr.happyjob.study.std.model.LearningMaterialsStdVO;

@Controller
@RequestMapping("/std/")
public class LearningMaterialsStdController {
	         
	@Autowired
	LearningMaterialsStdService learningMaterialsStdService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**학습자료 초기화면*/
	@RequestMapping("learningMaterials.do")
	public String learningMaterials( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".learningMaterials");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".learningMaterials");

		return "std/learningMaterialsStd";
	}
	
	
	/**학습자료목록 */
	@RequestMapping("learningMaterialsList.do")
	public String learningMaterialsList( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".learningMaterialsList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		int userno = (int) session.getAttribute("user_no");
		
	    paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		paramMap.put("userno", userno);
	
		List<LearningMaterialsStdVO> listdata = learningMaterialsStdService.learningMaterialsList(paramMap);
		int listcnt = learningMaterialsStdService.learningMaterialsCnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		
		logger.info("+ End " + className + ".learningMaterialsList");

		return "std/learningMaterialsStdList";
	}
	
	/**학습자료상세목록 */
    @RequestMapping("learningMaterialsDtl.do")
	@ResponseBody
	public Map<String, Object> learningMaterialsDtl( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".learningMaterialsDtl");
		logger.info("   - paramMap : " + paramMap);
	
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		//조회수 증가
		learningMaterialsStdService.learningMaterialsViews(paramMap);
		
		LearningMaterialsStdVO selinfo = learningMaterialsStdService.learningMaterialsDtl(paramMap);
		model.addAttribute("selinfo", selinfo);
		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".learningMaterialsDtl");

		return returnmap;
	}	
	
    /**학습자료 다운로드 */
  	@RequestMapping("downloadStd.do")
  	public void downloadStd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
  		
  		logger.info("+ Start " + className + ".downloadStd");
		logger.info("   - paramMap : " + paramMap);
  		
  		String material_no = (String) paramMap.get("material_no");
  		paramMap.put("material_no", Integer.parseInt(material_no));		
  		
  		LearningMaterialsStdVO selectone = learningMaterialsStdService.learningMaterialsDtl(paramMap);
  		
  		System.out.println("material_no::::" + paramMap.get("material_no"));

  		//물리경로 조회해서 담기 
  		String file = selectone.getFile_path();
  		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
  		response.setContentType("application/octet-stream");
  		response.setContentLength(fileByte.length);
  		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectone.getFile_name(),"UTF-8")+"\";");//file대신에 파일이름칼럼넣어라
  		response.setHeader("Content-Transfer-Encoding", "binary");
  		response.getOutputStream().write(fileByte);
  		     
  		response.getOutputStream().flush();
  		response.getOutputStream().close();
//  		 OutputStream out = response.getOutputStream();
//  		    out.write(fileByte);
//  		    out.flush();
//  		    out.close(); // 닫은 후에 추가 작업을 수행하지 않도록 수정

  		logger.info("+ End " + className + ".downloadStd");

  		return;
  	}
	
	
    
 }
