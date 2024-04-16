package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.adm.model.EquipmentVO;

public interface EquipmentService {

	List<EquipmentVO> equipmentList(Map<String, Object> paramMap);

	int equipmentCnt(Map<String, Object> paramMap) throws Exception;

	public int equipmentSave(Map<String, Object> paramMap);

	public int equipmentUpdate(Map<String, Object> paramMap);

	public int equipmentDelete(Map<String, Object> paramMap);

	List<EquipmentVO> equipmentDtlList(Map<String, Object> paramMap);

	int equipmentDtlCnt(Map<String, Object> paramMap);

	EquipmentVO equipmentdtl(Map<String, Object> paramMap);
}
