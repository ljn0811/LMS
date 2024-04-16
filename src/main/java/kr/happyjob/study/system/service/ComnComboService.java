package kr.happyjob.study.system.service;

import kr.happyjob.study.system.model.comcombo;

import java.util.List;
import java.util.Map;

public interface ComnComboService {

	/** 로그인 사용자 강의목록 조회 */
	public List<comcombo> selectlecbyuserlist(Map<String, Object> paramMap) throws Exception;
	
    /** 사용자  목록 조회 */
    public List<comcombo> selectuserlist(Map<String, Object> paramMap) throws Exception;

    /** 강의중/미강의중  목록 조회 */
    public List<comcombo> selectlecuserlist(Map<String, Object> paramMap) throws Exception;

    /** 강의실  목록 조회 */
    public List<comcombo> selectclasslist(Map<String, Object> paramMap) throws Exception;
        
    /** 진행 중단  강의 목록 조회 */
    public List<comcombo> selectlecynlist(Map<String, Object> paramMap) throws Exception;
        
   
    /** 테스트 목록 조회 */
    public List<comcombo> selecttestlist(Map<String, Object> paramMap) throws Exception;
    
     
   
}
