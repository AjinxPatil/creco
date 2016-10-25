package com.creco.indexer;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.core.StopAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.IndexWriterConfig.OpenMode;
import org.apache.lucene.index.Term;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

public class Indexer {

	private Indexer() {
	}

	public static void index(String dumpDirectory, String indexDirectory) {

		final Path dumpDir = Paths.get(dumpDirectory);
		if (!Files.isReadable(dumpDir)) {
			System.out.println("Document directory '" + dumpDir.toAbsolutePath()
					+ "' does not exist or is not readable, please check the location of crawled files");
			System.exit(1);
		}

		try {
			final Directory indexDir = FSDirectory.open(Paths.get(indexDirectory));
			final Analyzer analyzer = new StandardAnalyzer(StopAnalyzer.ENGLISH_STOP_WORDS_SET);
			final IndexWriterConfig iWriterConfig = new IndexWriterConfig(analyzer);

			iWriterConfig.setOpenMode(OpenMode.CREATE);

			final IndexWriter writer = new IndexWriter(indexDir, iWriterConfig);
			indexDocs(writer, dumpDir);

			writer.close();
		} catch (IOException e) {
			System.out.println(
					" caught a " + e.getClass() + "\n with message: " + e.getMessage());
		}
	}

	private static void indexDocs(IndexWriter writer, Path dir)
			throws IOException {
		File directory = dir.toFile();
		File[] files = directory.listFiles();
		for (int i = 0; i < files.length; i++) {
			File f = files[i];
			if (f.isDirectory()) {
				indexDocs(writer, f.toPath());
			} else if (f.getName().endsWith(".txt")) {
				indexDoc(writer, f.toPath());
			}
		}
	}

	private static void indexDoc(IndexWriter writer, Path file)
			throws IOException {
		try (InputStream stream = Files.newInputStream(file)) {
			final BufferedReader reader = new BufferedReader(
					new InputStreamReader(stream));
			String line = null;
			int metadata = 2;
			StringBuffer contents = new StringBuffer();
			String url = null;
			String title = null;
			while ((line = reader.readLine()) != null) {
				if (metadata == 2) {
					url = line;
					--metadata;
				} else if (metadata == 1) {
					title = line;
					--metadata;
				} else {
					contents.append(" " + line);
				}
			}

			if (url == null || title == null) {
				return;
			}

			final Document doc = new Document();

			doc.add(new StringField(IndexConstants.KEY, url, Field.Store.YES));

			doc.add(new TextField(IndexConstants.HEADER, title, TextField.Store.YES));

			doc.add(new TextField(IndexConstants.VALUE, contents.toString(),
					TextField.Store.YES));

			if (writer.getConfig().getOpenMode() == OpenMode.CREATE) {
				System.out.println("Indexing " + file);
				writer.addDocument(doc);
			} else {
				System.out.println("Indexing " + file);
				writer.updateDocument(new Term("path", file.toString()), doc);
			}
		}
	}
}
