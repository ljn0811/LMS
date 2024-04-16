package kr.happyjob.study.system.service;

import kr.happyjob.study.system.dao.ComnComboDao;
import kr.happyjob.study.system.model.comcombo;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ComnComboServiceImpl implements ComnComboService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ComnComboDao comnComboDao;	
	

	
	/** 로그인 사용자 강의목록 조회 */
	public List<comcombo> selectlecbyuserlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectlecbyuserlist(paramMap);
		
		return list;
	}	

  /** 사용자  목록 조회 */
  public List<comcombo> selectuserlist(Map<String, Object> paramMap) throws Exception {
    
    List<comcombo> list = comnComboDao.selectuserlist(paramMap);
    
    return list;
  } 
  
  /** 강의중/미강의중  목록 조회 */
  public List<comcombo> selectlecuserlist(Map<String, Object> paramMap) throws Exception  {
	    
	    List<comcombo> list = comnComboDao.selectlecuserlist(paramMap);
	    
	    return list;
  } 
  
  /** 강의실  목록 조회 */
  public List<comcombo> selectclasslist(Map<String, Object> paramMap) throws Exception  {
	    
	    List<comcombo> list = comnComboDao.selectclasslist(paramMap);
	    
	    return list;
  } 
  
  /** 진행 중단  강의 목록 조회 */
  public List<comcombo> selectlecynlist(Map<String, Object> paramMap) throws Exception {
	    
	    List<comcombo> list = comnComboDao.selectlecynlist(paramMap);
	    
	    return list;
  } 
    
 
 
  /** 테스트 목록 조회 */
  public List<comcombo> selecttestlist(Map<String, Object> paramMap) throws Exception {
	    
	    List<comcombo> list = comnComboDao.selecttestlist(paramMap);
	    
	    return list;
  } 
  

}
