package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import kr.happyjob.study.tut.model.ReportControlVO;

public interface ReportControlDao {
	
	// 강의 리스트
	public List<ReportControlVO> showLectureList(Map<String, Object> paramMap);
	// 강의 리스트 카운트
	public int lecListcnt(Map<String, Object> paramMap) throws Exception;
	// 과제 리스트
	public List<ReportControlVO> showProjectInfo(Map<String, Object> paramMap);
	// 강의 리스트 카운트
	public int reportLisCnt(Map<String, Object> paramMap) throws Exception;
	// 과제등록 
	public int makeProject(Map<String, Object> paramMap)throws Exception;
	
	
	public List<ReportControlVO> showLectureInfo(Map<String, Object> paramMap);


	public List<ReportControlVO> showSubmitInfo(Map<String, Object> paramMap);

	public ReportControlVO showStudentCon(Map<String, Object> paramMap);

	public ReportControlVO showProjectInfo2(Map<String, Object> paramMap);

	public int updateProject(Map<String, Object> paramMap)throws Exception;


	
}
