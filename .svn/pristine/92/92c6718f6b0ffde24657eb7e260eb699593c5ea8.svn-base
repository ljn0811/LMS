package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.std.dao.LecListDao;
import kr.happyjob.study.std.model.LecListVO;
import kr.happyjob.study.std.model.SurveyQueVO;
import kr.happyjob.study.supportD.dao.NoticeDDao;
import kr.happyjob.study.supportD.model.NoticeDModel;

@Service
public class LecListServiceImpl implements LecListService {
	
	@Autowired
	LecListDao lecListDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.stdPath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 목록 조회 */
	public List<LecListVO> lecList(Map<String, Object> paramMap) throws Exception{
		List<LecListVO> listdata = lecListDao.lecList(paramMap);
		
		return listdata;
	}
	
	/** 목록 개수 */
	public int lecListCnt(Map<String, Object> paramMap) throws Exception{
		return lecListDao.lecListCnt(paramMap);		 
	}
	
	/** 단건 목록 상세 조회 */
	public LecListVO lecListDtl(Map<String, Object> paramMap) throws Exception{
		LecListVO dtlData = lecListDao.lecListDtl(paramMap);
		
		return dtlData;
	}
	
	/** 학생 설문 리뷰 등록*/
	public int surveyAnswerInsert(Map<String, Object> paramMap) throws Exception{
		return lecListDao.surveyAnswerInsert(paramMap);
	}
	
	/** 설문 질문 단건 조회 */
	public SurveyQueVO selectOneSurveyQuestion(Map<String, Object> paramMap) throws Exception{
		return lecListDao.selectOneSurveyQuestion(paramMap);
	}
	
	/** 설문 답변 단건 조회 */
	public SurveyQueVO selectOneSurveyAnswer(Map<String, Object> paramMap) throws Exception{
		return lecListDao.selectOneSurveyAnswer(paramMap);
	}
	
	
	


}