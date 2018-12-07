package com.jeecms.cms.lucene;

import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

public interface LuceneContentDao {

	public Integer index(IndexWriter writer, Integer siteId, Integer channelId,
						 Date startDate, Date endDate, Integer startId, Integer max, Map<String, Object> map)
			throws CorruptIndexException, IOException;
}
