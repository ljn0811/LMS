package kr.happyjob.study.std.service;

import java.util.Map;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import kr.happyjob.study.std.dao.PersonalInfoDao;
import kr.happyjob.study.std.model.PersonalInfoVO;

@Service
public class PersonalInfoServiceImpl implements PersonalInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PersonalInfoDao personalInfoDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 개인정보 상세 */
	public PersonalInfoVO personalInfoDtl(Map<String, Object> paramMap){
		return personalInfoDao.personalInfoDtl(paramMap);
	}

    /** 개인정보 수정 */
	public int personalInfoUpdate(Map<String, Object> paramMap) {
		return personalInfoDao.personalInfoUpdate (paramMap);
	}
	
	/** 이메일 중복체크 */
	public int checkEmail(Map<String, Object> paramMap){
		return personalInfoDao.checkEmail(paramMap);
    }
	
	/**비밀번호 변경*/
	public int personalInfoUpdatePwd(Map<String, Object> paramMap){
		return personalInfoDao.personalInfoUpdatePwd(paramMap);
	}
	
	/**회원탈퇴*/
	public int deleteUser(Map<String, Object> paramMap){
		return personalInfoDao.deleteUser(paramMap);
	}
}
