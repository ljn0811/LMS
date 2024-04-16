package kr.happyjob.study.tut.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.tut.dao.LearningMaterialsDao;
import kr.happyjob.study.tut.model.LearningMaterialsVO;
import kr.happyjob.study.tut.model.LecturePlanVO;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.notice.model.Noticevo;


@Service
public class LearningMaterialsServiceImpl implements LearningMaterialsService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LearningMaterialsDao learningMaterialsDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.tutPath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 목록 조회 */
	public List<LearningMaterialsVO> learningMaterialsList(Map<String, Object> paramMap) throws Exception {
		
		List<LearningMaterialsVO> listData = learningMaterialsDao.learningMaterialsList(paramMap);
		
		return listData;
	}
	
	/** 유저정보 단건조회 조회 */
	public LearningMaterialsVO learningMaterialsUserinfo(Map<String, Object> paramMap) throws Exception {
		
		LearningMaterialsVO listUserInfo = learningMaterialsDao.learningMaterialsUserinfo(paramMap);
		
		return listUserInfo;
	}
	
	/** 카운트 조회 */
	public int learningMaterialsCnt(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = learningMaterialsDao.learningMaterialsCnt(paramMap);
		
		return totalCount;
	}
	
	/** 상세 조회 */
	public LearningMaterialsVO learningMaterialsDetail(Map<String, Object> paramMap) throws Exception {
		
		return learningMaterialsDao.learningMaterialsDetail(paramMap);
	}
	
	
	/** 등록 파일 */
	public int learningMaterialsSaveFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		// 1. 업로드 된 파일 저장		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String itemFilePath = itemPath + File.separator;  
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileup.uploadFiles();

		// 2. 업로드 된 파일의 정보 (파일명, 논리경로, 물리경로, 사이즈, 확장자)  ===> DB 처리
		//map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("vrfile_loc", vrfile_loc);
        //map.put("fileExtension", fileExtension);
        //map.put("file_nm_uuid", file_nm_uuid);
		
		if(fileinfo.get("file_nm") == null) {
			paramMap.put("fileyn", "N");
			paramMap.put("fileinfo", null);
		} else {
			paramMap.put("fileyn", "Y");
			paramMap.put("fileinfo", fileinfo);
		}
		
		return learningMaterialsDao.learningMaterialsSaveFile(paramMap);
		
	}
	
	/** 수정 */
	public int learningMaterialsUpdateFile(Map<String, Object> paramMap, HttpServletRequest request)throws Exception {
		
		String checkval = (String) paramMap.get("fcheck");
		
		LearningMaterialsVO orginfo = learningMaterialsDao.learningMaterialsDetail(paramMap);
		if(orginfo.getFile_name() != null) {
			if(!"on".equals(checkval)) {
				File orgfile = new File(orginfo.getFile_path());
				orgfile.delete();
			}
		}
		
		// 1. 업로드 된 파일 저장		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
			
		String itemFilePath = itemPath + File.separator;  
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileup.uploadFiles();

		if(fileinfo.get("file_nm") == null) {
			paramMap.put("fileyn", "N");
			paramMap.put("fileinfo", null);
		} else {
			paramMap.put("fileyn", "Y");
			paramMap.put("fileinfo", fileinfo);
		}
	
		if("on".equals(checkval)) {
			paramMap.put("fileyn", "N");
				
			System.out.println(paramMap.get("fileyn"));
		} else {
			paramMap.put("fileyn", "Y");
		}
			
		return learningMaterialsDao.learningMaterialsUpdateFile(paramMap);		
			
	}
	
	/** 삭제 */
	public int learningMaterialsDeleteFile(Map<String, Object> paramMap) throws Exception {
		
		// 1. 현재 공지사항에 첨부 파일이 있으면 삭제
		LearningMaterialsVO orginfo = learningMaterialsDao.learningMaterialsDetail(paramMap);
		if(orginfo.getFile_name() != null) {
			File orgfile = new File(orginfo.getFile_path());
			orgfile.delete();
		}
		
		// 2. 테이블에서 삭제
		return learningMaterialsDao.learningMaterialsDeleteFile(paramMap);		
	}
}
