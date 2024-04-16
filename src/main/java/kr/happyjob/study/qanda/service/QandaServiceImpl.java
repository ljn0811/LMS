package kr.happyjob.study.qanda.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.qanda.dao.QandaDao;
import kr.happyjob.study.qanda.model.QandaVO;
import kr.happyjob.study.qanda.model.QnaCommentVO;

@Service
public class QandaServiceImpl implements QandaService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	QandaDao qnaDao;

	@Override
	public List<QandaVO> qandaList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub	
		List<QandaVO> qandaList = qnaDao.qandaList(paramMap);
		return qandaList;
	}

	@Override
	public int qandaCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		int totalCount = qnaDao.qandaCnt(paramMap);
		return totalCount;
	}

	@Override
	public int qnaSave(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub		
		return qnaDao.qnaSave(paramMap);
	}

	@Override
	public int qnaUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.qnaUpdate(paramMap);
	}

	@Override
	public int qnaDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.qnaDelete(paramMap);
	}

	@Override
	public QandaVO qnaDtl(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.qnaDtl(paramMap);
	}

	@Override
	public int qnaCommentSave(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.qnaCommentSave(paramMap);
	}

	@Override
	public List<QnaCommentVO> commentList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		List<QnaCommentVO> commentList = qnaDao.commentList(paramMap);
		
		return commentList;
	}

	@Override
	public int commentDeleteAll(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.commentDeleteAll(paramMap);
	}
	
	@Override
	public int commentDeleteOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.commentDeleteOne(paramMap);
	}
	
	
	
}
