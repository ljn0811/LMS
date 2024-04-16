package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.AdminInfoDao;
import kr.happyjob.study.adm.model.AdminInfoVO;
import kr.happyjob.study.adm.model.TutorInfoVO;

@Service
public class AdminInfoServiceImpl implements AdminInfoService {
	
	@Autowired
	AdminInfoDao adminDao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Override
	public List<TutorInfoVO> adminList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<TutorInfoVO> adminList = adminDao.adminList(paramMap);
		return adminList;
	}

	@Override
	public int adminCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		int adminCnt = adminDao.adminCnt(paramMap);
		return adminCnt;
	}

	@Override
	public int adminDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return adminDao.adminDelete(paramMap);
	}

	@Override
	public AdminInfoVO adminDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		AdminInfoVO adminInfo = adminDao.adminDetail(paramMap);
		return adminInfo;
	}

	@Override
	public int adminUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return adminDao.adminUpdate(paramMap);
	}

	
	
}
