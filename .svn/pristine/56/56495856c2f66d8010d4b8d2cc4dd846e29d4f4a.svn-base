package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.TestPubDao;
import kr.happyjob.study.adm.model.TestListPubModel;
import kr.happyjob.study.adm.model.TestPubModel;
import kr.happyjob.study.adm.model.TestQueModel;

@Service
public class TestPubServiceImpl implements TestPubService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	TestPubDao testPubDao;

	/** 시험 강의 목록 조회 */
	public List<TestPubModel> listTestPub(Map<String, Object> paramMap) throws Exception {

		List<TestPubModel> listTestPub = testPubDao.listTestPub(paramMap);

		return listTestPub;
	}

	/** 시험 강의 카운트 조회 */
	public int countListTestPub(Map<String, Object> paramMap) throws Exception {

		int totalCount = testPubDao.countListTestPub(paramMap);

		return totalCount;
	}

	/** 시험 목록 조회 */
	public List<TestListPubModel> testListPub(Map<String, Object> paramMap) throws Exception {

		List<TestListPubModel> testListPub = testPubDao.testListPub(paramMap);

		return testListPub;
	}

	/** 시험 카운트 조회 */
	public int countTestListPub(Map<String, Object> paramMap) throws Exception {

		int totalCount = testPubDao.countTestListPub(paramMap);

		return totalCount;
	}

	/** 시험 상세 조회 */
	public TestListPubModel testListPubDtl(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testListPubDtl(paramMap);
	}

	/** 시험 등록 */
	public int testListPubSave(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testListPubSave(paramMap);
	}

	/** 시험 수정 */
	public int testListPubUpdate(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testListPubUpdate(paramMap);
	}

	/** 시험 삭제 */
	public int testListPUbDelete(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testListPUbDelete(paramMap);
	}

	/** 시험문제 등록 */
	public int testQueSave(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testQueSave(paramMap);
	}

	/** 시험문제 수정 */
	public int testQueUpdate(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testQueUpdate(paramMap);
	}

	/** 시험문제 삭제 */
	public int testQueDelete(Map<String, Object> paramMap) throws Exception {

		return testPubDao.testQueDelete(paramMap);
	}
	/** 시험 문제 목록 조회 */
	public List<TestQueModel> listTestQue(Map<String, Object> paramMap)throws Exception{
		
		List<TestQueModel>listTestQue = testPubDao.listTestQue(paramMap);
		
		return listTestQue;
	}
	
	/** 시험 문제 상세 조회 */
	public TestQueModel testQueDtl(Map<String, Object> paramMap) throws Exception{
		
		return testPubDao.testQueDtl(paramMap);
	}
}

