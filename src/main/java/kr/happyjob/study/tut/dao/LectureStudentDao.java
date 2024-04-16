package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.LectureStudentVO;

public interface LectureStudentDao {
	
	public List<LectureStudentVO> lectureList(Map<String, Object> paramMap) throws Exception;

	public int lectureCnt(Map<String, Object> paramMap) throws Exception;

	public List<LectureStudentVO> lectureStudentList(Map<String, Object> paramMap) throws Exception;

	public int lectureStudentCnt(Map<String, Object> paramMap) throws Exception;

	public int updateApv(Map<String, Object> paramMap) throws Exception;
	
}