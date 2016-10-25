package com.creco.crawler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.lucene.queryparser.classic.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.creco.model.Nugget;

public class Crawler {
	private static final String SOURCE = "en.wikibooks.org/wiki/Java_Programming";
	private static final String BASE_URI = "https://en.wikibooks.org/wiki/Java_Programming";
	private static Set<String> visitedUris;

	public static void disperse(String dumpDirectory)
			throws IOException, ParseException {
		visitedUris = new HashSet<String>();
		crawl(BASE_URI, dumpDirectory);
	}

	public static void crawl(String url, String dumpDirectory)
			throws IOException {

		// TODO use regex, add blacklist
		if (url.contains(".pdf") || url.contains("@") || url.contains(":8")
				|| url.contains(".jpg") || !url.contains(SOURCE) || url.contains("#")
				|| url.contains("Print_version") || url.contains("Development_stages")
				|| url.contains("Conventions")) {
			return;
		}

		final Document doc = Jsoup.connect(url).ignoreHttpErrors(true).get();

		BufferedWriter writer = null;
		if (!BASE_URI.equals(url)) {
			final List<Nugget> nuggets = scavenge(doc, url);
			for (Nugget nugget : nuggets) {
				if (!nugget.getContents().isEmpty()) {
					final Path path = Paths.get(
							dumpDirectory + File.separator + nugget.getFileName() + ".txt");
					if (!path.toFile().exists()) {
						if (!Files.exists(path.toFile().getParentFile().toPath())) {
							Files.createDirectories(path.toFile().getParentFile().toPath());
						}
						Files.createFile(path);
					}
					writer = Files.newBufferedWriter(path);
					writer.write(nugget.getUrl() + "\n" + nugget.getTitle() + "\n"
							+ nugget.getContents());
					writer.close();
				}
			}
		}

		Elements links = null;
		Elements selects = null;
		if (BASE_URI.equals(url)) {
			int contentIndex = doc.getElementById("Contents").parent()
					.elementSiblingIndex();
			selects = doc.getElementsByIndexGreaterThan(contentIndex);
			links = selects.select("a[href]");
		} else {
			links = doc.select("#mw-content-text a[href]");
		}

		for (Element link : links) {
			String href = link.attr("abs:href");
			if (!visitedUris.contains(href)) {
				visitedUris.add(href);
				crawl(href, dumpDirectory);
			}
		}
	}

	public static List<Nugget> scavenge(final Document doc, final String url) {
		Element root = doc.getElementById("mw-content-text");
		Elements parts = root.children();
		boolean isIntro = true;
		boolean isFirst = true;
		StringBuffer intro = new StringBuffer();
		String mainTitle = doc.getElementById("firstHeading").text();
		String header = null;
		StringBuffer contents = new StringBuffer();
		// int codeCount = 0;
		List<Nugget> nuggets = new ArrayList<Nugget>();
		for (Element part : parts) {
			String tag = part.tagName();
			if (isIntro) {
				if (("p".equals(tag) || "table".equals(tag))) {
					if ("p".equals(tag)) {
						intro.append(part.text());
					} else if ("table".equals(tag)) {
						Elements codeBlock = part.getElementsByTag("pre");
						if (!codeBlock.isEmpty()) {
							StringBuffer code = new StringBuffer();
							Elements spans = codeBlock.first().children();
							for (Element line : spans) {
								if (!line.hasClass("lineno")) {
									code.append("\n" + line.text());
								}
							}
							intro.append(code);
						}
					}
					continue;
				}
			}

			if ("h2".equals(part.tagName())) {
				if (isFirst) {
					String file = mainTitle.replaceAll("[\\W]", "_") + "\\"
							+ mainTitle.replaceAll("[\\W]", "_");
					nuggets.add(new Nugget(url, mainTitle, file, intro.toString()));
					isIntro = false;

					header = part.getElementsByClass("mw-headline").first().text();
					isFirst = false;
					continue;
				}
				String partUrl = url + "#" + header.replace(" ", "_");
				String file = mainTitle.replaceAll("[\\W]", "_") + "\\"
						+ header.replaceAll("[\\W]", "_");
				nuggets.add(new Nugget(partUrl, mainTitle + " - " + header, file,
						contents.toString()));
				contents = new StringBuffer("");
				header = part.getElementsByClass("mw-headline").first().text();
				continue;
			}

			if ("p".equals(tag)) {
				contents.append(part.text());
			}

			if ("table".equals(tag)) {
				Elements codeBlock = part.getElementsByTag("pre");
				if (!codeBlock.isEmpty()) {
					StringBuffer code = new StringBuffer();
					Elements spans = codeBlock.first().children();
					for (Element line : spans) {
						if (!line.hasClass("lineno")) {
							code.append("\n" + line.text());
						}
					}
					contents.append(code);
				}
			}
		}
		if (header != null && !header.isEmpty()) {
			String partUrl = url + "#" + header.replace(" ", "_");
			String file = mainTitle.replaceAll("[\\W]", "_") + "\\"
					+ header.replaceAll("[\\W]", "_");
			nuggets.add(new Nugget(partUrl, header, file, contents.toString()));
		}
		return nuggets;
	}
}
