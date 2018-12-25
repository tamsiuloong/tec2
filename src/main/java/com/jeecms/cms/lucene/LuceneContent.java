package com.jeecms.cms.lucene;

import com.jeecms.cms.entity.main.Channel;
import com.jeecms.cms.entity.main.Content;
import com.jeecms.cms.entity.main.ContentDoc;
import com.jeecms.common.page.Pagination;
import com.jeecms.common.web.springmvc.RealPathResolver;
import org.apache.commons.lang.StringUtils;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.DateTools;
import org.apache.lucene.document.DateTools.Resolution;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.search.*;
import org.apache.lucene.util.Version;
import org.apache.pdfbox.io.RandomAccessBufferedFileInputStream;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.*;
import java.util.*;

@Component
public class LuceneContent {
	private static final Logger log = LoggerFactory.getLogger(LuceneContent.class);
	private Document createExtDocument(Document doc, Content c){
		Set<ContentDoc> docSet = c.getContentDocSet();
		if (docSet != null){
			for (ContentDoc ds: docSet) {
				String path = realPathResolver.get(ds.getDocPath());
				String fileType = ds.getFileSuffix();
				InputStream in = null;
				InputStreamReader reader = null;

				try {
					in = new FileInputStream(path);
					if (fileType.equals("doc")) {

						//读取doc文件
						WordExtractor wordData = new WordExtractor(in);
						//创建Field对象，并放入lucene的document对象doc中
						doc.add(new Field(DOC_SET, wordData.getText(), Field.Store.NO,
								Field.Index.ANALYZED));
						log.debug("注意：已为文件“{}”创建了索引", path);
						wordData.close();
					}else if ( fileType.equals("docx")) {
						//读取docx文件
						XWPFWordExtractor wordData = new XWPFWordExtractor(new XWPFDocument(in));
						//创建Field对象，并放入lucene的document对象doc中
						doc.add(new Field(DOC_SET, wordData.getText(), Field.Store.NO,
								Field.Index.ANALYZED));
						log.debug("注意：已为文件“{}”创建了索引", path);
						wordData.close();
					}else if ( fileType.equals("pdf")) {
						//读取pdf文件
						PDFParser parser = new PDFParser(new RandomAccessBufferedFileInputStream(in));
						parser.parse();
						PDDocument pdDocument = parser.getPDDocument();
						PDFTextStripper stripper = new PDFTextStripper();
//                          String result = stripper.getText(pdDocument);
						//创建Field对象，并放入lucene的document对象doc中
						doc.add(new Field(DOC_SET, stripper.getText(pdDocument), Field.Store.NO,
								Field.Index.ANALYZED));
						log.debug("注意：已为文件“{}”创建了索引", path);
						pdDocument.close();
					}else if ( fileType.equals("txt") ) {
						//读取txt文件
						//建立一个输入流对象reader
						reader = new InputStreamReader(in);
						//建立一个对象，它把文件内容转成计算机能读懂的语言
						BufferedReader br = new BufferedReader(reader);
						StringBuilder wordData = new StringBuilder();
						String line = null;
						//一次读入一行数据
						while ((line = br.readLine()) != null) {
							wordData.append(line);
						}
						doc.add(new Field(DOC_SET, wordData.toString(), Field.Store.NO,
								Field.Index.ANALYZED));
						log.debug("注意：已为文件“{}”创建了索引", path);
					} else {
						log.warn("无法创建索引，无法识别的文件类型:{}", path);
					}

				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					if (in != null) {
						try {
							in.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if (reader != null) {
						try {
							reader.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return doc;
	}

	/**
	 * 获得Lucene格式的Document
	 * 
	 * @param c
	 *            文章对象
	 * @return
	 */
	public Document createDocument(Content c) {
		Document doc = new Document();
		doc.add(new Field(ID, c.getId().toString(), Field.Store.YES,
				Field.Index.NOT_ANALYZED));
		doc.add(new Field(SITE_ID, c.getSite().getId().toString(),
				Field.Store.NO, Field.Index.NOT_ANALYZED));
		doc.add(new Field(RELEASE_DATE, DateTools.dateToString(c
				.getReleaseDate(), Resolution.DAY), Field.Store.NO,
				Field.Index.NOT_ANALYZED));
		Channel channel = c.getChannel();
		while (channel != null) {
			doc.add(new Field(CHANNEL_ID_ARRAY, channel.getId().toString(),
					Field.Store.NO, Field.Index.NOT_ANALYZED));
			channel = channel.getParent();
		}
		doc.add(new Field(TITLE, c.getTitle(), Field.Store.NO,
				Field.Index.ANALYZED));

		if (c.getDept()!=null) {
			doc.add(new Field(DEPART_ID, c.getDept().getId().toString(), Field.Store.NO,
					Field.Index.ANALYZED));
		}

		if (!StringUtils.isBlank(c.getTxt())) {
			doc.add(new Field(CONTENT, c.getTxt(), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		if (!StringUtils.isBlank(c.getTxt1())) {
			doc.add(new Field(CONTENT1, c.getTxt1(), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		if (!StringUtils.isBlank(c.getTxt2())) {
			doc.add(new Field(CONTENT2, c.getTxt2(), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		if (!StringUtils.isBlank(c.getTxt3())) {
			doc.add(new Field(CONTENT3, c.getTxt3(), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		if (c.getParent()==null) {
			doc.add(new Field(PARENT_TYPE, "0", Field.Store.NO,
					Field.Index.ANALYZED));
		}
		else
		{
			doc.add(new Field(PARENT_TYPE, "1", Field.Store.NO,
				Field.Index.ANALYZED));
		}

		if(c.getAttr()!=null&&StringUtils.isNotBlank(c.getAttr().get("workplace"))){
			doc.add(new Field(WORKPLACE, c.getAttr().get("workplace"), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		if(c.getAttr()!=null&&StringUtils.isNotBlank(c.getAttr().get("category"))){
			doc.add(new Field(CATEGORY, c.getAttr().get("category"), Field.Store.NO,
					Field.Index.ANALYZED));
		}

//		if(c.getAttr()!=null&&StringUtils.isNotBlank(c.getAttr().get("scope"))){
//			doc.add(new Field(SCOPE, c.getAttr().get("scope"), Field.Store.NO,
//					Field.Index.ANALYZED));
//		}
//		if(c.getAttr()!=null&&StringUtils.isNotBlank(c.getAttr().get("budgetScale"))){
//			doc.add(new Field(BUDGET_SCALE, c.getAttr().get("budgetScale"), Field.Store.NO,
//					Field.Index.ANALYZED));
//		}
		//类别
		if(c.getAttr()!=null&&StringUtils.isNotBlank(c.getAttr().get("projectType"))){
			doc.add(new Field(PROJECT_TYPE, c.getAttr().get("projectType"), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		//部门名字
		if(c.getDept()!=null)
		{
			doc.add(new Field(DEPT, c.getDeptName(), Field.Store.NO,
					Field.Index.ANALYZED));
		}
		//年度
		String year = DateTools.dateToString(c.getReleaseDate(), Resolution.YEAR);
		doc.add(new Field(RELEASE_YEAR, year, Field.Store.NO,
				Field.Index.ANALYZED));

		createExtDocument(doc, c);

		return doc;
	}



	public Query createQuery(String queryString, String category, String workplace, Integer siteId,
                             Integer channelId, Date startDate, Date endDate, Analyzer analyzer, Integer departId, Map<String, Object> map)
			throws ParseException {
		BooleanQuery bq = new BooleanQuery();
		Query q;
		if (!StringUtils.isBlank(queryString)) {
			q = MultiFieldQueryParser.parse(Version.LUCENE_30, queryString,
					QUERY_FIELD, QUERY_FLAGS, analyzer);
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if(StringUtils.isNotBlank(category)){
			q = MultiFieldQueryParser.parse(Version.LUCENE_30, category,
					CATEGORY_FIELD, CATEGORY_FLAGS, analyzer);
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if(StringUtils.isNotBlank(workplace)){
			q = MultiFieldQueryParser.parse(Version.LUCENE_30, workplace,
					WORKPLACE_FIELD, WORKPLACE_FLAGS, analyzer);
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if (siteId != null) {
			q = new TermQuery(new Term(SITE_ID, siteId.toString()));
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if (departId != null) {
			q = new TermQuery(new Term(DEPART_ID, departId.toString()));
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if (channelId != null) {
			q = new TermQuery(new Term(CHANNEL_ID_ARRAY, channelId.toString()));
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if (startDate != null || endDate != null) {
			String start = null;
			String end = null;
			if (startDate != null) {
				start = DateTools.dateToString(startDate, Resolution.DAY);
			}
			if (endDate != null) {
				end = DateTools.dateToString(endDate, Resolution.DAY);
			}
			q = new TermRangeQuery(RELEASE_DATE, start, end, true, true);
			bq.add(q, BooleanClause.Occur.MUST);
		}
		if(map!=null&&map.size()>0)
		{
			String parentType = (String) map.get("parentType");
			if(parentType!=null)
			{
				q = new TermQuery(new Term(PARENT_TYPE, parentType));
				bq.add(q, BooleanClause.Occur.MUST);
			}

			String projectType = (String) map.get("projectType");
			if(projectType!=null&&!projectType.isEmpty())
			{
				q = MultiFieldQueryParser.parse(Version.LUCENE_30, projectType,
						PROJECT_TYPE_FIELD, PROJECT_TYPE_FLAGS, analyzer);
				bq.add(q, BooleanClause.Occur.MUST);
			}

			String year = (String) map.get("year");
			if(year!=null&&!year.isEmpty())
			{
				q = new TermQuery(new Term(RELEASE_YEAR, year));
				bq.add(q, BooleanClause.Occur.MUST);
			}

			String dept = (String) map.get("dept");
			if(dept!=null&&!dept.isEmpty())
			{
//				q = new FuzzyQuery(new Term(DEPT, dept));
//				bq.add(q, BooleanClause.Occur.MUST);

				q = MultiFieldQueryParser.parse(Version.LUCENE_30, dept,
						new String[]{DEPT}, new BooleanClause.Occur[]{BooleanClause.Occur.SHOULD}, analyzer);
				bq.add(q, BooleanClause.Occur.MUST);
			}
		}
		return bq;
	}

	public void delete(Integer siteId, Integer channelId,
					   Date startDate, Date endDate, IndexWriter writer, Integer departId, Map<String, Object> map)
			throws CorruptIndexException, IOException, ParseException {
		writer.deleteDocuments(createQuery(null,null,null, siteId, channelId, startDate,
				endDate, null, departId, map));
	}

	public void delete(Integer contentId, IndexWriter writer)
			throws CorruptIndexException, IOException, ParseException {
		writer.deleteDocuments(new Term(ID, contentId.toString()));
	}

	public Pagination getResultPage(Searcher searcher, TopDocs docs,
			int pageNo, int pageSize) throws CorruptIndexException, IOException {
		List<Integer> list = new ArrayList<Integer>(pageSize);
		ScoreDoc[] hits = docs.scoreDocs;
		int endIndex = pageNo * pageSize;
		int len = hits.length;
		if (endIndex > len) {
			endIndex = len;
		}
		for (int i = (pageNo - 1) * pageSize; i < endIndex; i++) {
			Document d = searcher.doc(hits[i].doc);
			list.add(Integer.valueOf(d.getField(ID).stringValue()));
		}
		return new Pagination(pageNo, pageSize, docs.totalHits, list);
	}

	public List<Integer> getResultList(Searcher searcher, TopDocs docs,
			int first, int max) throws CorruptIndexException, IOException {
		List<Integer> list = new ArrayList<Integer>(max);
		ScoreDoc[] hits = docs.scoreDocs;
		if (first < 0) {
			first = 0;
		}
		if (max < 0) {
			max = 0;
		}
		int last = first + max;
		int len = hits.length;
		if (last > len) {
			last = len;
		}
		for (int i = first; i < last; i++) {
			Document d = searcher.doc(hits[i].doc);
			list.add(Integer.valueOf(d.getField(ID).stringValue()));
		}
		return list;
	}

	@Autowired
	private RealPathResolver realPathResolver;

	public static final String ID = "id";
	public static final String SITE_ID = "siteId";
	public static final String DEPART_ID = "departId";

	public static final String CHANNEL_ID_ARRAY = "channelIdArray";
	public static final String PARENT_TYPE = "parentType";

	public static final String PROJECT_TYPE = "projectType";
	public static final String[] PROJECT_TYPE_FIELD = { PROJECT_TYPE };
	public static final BooleanClause.Occur[] PROJECT_TYPE_FLAGS = {BooleanClause.Occur.SHOULD};
	public static final String DEPT = "dept";
	public static final String RELEASE_YEAR = "releaseYear";


	public static final String RELEASE_DATE = "releaseDate";

	public static final String TITLE = "title";
	public static final String CONTENT = "content";
	public static final String CONTENT1 = "content1";
	public static final String CONTENT2 = "content2";
	public static final String CONTENT3 = "content3";
	public static final String WORKPLACE = "workplace";
	public static final String CATEGORY = "category";
	private static final String DOC_SET = "docSet";
	public static final String[] QUERY_FIELD = { TITLE, CONTENT,CONTENT1,CONTENT2,CONTENT3, DOC_SET,PROJECT_TYPE,DEPT,RELEASE_YEAR };
	public static final BooleanClause.Occur[] QUERY_FLAGS = {BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD,
			BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD, BooleanClause.Occur.SHOULD };
	public static final String[] CATEGORY_FIELD = { CATEGORY };
	public static final BooleanClause.Occur[] CATEGORY_FLAGS = {BooleanClause.Occur.SHOULD };
	public static final String[] WORKPLACE_FIELD = { WORKPLACE };
	public static final BooleanClause.Occur[] WORKPLACE_FLAGS = {BooleanClause.Occur.SHOULD};
}