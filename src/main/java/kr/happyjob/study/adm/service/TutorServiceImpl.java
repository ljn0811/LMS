package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.TutorDao;
import kr.happyjob.study.adm.model.TutorInfoVO;

@Service
public class TutorServiceImpl implements TutorService {
	
	@Autowired
	TutorDao tutorDao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Override
	public List<TutorInfoVO> tutorList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<TutorInfoVO> tutorList = tutorDao.tutorList(paramMap);
		return tutorList;
	}

	@Override
	public int tutorCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		int tutorCnt = tutorDao.tutorCnt(paramMap);
		return tutorCnt;
	}

	@Override
	public int tutorUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return tutorDao.tutorUpdate(paramMap);
	}

	@Override
	public int tutorDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return tutorDao.tutorDelete(paramMap);
	}

	@Override
	public List<TutorInfoVO> userTypeList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<TutorInfoVO> userTypeList = tutorDao.userTypeList(paramMap);
		return userTypeList;
	}

	
}
