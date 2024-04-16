package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.SurveyDao;
import kr.happyjob.study.adm.model.PfsLectureListVO;
import kr.happyjob.study.adm.model.ProfessorListVO;

@Service
public class SurveyServiceImpl implements SurveyService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SurveyDao surveyDao;

	// 강사목록
	public List<ProfessorListVO> professorList(Map<String, Object> paramMap) throws Exception {
		
		List<ProfessorListVO> listData = surveyDao.professorList(paramMap);
		
		return listData;
	}
	
	// 강사별 강의목록
	public List<PfsLectureListVO> pfsLectureList(Map<String, Object> paramMap) throws Exception {
		
		List<PfsLectureListVO> listData = surveyDao.pfsLectureList(paramMap);
		
		return listData;
	}
	
}
