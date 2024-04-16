package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.EquipmentDao;
import kr.happyjob.study.adm.model.ClassroomVO;
import kr.happyjob.study.adm.model.EquipmentVO;

@Service
public class EquipmentServiceImpl implements EquipmentService {

	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();

		@Autowired
		EquipmentDao equipmentDao;
	
	@Override
	public List<EquipmentVO> equipmentList(Map<String, Object> paramMap) {
		List<EquipmentVO> equipmentData = equipmentDao.equipmentList(paramMap);

		return equipmentData;
	}

	@Override
	public int equipmentCnt(Map<String, Object> paramMap) throws Exception {
		int totalCount = equipmentDao.equipmentCnt(paramMap);
		return totalCount;
	}

	@Override
	public int equipmentSave(Map<String, Object> paramMap) {
		return equipmentDao.equipmentSave(paramMap);
	}

	@Override
	public int equipmentUpdate(Map<String, Object> paramMap) {
		
		return equipmentDao.equipmentUpdate(paramMap);
	}

	@Override
	public int equipmentDelete(Map<String, Object> paramMap) {
		return equipmentDao.equipmentDelete(paramMap);
	}

	@Override
	public List<EquipmentVO> equipmentDtlList(Map<String, Object> paramMap) {
		List<EquipmentVO> equipmentData = equipmentDao.equipmentDtlList(paramMap);
		return equipmentData;
	}

	@Override
	public int equipmentDtlCnt(Map<String, Object> paramMap) {
		int totalCount = equipmentDao.equipmentDtlCnt(paramMap);
		return totalCount;
	}

	@Override
	public EquipmentVO equipmentdtl(Map<String, Object> paramMap) {
		return equipmentDao.equipmentdtl(paramMap);
	}


}
