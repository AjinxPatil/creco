<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style/font.css">
<link rel="stylesheet" type="text/css" href="style/design.css">
<title>c.reco</title>
</head>
<body>
	<div id="header">
		<h2>
			c.<b>reco</b>
		</h2>
		<h4>a peek at wikibooks recommender for stackoverflow</h4>
	</div>
	<div id="bodyContent">
		<div id="info1">
			<p>
				This is an example of a <b>c</b>ontent-based <b>reco</b>mmender. It
				lists "relevant" and "related" items from the <a
					href="https://en.wikibooks.org/wiki/Java_Programming"
					target="_blank"><i>Java Programming</i></a> wikibooks.
			</p>
			<p>This application will first crawl the pages of the wikibooks.
				Then it indexes the information. Both these activities can be done
				now before you can start seeing recommendations for stackoverflow
				posts. Click on button below and sit back for few seconds till
				hundreds of wikibooks pages are crawled and indexed.</p>
		</div>
		<div id="box">
			<form id="postSearch" method="post" action="CrecoServlet">
				<input type="hidden" name="formType" value="index" /> <br />
				<div class="centerBoxes">
					<%
						if (request.getAttribute("indexed") == null) {
					%>
					<input class="button" type="submit" name="buttonAction"
						value="c.rawl wikibooks" />
				</div>
				<div class="centerBoxes">
					<%
						}
					%>
					<%
						if (request.getAttribute("indexed") == "TRUE") {
					%>
					<span style="color: #0000ff; line-height: 60px;">wikibooks
						is crawled and indexed. Proceed for the main action.</span><br /> <input
						class="button" type="submit" name="buttonAction" value="Next" />
					<%
						}
					%>
				</div>
			</form>
		</div>
		<div id="info2">
			<h4>
				read<b>me</b>
			</h4>
			<ul>
				<li>c.reco is written in Java; it crawls using the jsoup
					library and, indexes and searches using the Lucene search engine
					library.</li>
				<li>c.reco crawls each web page of Java Programming wikibooks
					and cherry picks items which are "concepts" from each page. Each
					concept is instance of <code>Nugget</code> class that contains the
					concept title, URL and contents. The <code>Crawler.scavenge()</code>
					method identifies and picks up relevant DOM elements from each page
					to group data in "nuggets". It crawls text as well as code.
				</li>
				<li>c.reco indexes each nugget with the nugget's URL (unique by
					path and HTML bookmarks) as key. In indexing by concept, multiple
					concepts (i.e. nuggets) are stored in index.</li>
				<li>c.reco fine tunes indexing by storing multiple Index
					Document objects per page that also includes any code segment
					present on pages.</li>
				<li>Check <a href="readme.txt" target="_blank">instructions</a>
					for using c.reco
				</li>
		</div>
	</div>
</body>
</html>