package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.LecListVO;
import kr.happyjob.study.std.model.SurveyQueVO;

public interface LecListService {
	
	
	/** 목록 조회 */
	public List<LecListVO> lecList(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 개수 */
	public int lecListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 단건 목록 상세 조회 */
	public LecListVO lecListDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 설문 리뷰 등록*/
	public int surveyAnswerInsert(Map<String, Object> paramMap) throws Exception;
	
	/** 설문 질문 단건 조회 */
	public SurveyQueVO selectOneSurveyQuestion(Map<String, Object> paramMap) throws Exception;
	
	/** 설문 답변 단건 조회 */
	public SurveyQueVO selectOneSurveyAnswer(Map<String, Object> paramMap) throws Exception;



}