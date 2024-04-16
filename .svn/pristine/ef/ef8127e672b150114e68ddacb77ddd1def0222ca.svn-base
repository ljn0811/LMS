package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.tut.model.LearningMaterialsVO;


public interface LearningMaterialsService {

	/** 목록 조회 */
	public List<LearningMaterialsVO> learningMaterialsList(Map<String, Object> paramMap) throws Exception;

	/** 유저정보 단건조회 조회 */
	public LearningMaterialsVO learningMaterialsUserinfo(Map<String, Object> paramMap) throws Exception;
	
	/** 카운트 조회 */
	public int learningMaterialsCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 상세 조회 */
	public LearningMaterialsVO learningMaterialsDetail(Map<String, Object> paramMap) throws Exception;
	
	/** 등록 */
	public int learningMaterialsSaveFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/** 수정 */
	public int learningMaterialsUpdateFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;	
	
	/** 등록파일 삭제 */
	public int learningMaterialsDeleteFile(Map<String, Object> paramMap) throws Exception;
}
