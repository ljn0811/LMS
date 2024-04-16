package kr.happyjob.study.tut.model;

public class LectureStudentVO {	
	
	private int lec_no;
	private int test_no;
	private int classroom_no;
	private int user_no;
	private String name;
	private String user_phone;
	private String user_email;
	private String lec_nm;
	private int lec_max_cnt;
	private int lec_cnt;
	private String lec_etc;
	private String lec_start;
	private String lec_end;
	private String lec_content;
	private String learn_goal;
	private String learn_plan;
	private String attendance_notice;
	private String lec_type;
	private String surv_yn;
	private String apv;
	private double atd_per;
	private int atd_day;
	
	public int getLec_no() {
		return lec_no;
	}
	public void setLec_no(int lec_no) {
		this.lec_no = lec_no;
	}
	public int getTest_no() {
		return test_no;
	}
	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}
	public int getClassroom_no() {
		return classroom_no;
	}
	public void setClassroom_no(int classroom_no) {
		this.classroom_no = classroom_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
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
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getLec_nm() {
		return lec_nm;
	}
	public void setLec_nm(String lec_nm) {
		this.lec_nm = lec_nm;
	}
	public int getLec_max_cnt() {
		return lec_max_cnt;
	}
	public void setLec_max_cnt(int lec_max_cnt) {
		this.lec_max_cnt = lec_max_cnt;
	}
	public int getLec_cnt() {
		return lec_cnt;
	}
	public void setLec_cnt(int lec_cnt) {
		this.lec_cnt = lec_cnt;
	}
	public String getLec_etc() {
		return lec_etc;
	}
	public void setLec_etc(String lec_etc) {
		this.lec_etc = lec_etc;
	}
	public String getLec_start() {
		return lec_start;
	}
	public void setLec_start(String lec_start) {
		this.lec_start = lec_start;
	}
	public String getLec_end() {
		return lec_end;
	}
	public void setLec_end(String lec_end) {
		this.lec_end = lec_end;
	}
	public String getLec_content() {
		return lec_content;
	}
	public void setLec_content(String lec_content) {
		this.lec_content = lec_content;
	}
	public String getLearn_goal() {
		return learn_goal;
	}
	public void setLearn_goal(String learn_goal) {
		this.learn_goal = learn_goal;
	}
	public String getLearn_plan() {
		return learn_plan;
	}
	public void setLearn_plan(String learn_plan) {
		this.learn_plan = learn_plan;
	}
	public String getAttendance_notice() {
		return attendance_notice;
	}
	public void setAttendance_notice(String attendance_notice) {
		this.attendance_notice = attendance_notice;
	}
	public String getLec_type() {
		return lec_type;
	}
	public void setLec_type(String lec_type) {
		this.lec_type = lec_type;
	}
	public String getSurv_yn() {
		return surv_yn;
	}
	public void setSurv_yn(String surv_yn) {
		this.surv_yn = surv_yn;
	}
	public String getApv() {
		return apv;
	}
	public void setApv(String apv) {
		this.apv = apv;
	}
	public double getAtd_per() {
		return atd_per;
	}
	public void setAtd_per(double atd_per) {
		this.atd_per = atd_per;
	}
	public int getAtd_day() {
		return atd_day;
	}
	public void setAtd_day(int atd_day) {
		this.atd_day = atd_day;
	}
	@Override
	public String toString() {
		return "LectureStudentVO [lec_no=" + lec_no + ", test_no=" + test_no + ", classroom_no=" + classroom_no
				+ ", user_no=" + user_no + ", name=" + name + ", user_phone=" + user_phone + ", user_email="
				+ user_email + ", lec_nm=" + lec_nm + ", lec_max_cnt=" + lec_max_cnt + ", lec_cnt=" + lec_cnt
				+ ", lec_etc=" + lec_etc + ", lec_start=" + lec_start + ", lec_end=" + lec_end + ", lec_content="
				+ lec_content + ", learn_goal=" + learn_goal + ", learn_plan=" + learn_plan + ", attendance_notice="
				+ attendance_notice + ", lec_type=" + lec_type + ", surv_yn=" + surv_yn + ", apv=" + apv + ", atd_per="
				+ atd_per + ", atd_day=" + atd_day + "]";
	}
}
