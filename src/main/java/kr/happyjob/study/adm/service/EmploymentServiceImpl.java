package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.EmploymentDao;
import kr.happyjob.study.adm.model.EmployInfoVO;

@Service
public class EmploymentServiceImpl implements EmploymentService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	EmploymentDao employmentDao;

	@Override
	public List<EmployInfoVO> employmentList(Map<String, Object> paramMap) {
		List<EmployInfoVO> employmentData = employmentDao.employmentList(paramMap);

		return employmentData;
	}

	@Override
	public int employmentCnt(Map<String, Object> paramMap) {
		int totalCount = employmentDao.employmentCnt(paramMap);
		return totalCount;
	}

	@Override
	public List<EmployInfoVO> lectureUserList(Map<String, Object> paramMap) {
		List<EmployInfoVO> employmentData = employmentDao.lectureUserList(paramMap);
		return employmentData;
	}

	@Override
	public int lectureUserCnt(Map<String, Object> paramMap) {
		int totalCount = employmentDao.lectureUserCnt(paramMap);
		return totalCount;
	}

	@Override
	public int employInfoSave(Map<String, Object> paramMap) {
		return employmentDao.employInfoSave(paramMap);
	}

	@Override
	public int employInfoUpdate(Map<String, Object> paramMap) {
		return employmentDao.employInfoUpdate(paramMap);
	}

	@Override
	public int employInfoDelete(Map<String, Object> paramMap) {
		return employmentDao.employInfoDelete(paramMap);
	}

	@Override
	public EmployInfoVO lectureUserdtl(Map<String, Object> paramMap) {
		return employmentDao.lectureUserdtl(paramMap);
	}

	@Override
	public EmployInfoVO employInfodtl(Map<String, Object> paramMap) {
		return employmentDao.employInfodtl(paramMap);
	}

}
