package com.jeecms.cms.lucene;

import com.jeecms.cms.entity.main.Content;
import com.jeecms.common.page.Pagination;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.store.Directory;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface LuceneContentSvc {
	public Integer createIndex(Integer siteId, Integer channelId,
							   Date startDate, Date endDate, Integer startId, Integer max, Integer departId)
			throws IOException, ParseException;

	public Integer createIndex(Integer siteId, Integer channelId,
							   Date startDate, Date endDate, Integer startId, Integer max,
							   Directory dir, Integer departId, Map<String, Object> map) throws IOException, ParseException;

	public void createIndex(Content content, Directory dir) throws IOException;

	public void createIndex(Content content) throws IOException;

	public void deleteIndex(Integer contentId) throws IOException,
			ParseException;

	public void deleteIndex(Integer contentId, Directory dir)
			throws IOException, ParseException;

	public void updateIndex(Content content) throws IOException, ParseException;

	public void updateIndex(Content content, Directory dir) throws IOException,
			ParseException;

	public Pagination searchPage(String path, String queryString, String category, String workplace,
                                 Integer siteId, Integer channelId, Date startDate, Date endDate,
                                 int pageNo, int pageSize, Integer departId, Map<String, Object> map) throws CorruptIndexException,
			IOException, ParseException;

	public Pagination searchPage(Directory dir, String queryString, String category, String workplace,
								 Integer siteId, Integer channelId, Date startDate, Date endDate,
								 int pageNo, int pageSize, Integer departId, Map<String, Object> map) throws CorruptIndexException,
			IOException, ParseException;

	public List<Content> searchList(String path, String queryString, String category, String workplace,
									Integer siteId, Integer channelId, Date startDate, Date endDate,
									int pageNo, int pageSize, Integer departId) throws CorruptIndexException,
			IOException, ParseException;

	public List<Content> searchList(Directory dir, String queryString, String category, String workplace,
									Integer siteId, Integer channelId, Date startDate, Date endDate,
									int first, int max, Integer departId) throws CorruptIndexException, IOException,
			ParseException;

}
