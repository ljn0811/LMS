package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.std.dao.LecListDao;
import kr.happyjob.study.std.dao.TestApplicationsDao;
import kr.happyjob.study.std.model.LecListVO;
import kr.happyjob.study.std.model.SurveyQueVO;
import kr.happyjob.study.std.model.TestApplicationsVO;
import kr.happyjob.study.supportD.dao.NoticeDDao;
import kr.happyjob.study.supportD.model.NoticeDModel;

@Service
public class TestApplicationsServiceImpl implements TestApplicationsService {
	
	@Autowired
	TestApplicationsDao testApplicationsDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.stdPath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 목록 조회 */
	public List<TestApplicationsVO> testList(Map<String, Object> paramMap) throws Exception{
		List<TestApplicationsVO> listdata = testApplicationsDao.testList(paramMap);
		
		return listdata;
	}
	
	/** 리스트 갯수 조회 */
	public int testListCnt(Map<String, Object> paramMap) throws Exception{
		return testApplicationsDao.testListCnt(paramMap);
	}
	
	/** 단건 목록 상세 조회 */
	public LecListVO lecListDtl(Map<String, Object> paramMap) throws Exception{
		LecListVO dtlData = testApplicationsDao.lecListDtl(paramMap);
		
		return dtlData;
	}
	
	/** 학생 설문 리뷰 등록*/
	public int surveyAnswerInsert(Map<String, Object> paramMap) throws Exception{
		return testApplicationsDao.surveyAnswerInsert(paramMap);
	}
	
	/** 설문 질문 단건 조회 */
	public SurveyQueVO selectOneSurveyQuestion(Map<String, Object> paramMap) throws Exception{
		return testApplicationsDao.selectOneSurveyQuestion(paramMap);
	}
	
	/** 설문 답변 단건 조회 */
	public SurveyQueVO selectOneSurveyAnswer(Map<String, Object> paramMap) throws Exception{
		return testApplicationsDao.selectOneSurveyAnswer(paramMap);
	}
	
	
	


}