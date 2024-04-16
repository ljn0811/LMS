package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.SubmitReportVO;


public interface SubmitReportDao {
	/** 과제 리스트 조회하기 */
	public List<SubmitReportVO> selReportList(Map<String, Object> paramMap) throws Exception;
	/** 과제 리스트 카운트 */
	public int countReportList(Map<String, Object> paramMap) throws Exception;
	/** 과제 아이디로 가져오기  */
	public SubmitReportVO choiceReportList(Map<String, Object> paramMap) throws Exception;
	/** 과제 내용 등록 및 수정 */
	public void insertReport(Map<String, Object> paramMap) throws Exception;
	public void updateReport(Map<String, Object> paramMap) throws Exception;
	/** 과제 첨부파일 등록 및 수정 */
	public int updateReportSubFil(Map<String, Object>paramMap);
	/** 과제 삭제 목록 조회? */ 
	public SubmitReportVO deleteList(Map<String, Object>paramMap);
	/** 과제 파일update 확인 */
	public int deleteFileInfo(Map<String, Object>paramMap);
	/** 과제 삭제 */
	public int deleteHwkSub(Map<String, Object>paramMap);
	
}
