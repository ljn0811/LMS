package kr.happyjob.study.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;
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
import org.springframework.beans.factory.annotation.Value;
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

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

@Controller
@RequestMapping("/notice/")
public class NoticeController {
	         
	@Autowired
	NoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String itemPath;
	
	@Value("${fontdir}")
	private String fontdir;
	
	@Value("${pdffont}")
	private String pdffont;
	
	@Value("${pdfcss}")
	private String pdfcss;
	
	
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
	
	@RequestMapping("noticepdfdownload.do")
	public void noticepdfdownload( @RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticepdfdownload");
		logger.info("   - paramMap : " + paramMap);
		
		String SRC = rootPath + File.separator + itemPath + File.separator + "Noticepdf.pdf";  //  
		String DESC = "noticedesc.pdf";
		
		paramMap.put("startpos", 0);
		paramMap.put("pagesize", noticeService.noticecnt(paramMap));
		
		List<Noticevo> listdata = noticeService.noticelist(paramMap);
		
		String cationhtml = "검색 조건    ";
		String innerhtml = "";
		
		if(!"".equals((String)paramMap.get("searchtitle")) 
		   || !"".equals((String)paramMap.get("searchstdate"))
		   || !"".equals((String)paramMap.get("searchtitle")) ) {
			
			if(!"".equals((String)paramMap.get("searchtitle"))) {
				cationhtml += " 제목 : ";
				cationhtml += (String)paramMap.get("searchtitle");
			} 
	        
			if(!"".equals((String)paramMap.get("searchstdate"))) {
				cationhtml += " 시작일자 : ";
				cationhtml += (String)paramMap.get("searchstdate");
			}
			
	        if(!"".equals((String)paramMap.get("searcheddate"))) {
				cationhtml += " 종료일자 : ";
				cationhtml += (String)paramMap.get("searcheddate");
			}
		} else {
			cationhtml += "없음";
		}
		
		for(Noticevo item : listdata) {
			String itemhtml = "<tr>";
			   
			itemhtml += "<td style='align: center'>";
			itemhtml += String.valueOf(item.getNotice_no());
			itemhtml += "</td>";	
			
			itemhtml += "<td>";
			itemhtml += item.getNotice_title();
			itemhtml += "</td>";	

			itemhtml += "<td>";
			itemhtml += item.getName();
			itemhtml += "</td>";	
			
			itemhtml += "<td>";
			itemhtml += item.getCreated_at();
			itemhtml += "</td>";				
			
			itemhtml += "<td>";
			itemhtml += String.valueOf(item.getNotice_views());
			itemhtml += "</td>";	
			
			itemhtml += "</tr>";  
			
			innerhtml += itemhtml;
		}
		
		
		Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정

		try {
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(SRC)); //현재상대경로에 pdf 생성
			writer.setInitialLeading(12.5f);
			
			document.open(); //생성된 파일을 오픈
			XMLWorkerHelper helper = XMLWorkerHelper.getInstance();

			// 사용할 CSS 를 준비한다.
			CSSResolver cssResolver = new StyleAttrCSSResolver();
			CssFile cssFile = null;
			try {
				cssFile = helper.getCSS(new FileInputStream(rootPath+ File.separator + fontdir + File.separator + pdfcss));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			
			// HTML 과 폰트준비
			XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
			fontProvider.register(rootPath + File.separator + fontdir + File.separator + pdffont,"MalgunGothic"); // MalgunGothic 은 alias,
			CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);

			HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
			htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

			// Pipelines
			PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
			// Html의pipeline을 생성 (html 태그, pdf의 pipeline설정)
			HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
			// css의pipeline을 합친다.
			CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
			//Work 생성 pipeline 연결
			XMLWorker worker = new XMLWorker(css, true);
			//Xml 파서 생성(Html를 pdf로 변환)
			XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));

			// 폰트 설정에서 별칭으로 줬던 "MalgunGothic"을 html 안에 폰트로 지정한다.
			String htmlStr = "<html>"  
					       + "<head></head>"  
					       + "<body style=\"font-family:MalgunGothic;\">"  
			               + "<div style='align: center'>"
					       + "<h1 style='text-align: center'>공지사항 관리</h1>"
					       + "<table border=1 class='col'>"
					       + "<caption>"
					       + cationhtml
					       + "</caption>"
				           + "<thead>"   
				           + "<tr>"
				           + "<th style='width: 10%;text-align: center'>글번호</th>"
				           + "<th style='width: 30%;text-align: center'>제목</th>"
				           + "<th style='width: 15%;text-align: center'>작성자</th>"
				           + "<th style='width: 15%;text-align: center'>등록일</th>"
				           + "<th style='width: 10%;text-align: center'>조회수</th>"
				           + "</tr>"
				           + "</thead>"
				           + "<tbody>"
				           + innerhtml
				           + "</tbody>"
				           + "</table>"
					       + "</div>"
			               + "</body></html>";
			

			
			//StringReader strReader = new StringReader(htmlStr);
			//xmlParser.parse(strReader);
			try (StringReader strReader = new StringReader(htmlStr)) {
				xmlParser.parse(strReader);
			}
			
			document.close();
			writer.close();
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
	        e.printStackTrace();
	    }
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(SRC));
		  
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode("Noticepdf.pdf","UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
	    response.getOutputStream().close();
	    
	    File makefile = new File(SRC);
	    makefile.delete();
	    
		
		logger.info("+ End " + className + ".noticepdfdownload");
		
		return;		

	}	
	
}
