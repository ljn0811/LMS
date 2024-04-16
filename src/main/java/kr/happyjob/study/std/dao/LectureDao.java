package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;
import kr.happyjob.study.std.model.LectureVO;

public interface LectureDao {

	/** 강의목록 조회 */
	public List<LectureVO> lectureList(Map<String, Object> paramMap) throws Exception;
	
	/** 카운트 조회 */
	public int lectureCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 강의상세 조회 */
	public LectureVO lectureDtl(Map<String, Object> paramMap);
	
	/** 수강신청 */
	public int lectureUpdate(Map<String, Object> paramMap);
	
	/** 수강신청 여부변경 */
	public int insertStudentInfo(Map<String, Object> paramMap);
	
	/** 신청취소 */
	public int lectureDelete(Map<String, Object> paramMap);

	/** 신청취소 여부변경 */
	public int deleteStudentInfo(Map<String, Object> paramMap);

	/** 신청인원 */
    public int getLecCnt(int lecNo);
    
    /** 최대인원 */
	public int getLecMaxCnt(int lecNo);
	
}
