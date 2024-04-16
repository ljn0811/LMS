package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.tut.model.LecturePlanVO;

public interface ClassroomDao {

	/** 목록 조회 */
	public List<ClassroomVO> classroomList(Map<String, Object> paramMap);
 
	/** 카운트 조회 */
	public int classroomCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 신규등록 */
	public int classroomSave(Map<String, Object> paramMap);
	
	/** 수정 */
	public int classroomUpdate(Map<String, Object> paramMap);

	/** 삭제 */
	public int classroomDelete(Map<String, Object> paramMap);

	public ClassroomVO classroomdtl(Map<String, Object> paramMap);

	public int lectureClassroomNoNull(Map<String, Object> paramMap);

	public List<ClassroomVO> classroomEquipList(Map<String, Object> paramMap);

	public int equipmentCnt(Map<String, Object> paramMap);

}