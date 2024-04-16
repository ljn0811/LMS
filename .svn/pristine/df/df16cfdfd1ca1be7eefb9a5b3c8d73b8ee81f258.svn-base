package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import kr.happyjob.study.adm.dao.StudentDao;
import kr.happyjob.study.adm.model.StudentVO;


@Service
public class StudentServiceImpl implements StudentService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StudentDao studentDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	/**강의목록 */
	public List<StudentVO> studentLectureList(Map<String, Object> paramMap){
		List<StudentVO> studentLectureList = studentDao.studentLectureList(paramMap);
		return studentLectureList;
	}

	/**강의목록 카운트*/
	public int studentLectureListCnt(Map<String, Object> paramMap){
		int totalCnt = studentDao.studentLectureListCnt(paramMap);
		return totalCnt;
	}
	
	/**학생목록 */
	public List<StudentVO> studentList(Map<String, Object> paramMap){
		List<StudentVO> studentList = studentDao.studentList(paramMap);
		return studentList;
	}

	/**학생목록 카운트*/
	public int studentListCnt(Map<String, Object> paramMap){
		int totalCnt = studentDao.studentListCnt(paramMap);
		return totalCnt;
	}
	
	/**학생정보 단건조회*/
	public StudentVO selectStudent(Map<String, Object> paramMap){
		StudentVO selectStudent = studentDao.selectStudent(paramMap);
		return selectStudent;
	}
	
	/**수강내역*/
	public List<StudentVO> selectLectureList(Map<String, Object> paramMap){
		List<StudentVO> selectLectureList = studentDao.selectLectureList(paramMap);
		return selectLectureList;
	}
	
	/**수강내역 카운트*/
	public int selectLectureListCnt(Map<String, Object> paramMap){
		int selectLectureListCnt = studentDao.selectLectureListCnt(paramMap);
		return selectLectureListCnt;
	}
	
	/**미수강내역*/
	public List<StudentVO> notLectureList(Map<String, Object> paramMap){
		List<StudentVO> notLectureList = studentDao.notLectureList(paramMap);
		return notLectureList;
	}
	
	/**관리자수강등록*/
	public int adminLectureUpdate(Map<String, Object> paramMap){
		
		int lecno = Integer.valueOf((String)paramMap.get("lec_no"));
	    int lecCnt = studentDao.getAdminLecCnt(lecno);
	    int lecMaxCnt = studentDao.getAdminLecMaxCnt(lecno);

	    if (lecCnt == lecMaxCnt) {
	        return -1; // 수강인원 마감
	    } else {
	    	studentDao.adminLectureUpdate(paramMap);
	        return 1; // 수강신청 완료
	    }
	}

	/**관리자수강등록 여부변경*/
	public int adminLinsertStudentInfo(Map<String, Object> paramMap){
		return studentDao.adminLinsertStudentInfo(paramMap);
	}

}
