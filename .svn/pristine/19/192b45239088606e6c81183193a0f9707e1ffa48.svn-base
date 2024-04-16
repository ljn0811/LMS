package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.TestListPubModel;
import kr.happyjob.study.adm.model.TestPubModel;
import kr.happyjob.study.adm.model.TestQueModel;
import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface TestPubDao {

	/** 시험 강의 목록 조회 */
	//listComnGrpCod 가 쿼리문 ID가 됌.
	public List<TestPubModel> listTestPub(Map<String, Object> paramMap);
	
	/** 시험 강의 카운트 조회 */
	public int countListTestPub(Map<String, Object> paramMap);
		
	/** 시험 목록  조회 */
	public List<TestListPubModel>testListPub(Map<String, Object> paramMap);
	
	/** 시험 카운트 조회 */
	public int countTestListPub(Map<String, Object> paramMap);
	
	/** 시험 상세 조회 */
	public TestListPubModel testListPubDtl(Map<String, Object> paramMap) throws Exception; 
	
	/** 시험 등록 */
	public int testListPubSave(Map<String, Object> paramMap) throws Exception;
		
	/** 시험 수정 */
	public int testListPubUpdate(Map<String, Object> paramMap) throws Exception;	
	
	/** 시험 삭제 */
	public int testListPUbDelete(Map<String, Object> paramMap) throws Exception;	
	
	/** 시험문제 등록 */
	public int testQueSave(Map<String, Object> paramMap) throws Exception;
		
	/** 시험문제 수정 */
	public int testQueUpdate(Map<String, Object> paramMap) throws Exception;	
	
	/** 시험문제 삭제 */
	public int testQueDelete(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 문제 목록 조회 */
	public List<TestQueModel> listTestQue(Map<String, Object> paramMap)throws Exception;
	
	/** 시험 문제 상세 조회 */
	public TestQueModel testQueDtl(Map<String, Object> paramMap) throws Exception; 
	
}
