package com.creco.indexer;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.core.StopAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.FSDirectory;

import com.creco.model.Nugget;

public class Searcher {
	private static final int HIT_COUNT = 10;

	private Searcher() {
	}

	public static List<Nugget> search(String queryString, String indexDirectory)
			throws IOException, ParseException {

		IndexReader reader = DirectoryReader
				.open(FSDirectory.open(Paths.get(indexDirectory)));
		IndexSearcher searcher = new IndexSearcher(reader);
		Analyzer analyzer = new StandardAnalyzer(
				StopAnalyzer.ENGLISH_STOP_WORDS_SET);

		QueryParser parser = new QueryParser(IndexConstants.VALUE, analyzer);

		queryString = queryString.trim();
		if (queryString.length() == 0) {
			reader.close();
			return null;
		}

		Query query = parser.parse(QueryParser.escape(queryString));

		final TopScoreDocCollector collector = TopScoreDocCollector
				.create(HIT_COUNT);
		searcher.search(query, collector);

		final ScoreDoc[] hits = collector.topDocs().scoreDocs;
		final List<Nugget> recos = new ArrayList<Nugget>();
		for (int i = 0; i < hits.length; i++) {
			int docId = hits[i].doc;
			final Document doc = searcher.doc(docId);
			final Nugget nugget = new Nugget();
			nugget.setUrl(doc.get(IndexConstants.KEY));
			nugget.setTitle(doc.get(IndexConstants.HEADER));
			nugget.setContents(doc.get(IndexConstants.VALUE));
			recos.add(nugget);
		}
		reader.close();
		return recos;
	}
}