package kr.happyjob.study.qanda.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.qanda.model.QandaVO;
import kr.happyjob.study.qanda.model.QnaCommentVO;

public interface QandaService {

	/** 목록 조회 */
	public List<QandaVO> qandaList(Map<String, Object> paramMap) throws Exception;
	
	/** 리스트 총 개수 */
	public int qandaCnt(Map<String, Object> paramMap) throws Exception;

	/** Q&A 저장 */
	public int qnaSave(Map<String, Object> paramMap) throws Exception;
	
	/** Q&A 상세조회 */
	public QandaVO qnaDtl(Map<String, Object> paramMap) throws Exception;

	/** Q&A 수정 */
	public int qnaUpdate(Map<String, Object> paramMap) throws Exception;

	/** Q&A 삭제 */
	public int qnaDelete(Map<String, Object> paramMap) throws Exception;
	
	/** Q&A 댓글 조회 */
	public List<QnaCommentVO> commentList(Map<String, Object> paramMap) throws Exception;

	/** Q&A 댓글 저장 */
	public int qnaCommentSave(Map<String, Object> paramMap) throws Exception;

	/** Q&A 댓글 전체 삭제 */
	public int commentDeleteAll(Map<String, Object> paramMap) throws Exception;
	
	/** Q&A 댓글 삭제 */
	public int commentDeleteOne(Map<String, Object> paramMap) throws Exception;




}
