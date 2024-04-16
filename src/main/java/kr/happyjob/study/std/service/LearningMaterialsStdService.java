package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.LearningMaterialsStdVO;
import kr.happyjob.study.std.model.LectureVO;

public interface LearningMaterialsStdService {

	/** 학습자료 조회 */
	public List<LearningMaterialsStdVO> learningMaterialsList(Map<String, Object> paramMap) throws Exception;
	
	/** 카운트 조회 */
	public int learningMaterialsCnt(Map<String, Object> paramMap) throws Exception;

	/** 학습자료 상세조회 */
	public LearningMaterialsStdVO learningMaterialsDtl(Map<String, Object> paramMap);

	/** 학습자료 조회수 */
	public int learningMaterialsViews(Map<String, Object> paramMap)throws Exception;

	

}
