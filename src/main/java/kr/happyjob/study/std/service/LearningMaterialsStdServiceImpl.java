package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import kr.happyjob.study.std.dao.LearningMaterialsStdDao;
import kr.happyjob.study.std.dao.LectureDao;
import kr.happyjob.study.std.model.LearningMaterialsStdVO;
import kr.happyjob.study.std.model.LectureVO;
import kr.happyjob.study.tut.model.ReportControlVO;

@Service
public class LearningMaterialsStdServiceImpl implements LearningMaterialsStdService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LearningMaterialsStdDao learningMaterialsStdDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 학습자료 조회 */
	public List<LearningMaterialsStdVO> learningMaterialsList(Map<String, Object> paramMap) throws Exception {
		
		List<LearningMaterialsStdVO> learningMaterialsList = learningMaterialsStdDao.learningMaterialsList(paramMap);
		
		return learningMaterialsList;
	}
	
	/** 카운트 조회 */
	public int learningMaterialsCnt(Map<String, Object> paramMap) throws Exception {
		
		int learningMaterialsCnt = learningMaterialsStdDao.learningMaterialsCnt(paramMap);
		
		return learningMaterialsCnt;
	}
	
	/** 학습자료 상세조회 */
	public LearningMaterialsStdVO learningMaterialsDtl(Map<String, Object> paramMap){
		return learningMaterialsStdDao.learningMaterialsDtl(paramMap);
	}
	
	/** 학습자료 조회수 */
	public int learningMaterialsViews(Map<String, Object> paramMap) throws Exception{
		return learningMaterialsStdDao.learningMaterialsViews(paramMap);
	}
	
}
