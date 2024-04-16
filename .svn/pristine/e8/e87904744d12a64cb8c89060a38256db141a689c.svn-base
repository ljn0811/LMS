package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.StudentVO;
import kr.happyjob.study.std.model.LectureVO;

public interface StudentService {

	/**강의목록 */
	public List<StudentVO> studentLectureList(Map<String, Object> paramMap);

	/**강의목록 카운트*/
	public int studentLectureListCnt(Map<String, Object> paramMap);

	/**학생목록*/
	public List<StudentVO> studentList(Map<String, Object> paramMap);
	
	/**학생목록 카운트*/
	public int studentListCnt(Map<String, Object> paramMap);

	/**학생정보 단건조회*/
	public StudentVO selectStudent(Map<String, Object> paramMap);

	/**수강내역*/
	public List<StudentVO> selectLectureList(Map<String, Object> paramMap);
	
	/**수강내역 카운트*/
	public int selectLectureListCnt(Map<String, Object> paramMap);
	
	/**미수강내역*/
	public List<StudentVO> notLectureList(Map<String, Object> paramMap);

	/**관리자수강등록*/
	public int adminLectureUpdate(Map<String, Object> paramMap);

	/**관리자수강등록 여부변경*/
	public int adminLinsertStudentInfo(Map<String, Object> paramMap);

	

	
}
