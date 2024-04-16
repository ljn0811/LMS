package kr.happyjob.study.std.dao;

import java.util.Map;
import kr.happyjob.study.std.model.PersonalInfoVO;

public interface PersonalInfoDao {

	/** 개인정보 상세 */
	public PersonalInfoVO personalInfoDtl(Map<String, Object> paramMap);
	
	/**개인정보 수정*/
	public int personalInfoUpdate(Map<String, Object> paramMap);
	
	/**이메일 중복체크*/
	public int checkEmail(Map<String, Object> paramMap);
	
	/**비밀번호 변경*/
	public int personalInfoUpdatePwd(Map<String, Object> paramMap);
	
	/**회원탈퇴*/
	public int deleteUser(Map<String, Object> paramMap);
}
