package kr.happyjob.study.notice.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import kr.happyjob.study.common.comnUtils.ComnUtil;
import kr.happyjob.study.common.comnUtils.ExcelDownloadParam;
import kr.happyjob.study.common.comnUtils.ExcelDownloadView;
import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.notice.service.NoticeService;

@Controller
@RequestMapping("/notice/")
public class NoticeController {
	         
	@Autowired
	NoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 공지사항 초기화면
	 */
	@RequestMapping("notice.do")
	public String notice( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".notice");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".notice");

		return "notice/notice";
	}
	 
	@RequestMapping("noticelist.do")
	public String noticelist( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticelist");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String)paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String)paramMap.get("pagesize"));
		int startpos = (cpage - 1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<Noticevo> listdata = noticeService.noticelist(paramMap);
		int listcnt = noticeService.noticecnt(paramMap);
		
		model.addAttribute("listdata",listdata);
		model.addAttribute("listcnt",listcnt);
		model.addAttribute("gridtype", paramMap.get("usertype"));
		
		
		logger.info("+ End " + className + ".noticelist");

		return "notice/noticelist";
	}	
	
	@RequestMapping("noticesave.do")
	@ResponseBody
	public Map<String, Object> noticesave( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		
		paramMap.put("userno", userno);		
		
		if("I".equals(action)) {						
			sreturn = noticeService.noticesave(paramMap);
		} else if("U".equals(action)) {
			sreturn = noticeService.noticeupdate(paramMap);
		} else if("D".equals(action)) {
			sreturn = noticeService.noticedelete(paramMap);
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
		
		logger.info("+ End " + className + ".noticesave");

		return returnmap;
	}	
	
	@RequestMapping("noticedtl.do")
	@ResponseBody
	public Map<String, Object> noticedtl( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticedtl");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		noticeService.noticeviewsupdate(paramMap);
		
		Noticevo selinfo = noticeService.noticedtl(paramMap);
		returnmap.put("selinfo", selinfo);
		
		
		
		logger.info("+ End " + className + ".noticedtl");

		return returnmap;
	}	
	
	@RequestMapping("noticesavefile.do")
	@ResponseBody
	public Map<String, Object> noticesavefile( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesavefile");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = (String) paramMap.get("action");
		int userno = (int) session.getAttribute("user_no");
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		
		
		paramMap.put("userno", userno);		
		
		if("I".equals(action)) {						
			sreturn = noticeService.noticeinsertfile(paramMap, request);
		} else if("U".equals(action)) {
			sreturn = noticeService.noticeupdatefile(paramMap, request);
		} else if("D".equals(action)) {
			sreturn = noticeService.noticedeletefile(paramMap);
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
		
		logger.info("+ End " + className + ".noticesavefile");

		return returnmap;
	}		

	@RequestMapping("noticedownload.do")
	public void noticedownload( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticedownload");
		logger.info("   - paramMap : " + paramMap);		
		
		Noticevo selectone = noticeService.noticedtl(paramMap);
		
		//물리경로 조회해서 담기 
		String file = selectone.getPhsycalpath();
		  
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		  
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectone.getFilename(),"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
	    response.getOutputStream().close();
	
		logger.info("+ End " + className + ".noticedownload");
		
		return;		

	}	
	
	@RequestMapping("/noticeexceldownload.do")
	public View responseStatExcel(ModelMap excelParams, @RequestParam Map<String, Object> paramMap) throws Exception {
		
			
		paramMap.put("startpos", 0);
		paramMap.put("pagesize", noticeService.noticecnt(paramMap));
		
		List<Noticevo> listdata = noticeService.noticelist(paramMap);
		
		makenoticeexcel(excelParams, paramMap, listdata);
			
		return new ExcelDownloadView();
	}	
	
	private void makenoticeexcel(ModelMap excelParams, Map<String, Object> paramMap, List<Noticevo> resultList) {
		
		List<HashMap<String, Object>> results = new ArrayList<HashMap<String, Object>>();
		
		for(Noticevo each : resultList){
			HashMap<String, Object> result = new HashMap<String, Object>();
			if(each !=null ){				
				result.put("noticeno",each.getNotice_no());
				result.put("userno",ComnUtil.NVL(each.getUser_no()));
				result.put("noticetitle",ComnUtil.NVL(each.getNotice_title()));
				result.put("createdat",ComnUtil.NVL(each.getCreated_at()));     
				result.put("noticeviews",each.getNotice_views());
				result.put("name",ComnUtil.NVL(each.getName()));						
			}
			
			results.add(result);
		}
		
		ExcelDownloadParam param = new ExcelDownloadParam()
				.setExcelParams(excelParams)
				.setList(results)
				.setFilePrefix("notice")
				.setTitle("공지사항 목록")
				.setDate((String)paramMap.get("searchstdate"), (String)paramMap.get("searcheddate"))
				.setNames("번호","사용자번호","제목","작성일","조회수","작성자")
				.setCols("noticeno","userno","noticetitle","createdat","noticeviews","name"); 
		
		ExcelDownloadView.template(param);
	}	
}
