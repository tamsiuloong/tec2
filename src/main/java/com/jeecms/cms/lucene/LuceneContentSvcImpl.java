package com.jeecms.cms.lucene;

import com.jeecms.cms.Constants;
import com.jeecms.cms.entity.main.Content;
import com.jeecms.cms.manager.main.ContentMng;
import com.jeecms.common.page.Pagination;
import com.jeecms.common.web.springmvc.RealPathResolver;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.util.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class LuceneContentSvcImpl implements LuceneContentSvc {
	@Transactional(readOnly = true)
	public Integer createIndex(Integer siteId, Integer channelId,
							   Date startDate, Date endDate, Integer startId, Integer max, Integer departId)
			throws IOException, ParseException {
/*		String path = realPathResolver.get(Constants.LUCENE_PATH);
		Directory dir = new SimpleFSDirectory(new File(path));*/
		return createIndex(siteId, channelId, startDate, endDate, startId, max,
				this.luceneDir, departId, null);
	}

	@Transactional(readOnly = true)
	public Integer createIndex(Integer siteId, Integer channelId,
							   Date startDate, Date endDate, Integer startId, Integer max,
							   Directory dir, Integer departId, Map<String, Object> map) throws IOException, ParseException {
		boolean exist = IndexReader.indexExists(dir);
		IndexWriter writer = new IndexWriter(dir, new StandardAnalyzer(
				Version.LUCENE_30), !exist, IndexWriter.MaxFieldLength.LIMITED);
		try {
			if (exist) {
                luceneContent.delete(siteId, channelId, startDate, endDate,
						writer, departId, map);
			}
			Integer lastId = luceneContentDao.index(writer, siteId, channelId,
					startDate, endDate, startId, max,map);
			writer.optimize();
			return lastId;
		} finally {
			writer.close();
		}
	}

	@Transactional(readOnly = true)
	public void createIndex(Content content) throws IOException {
/*		String path = realPathResolver.get(Constants.LUCENE_PATH);
		Directory dir = new SimpleFSDirectory(new File(path));*/
		createIndex(content, luceneDir);
	}

	@Transactional(readOnly = true)
	public void createIndex(Content content, Directory dir) throws IOException {
		boolean exist = IndexReader.indexExists(dir);
		IndexWriter writer = new IndexWriter(dir, new StandardAnalyzer(
				Version.LUCENE_30), !exist, IndexWriter.MaxFieldLength.LIMITED);
		try {
			writer.addDocument(luceneContent.createDocument(content));
		} finally {
			writer.close();
		}
	}

	@Transactional(readOnly = true)
	public void deleteIndex(Integer contentId) throws IOException,
			ParseException {
/*		String path = realPathResolver.get(Constants.LUCENE_PATH);
		Directory dir = new SimpleFSDirectory(new File(path));*/
		deleteIndex(contentId, luceneDir);
	}

	@Transactional(readOnly = true)
	public void deleteIndex(Integer contentId, Directory dir)
			throws IOException, ParseException {
		boolean exist = IndexReader.indexExists(dir);
		if (exist) {
			IndexWriter writer = new IndexWriter(dir, new StandardAnalyzer(
					Version.LUCENE_30), false,
					IndexWriter.MaxFieldLength.LIMITED);
			try {
                luceneContent.delete(contentId, writer);
			} finally {
				writer.close();
			}
		}
	}

	public void updateIndex(Content content) throws IOException, ParseException {
/*		String path = realPathResolver.get(Constants.LUCENE_PATH);
		Directory dir = new SimpleFSDirectory(new File(path));*/
		updateIndex(content, luceneDir);
	}

	public void updateIndex(Content content, Directory dir) throws IOException,
			ParseException {
		boolean exist = IndexReader.indexExists(dir);
		IndexWriter writer = new IndexWriter(dir, new StandardAnalyzer(
				Version.LUCENE_30), !exist, IndexWriter.MaxFieldLength.LIMITED);
		try {
			if (exist) {
                luceneContent.delete(content.getId(), writer);
			}
			writer.addDocument(luceneContent.createDocument(content));
		} finally {
			writer.close();
		}
	}

	@Transactional(readOnly = true)
	public Pagination searchPage(String path, String queryString, String category, String workplace,
                                 Integer siteId, Integer channelId, Date startDate, Date endDate,
                                 int pageNo, int pageSize, Integer departId, Map<String, Object> map) throws CorruptIndexException,
			IOException, ParseException {
		Directory dir = new SimpleFSDirectory(new File(path));
		return searchPage(dir, queryString,category,workplace, siteId, channelId, startDate,
				endDate, pageNo, pageSize, departId,  map);
	}



	@Transactional(readOnly = true)
	public Pagination searchPage(Directory dir, String queryString, String category, String workplace,
								 Integer siteId, Integer channelId, Date startDate, Date endDate,
								 int pageNo, int pageSize, Integer departId, Map<String, Object> map) throws CorruptIndexException,
			IOException, ParseException {
		Searcher searcher = new IndexSearcher(dir);
		try {
			Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_30);
			Query query = luceneContent.createQuery(queryString,category,workplace, siteId,
					channelId, startDate, endDate, analyzer, departId,map);
			TopDocs docs = searcher.search(query, pageNo * pageSize);
			Pagination p = luceneContent.getResultPage(searcher, docs, pageNo,
					pageSize);
			List<?> ids = p.getList();
			List<Content> contents = new ArrayList<Content>(ids.size());
			for (Object id : ids) {
				contents.add(contentMng.findById((Integer) id));
			}
			p.setList(contents);
			return p;
		} finally {
			searcher.close();
		}
	}

	@Transactional(readOnly = true)
	public List<Content> searchList(String path, String queryString, String category, String workplace,
									Integer siteId, Integer channelId, Date startDate, Date endDate,
									int first, int max, Integer departId) throws CorruptIndexException, IOException,
			ParseException {
		Directory dir = new SimpleFSDirectory(new File(path));
		return searchList(dir, queryString, category,workplace,siteId, channelId, startDate,
				endDate, first, max, departId);
	}

	@Transactional(readOnly = true)
	public List<Content> searchList(Directory dir, String queryString, String category, String workplace,
									Integer siteId, Integer channelId, Date startDate, Date endDate,
									int first, int max, Integer departId) throws CorruptIndexException, IOException,
			ParseException {
		Searcher searcher = new IndexSearcher(dir);
		try {
			Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_30);
			Query query = luceneContent.createQuery(queryString,category,workplace, siteId,
					channelId, startDate, endDate, analyzer, departId, null);
			if (first < 0) {
				first = 0;
			}
			if (max < 0) {
				max = 0;
			}
			TopDocs docs = searcher.search(query, first + max);
			List<Integer> ids = luceneContent.getResultList(searcher, docs,
					first, max);
			List<Content> contents = new ArrayList<Content>(ids.size());
			for (Object id : ids) {
				contents.add(contentMng.findById((Integer) id));
			}
			return contents;
		} finally {
			searcher.close();
		}
	}

	private RealPathResolver realPathResolver;
	private ContentMng contentMng;
	private LuceneContentDao luceneContentDao;
	private Directory luceneDir;
	@Autowired
    private LuceneContent luceneContent;

	@PostConstruct
	public void initDir() throws IOException {
		String path = realPathResolver.get(Constants.LUCENE_PATH);
		Directory dir = new SimpleFSDirectory(new File(path));
		this.luceneDir = dir;
	}

	@Autowired
	public void setRealPathResolver(RealPathResolver realPathResolver) {
		this.realPathResolver = realPathResolver;

	}

	@Autowired
	public void setLuceneContentDao(LuceneContentDao luceneContentDao) {
		this.luceneContentDao = luceneContentDao;
	}

	@Autowired
	public void setContentMng(ContentMng contentMng) {
		this.contentMng = contentMng;
	}

}
