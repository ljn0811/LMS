package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.adm.model.EquipmentVO;

public interface EquipmentDao {

	/** 목록 조회 */
	public List<EquipmentVO> equipmentList(Map<String, Object> paramMap);
 
	/** 카운트 조회 */
	public int equipmentCnt(Map<String, Object> paramMap) throws Exception;

	public int equipmentSave(Map<String, Object> paramMap);

	public List<EquipmentVO> equipmentDtlList(Map<String, Object> paramMap);

	public int equipmentDtlCnt(Map<String, Object> paramMap);

	public EquipmentVO equipmentdtl(Map<String, Object> paramMap);

	public int equipmentUpdate(Map<String, Object> paramMap);

	public int equipmentDelete(Map<String, Object> paramMap);

}