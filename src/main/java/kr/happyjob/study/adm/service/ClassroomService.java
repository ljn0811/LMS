package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.system.model.ComnDtlCodModel;

public interface ClassroomService {

	/** 목록 조회 */
	public List<ClassroomVO> classroomList(Map<String, Object> paramMap) throws Exception;

	public int classroomCnt(Map<String, Object> paramMap) throws Exception;

	public int classroomSave(Map<String, Object> paramMap);

	public int classroomUpdate(Map<String, Object> paramMap);

	public int classroomDelete(Map<String, Object> paramMap);

	public ClassroomVO classroomdtl(Map<String, Object> paramMap);
	
	public int lectureClassroomNoNull(Map<String, Object> paramMap);

	public List<ClassroomVO> listClassroomEquipment(Map<String, Object> paramMap);

	public int equipmentCnt(Map<String, Object> paramMap);

	
}