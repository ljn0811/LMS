package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import kr.happyjob.study.std.dao.LectureDao;
import kr.happyjob.study.std.model.LectureVO;

@Service
public class LectureServiceImpl implements LectureService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LectureDao lectureDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 강의목록 조회 */
	public List<LectureVO> lectureList(Map<String, Object> paramMap) throws Exception {
		
		List<LectureVO> lectureList = lectureDao.lectureList(paramMap);
		
		return lectureList;
	}
	
	/** 카운트 조회 */
	public int lectureCnt(Map<String, Object> paramMap) throws Exception {
		
		int lectureCnt = lectureDao.lectureCnt(paramMap);
		
		return lectureCnt;
	}
	
	/** 강의상세 조회 */
	public LectureVO lectureDtl(Map<String, Object> paramMap){
		return lectureDao.lectureDtl(paramMap);
	}
	
	/** 수강신청 */
	public int lectureUpdate(Map<String, Object> paramMap){
        
		int lecno = Integer.valueOf((String)paramMap.get("lec_no"));
	    int lecCnt = lectureDao.getLecCnt(lecno);
	    int lecMaxCnt = lectureDao.getLecMaxCnt(lecno);

	    if (lecCnt == lecMaxCnt) {
	        return -1; // 수강인원 마감
	    } else {
	    	lectureDao.lectureUpdate(paramMap);
	        return 1; // 수강신청 완료
	    }
    }
	
	
	/** 수강신청 여부변경 */
	public int insertStudentInfo(Map<String, Object> paramMap){
		return lectureDao.insertStudentInfo(paramMap);
		
	}
	
	/** 신청취소 */
	public int lectureDelete(Map<String, Object> paramMap){
        
		int lectureDelete = lectureDao.lectureDelete(paramMap);
		
		return lectureDelete;
	}
	
	/** 신청취소 여부변경 */
	public int deleteStudentInfo(Map<String, Object> paramMap){
		return lectureDao.deleteStudentInfo(paramMap);
		
	}
}
