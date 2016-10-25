package com.creco.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.lucene.queryparser.classic.ParseException;

import com.creco.crawler.Crawler;
import com.creco.indexer.Indexer;
import com.creco.indexer.Searcher;
import com.creco.model.Nugget;

@WebServlet("/CrecoServlet")
public class CrecoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DUMP_LOCATION = "/content";
	private static final String INDEX_LOCATION = "/index";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if ("index".equals(request.getParameter("formType"))) {
			final ServletContext servletContext = this.getServletContext();
			RequestDispatcher reqDispatch = null;
			if ("c.rawl wikibooks".equals(request.getParameter("buttonAction"))) {
				try {
					Crawler.disperse(getServletContext().getRealPath(DUMP_LOCATION));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Indexer.index(getServletContext().getRealPath(DUMP_LOCATION),
						getServletContext().getRealPath(INDEX_LOCATION));
				request.setAttribute("indexed", "TRUE");

				reqDispatch = servletContext.getRequestDispatcher("/index.jsp");
				reqDispatch.forward(request, response);
			}
			if ("Next".equals(request.getParameter("buttonAction"))) {
				reqDispatch = servletContext.getRequestDispatcher("/home.jsp");
				reqDispatch.forward(request, response);
			}
		} else if ("search".equals(request.getParameter("formType"))) {
			String post = request.getParameter("posts");
			String[] parts = post.split("\\|");
			post = parts[1];
			String index = parts[0];
			try {
				List<Nugget> recos = Searcher.search(post,
						getServletContext().getRealPath(INDEX_LOCATION));
				request.setAttribute(index, recos);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			final ServletContext servletContext = this.getServletContext();
			final RequestDispatcher reqDispatch = servletContext
					.getRequestDispatcher("/home.jsp");
			reqDispatch.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
