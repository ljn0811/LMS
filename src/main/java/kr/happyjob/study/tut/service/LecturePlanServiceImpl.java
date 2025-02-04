package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.tut.dao.LecturePlanDao;
import kr.happyjob.study.tut.model.LecturePlanVO;

@Service
public class LecturePlanServiceImpl implements LecturePlanService {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   LecturePlanDao lecturePlanDao;
   	
   /** 목록 조회 */
	public List<LecturePlanVO> lecturePlan(Map<String, Object> paramMap) throws Exception {
		
		List<LecturePlanVO> listData = lecturePlanDao.lecturePlan(paramMap);
		
		return listData;
	}
   
	/** 유저정보 단건조회 조회 */
	public LecturePlanVO lecUserinfo(Map<String, Object> paramMap) throws Exception {
		
		LecturePlanVO listUserInfo = lecturePlanDao.lecUserinfo(paramMap);
		
		return listUserInfo;
	}
	
   /** 목록 조회 */
	public List<LecturePlanVO> lecturePlanList(Map<String, Object> paramMap) throws Exception {
		
		List<LecturePlanVO> listData = lecturePlanDao.lecturePlanList(paramMap);
		
		return listData;
	}
	
	/** 카운트 조회 */
	public int lecturePlanCnt(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = lecturePlanDao.lecturePlanCnt(paramMap);
		
		return totalCount;
	}
	
	/** 상세 조회 */
	public LecturePlanVO lecturePlanDetail(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.lecturePlanDetail(paramMap);
	}
	
	/** 등록 */
	public int lecturePlanSave(Map<String, Object> paramMap) throws Exception {		
		return lecturePlanDao.lecturePlanSave(paramMap);
	}
	
	/** 수정 */
	public int lecturePlanUpdate(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.lecturePlanUpdate(paramMap);
	}
	
	/** 삭제 */
	public int lecturePlanDelete(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.lecturePlanDelete(paramMap);
	}
	
	/** 주간계획 목록 **/
	public List<LecturePlanVO> weekList(Map<String, Object> paramMap) throws Exception {
		
		List<LecturePlanVO> weekPlan = lecturePlanDao.weekList(paramMap);
		
		return weekPlan;
	}

	/** 주간계획 여부확인 **/
	public int checkWeek(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.checkWeek(paramMap);
	}	
	
	/** 주간계획 등록 **/
	public int weekRegister(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.weekRegister(paramMap);
	}
	
	/** 주간계획 수정 **/
	public int weekUpdate(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.weekUpdate(paramMap);
	}
	
	/** 주간계획 삭제 **/
	public int weekDelete(Map<String, Object> paramMap) throws Exception {
		return lecturePlanDao.weekDelete(paramMap);
	}

}