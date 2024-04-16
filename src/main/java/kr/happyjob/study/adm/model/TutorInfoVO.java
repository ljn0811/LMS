package kr.happyjob.study.adm.model;

public class TutorInfoVO {
	
	private int user_no;
	private String loginID;
	private String name;
	private String user_phone;
	private String user_gender;
	private String user_location;
	private String user_birth;
	private String user_type;
	private String user_email;
	private String created_at;
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_location() {
		return user_location;
	}
	public void setUser_location(String user_location) {
		this.user_location = user_location;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	@Override
	public String toString() {
		return "TutorInfoVO [user_no=" + user_no + ", loginID=" + loginID + ", name=" + name + ", user_phone="
				+ user_phone + ", user_gender=" + user_gender + ", user_location=" + user_location + ", user_birth="
				+ user_birth + ", user_type=" + user_type + ", user_email=" + user_email + ", created_at=" + created_at
				+ "]";
	}
	
}
