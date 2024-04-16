package kr.happyjob.study.std.model;


public class LectureVO{	
	
	//강의번호
    private int lec_no;
    //시험ID
    private int test_no;
    //강의실번호
    private int classroom_no;
    //강사ID
    private int user_no;
    //강의명
    private String lec_nm;
    //최대인원
    private int lec_max_cnt;
    //수강인원
    private int lec_cnt;
    //비고
    private String lec_etc;
    //개강일
    private String lec_start;
    //종강일
    private String lec_end;
    //강의내용
    private String lec_content;
    //수업목표
    private String learn_goal;
    //강의계획
    private String learn_plan;
    //유저이름
    private String name;
    //수강신청 승인여부
    private String apv;
    
    
    // getter and setter
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getApv() {
		return apv;
	}
	public void setApv(String apv) {
		this.apv = apv;
	}
    
    
    
    
    
    
	
}
