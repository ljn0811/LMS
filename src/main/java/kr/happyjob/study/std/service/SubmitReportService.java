package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.std.model.SubmitReportVO;


public interface SubmitReportService {
	
	/** 과제 리스트 조회 */
	public List<SubmitReportVO> selReportList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제리스트 카운트 조회 */
	public int countReportList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제리스트 아이디로 상세 조회 (모달)*/
	public SubmitReportVO choiceReportList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제아이디로 insert (모달)*/
	public int insertReport(Map<String, Object> paramMap, HttpServletRequest  request) throws Exception;
	
	/** 과제 수정 */
	public int updateReportSubFil(Map<String, Object>paramMap, HttpServletRequest  request) throws Exception;

	/** 과제 단건 삭제 */
	public int deleteHwkSub(Map<String, Object>paramMap) throws Exception;
	
}

