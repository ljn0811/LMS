package kr.happyjob.study.qanda.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.qanda.model.QandaVO;
import kr.happyjob.study.qanda.model.QnaCommentVO;

public interface QandaDao {

	/** 목록 조회 */
	List<QandaVO> qandaList(Map<String, Object> paramMap) throws Exception;

	/** 리스트 총 개수 */
	int qandaCnt(Map<String, Object> paramMap) throws Exception;

	/** Q&A 저장 */
	int qnaSave(Map<String, Object> paramMap) throws Exception;

	/** Q&A 수정 */
	int qnaUpdate(Map<String, Object> paramMap) throws Exception;

	/** Q&A 삭제 */
	int qnaDelete(Map<String, Object> paramMap) throws Exception;

	/** Q&A 상세 조회 */
	QandaVO qnaDtl(Map<String, Object> paramMap) throws Exception;
	
	/** Q&A 댓글 조회 */
	List<QnaCommentVO> commentList(Map<String, Object> paramMap) throws Exception;

	/** Q&A 댓글 작성 */
	int qnaCommentSave(Map<String, Object> paramMap) throws Exception;

	/** Q&A 댓글 전체 삭제 */
	int commentDeleteAll(Map<String, Object> paramMap) throws Exception;
	
	/** Q&A 댓글 삭제 */
	int commentDeleteOne(Map<String, Object> paramMap) throws Exception;
	
}
