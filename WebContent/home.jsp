<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="java.util.List, com.creco.model.Nugget"%>
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
		<form id="postIndex" method="post" action="CrecoServlet">
			<input type="hidden" name="formType" value="search" />
			<div id="postSection">
				<div class="post" tabindex="1">
					<input class="radio" type="radio"
						value="p1|Can inner class access instance variables of outer class?"
						name="posts" id="radio1" onclick="this.form.submit();" /><label
						for="radio1"><span class="num">1</span>Can inner class access instance variables of outer class?</label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p1") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p1");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="2">
					<input class="radio" type="radio"
						value="p2|I was presented with this question in an end of module open book exam today and found myself lost. i was reading Head first Javaand both definitions seemed to be exactly the same. i was just wondering what the MAIN difference was for my own piece of mind. i know there are a number of similar questions to this but, none i have seen which provide a definitive answer.Thanks, Darren"
						name="posts" id="radio2" onclick="this.form.submit();" /><label
						for="radio2"><span class="num">2</span>I was presented with this question in an end
						of module open book exam today and found myself lost. i was
						reading Head first Java and both definitions seemed to be exactly
						the same. i was just wondering what the MAIN difference was for my
						own piece of mind. i know there are a number of similar questions
						to this but, none i have seen which provide a definitive
						answer.Thanks, Darren </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p2") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p2");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="3">
					<input class="radio" type="radio"
						value="p3|Inheritance is when a 'class' derives from an existing 'class'.So if you have a Person class, then you have a Student class that extends Person, Student inherits all the things that Person has.There are some details around the access modifiers you put on the fields/methods in Person, but that's the basic idea.For example, if you have a private field on Person, Student won't see it because its private, and private fields are not visible to subclasses.Polymorphism deals with how the program decides which methods it should use, depending on what type of thing it has.If you have a Person, which has a read method, and you have a Student which extends Person, which has its own implementation of read, which method gets called is determined for you by the runtime, depending if you have a Person or a Student.It gets a bit tricky, but if you do something likePerson p=new Student();p.read();the read method on Student gets called.Thats the polymorphism in action.You can do that assignment because a Student is a Person, but the runtime is smart enough to know that the actual type of p is Student.Note that details differ among languages.You can do inheritance in javascript for example, but its completely different than the way it works in Java."
						name="posts" id="radio3" onclick="this.form.submit();" /><label
						for="radio3"><span class="num">3</span>Inheritance is when a 'class' derives from an
						existing 'class'.So if you have a Person class, then you have a
						Student class that extends Person, Student inherits all the things
						that Person has.There are some details around the access modifiers
						you put on the fields/methods in Person, but that's the basic
						idea.For example, if you have a private field on Person, Student
						won't see it because its private, and private fields are not
						visible to subclasses.Polymorphism deals with how the program
						decides which methods it should use, depending on what type of
						thing it has.If you have a Person, which has a read method, and
						you have a Student which extends Person, which has its own
						implementation of read, which method gets called is determined for
						you by the runtime, depending if you have a Person or a Student.It
						gets a bit tricky, but if you do something likePerson p = new
						Student();p.read();the read method on Student gets called.Thats
						the polymorphism in action.You can do that assignment because a
						Student is a Person, but the runtime is smart enough to know that
						the actual type of p is Student.Note that details differ among
						languages.You can do inheritance in javascript for example, but
						its completely different than the way it works in Java. </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p3") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p3");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="4">
					<input class="radio" type="radio"
						value="p4|Polymorphism: The ability to treat objects of different types in a similar manner.Example: Giraffe and Crocodile are both Animals, and animals can Move.If you have an instance of an Animal then you can call Move without knowing or caring what type of animal it is.Inheritance: This is one way of achieving both Polymorphism and code reuse at the same time.Other forms of polymorphism:There are other way of achieving polymorphism, such as interfaces, which provide only polymorphism but no code reuse (sometimes the code is quite different, such as Move for a Snake would be quite different from Move for a Dog, in which case an Interface would be the better polymorphic choice in this case.In other dynamic languages polymorphism can be achieved with Duck Typing, which is the classes don't even need to share the same base class or interface, they just need a method with the same name.Or even more dynamic like Javascript, you don't even need classes at all, just an object with the same method name can be used polymorphically."
						name="posts" id="radio4" onclick="this.form.submit();" /><label
						for="radio4"><span class="num">4</span>Polymorphism: The ability to treat objects of
						different types in a similar manner.Example: Giraffe and Crocodile
						are both Animals, and animals can Move.If you have an instance of
						an Animal then you can call Move without knowing or caring what
						type of animal it is.Inheritance: This is one way of achieving
						both Polymorphism and code reuse at the same time.Other forms of
						polymorphism:There are other way of achieving polymorphism, such
						as interfaces, which provide only polymorphism but no code reuse
						(sometimes the code is quite different, such as Move for a Snake
						would be quite different from Move for a Dog, in which case an
						Interface would be the better polymorphic choice in this case.In
						other dynamic languages polymorphism can be achieved with Duck
						Typing, which is the classes don't even need to share the same
						base class or interface, they just need a method with the same
						name.Or even more dynamic like Javascript, you don't even need
						classes at all, just an object with the same method name can be
						used polymorphically. </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p4") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p4");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="5">
					<input class="radio" type="radio"
						value="p5|I found out that the above piece of code is perfectly legal in Java. I have the following questions. ThanksAdded one more question regarding Abstract method classes.public class TestClass{public static void main(String[] args) {TestClass t = new TestClass();}private static void testMethod(){abstract class TestMethod{int a;int b;int c;abstract void implementMe();}class DummyClass extends TestMethod{void implementMe(){}}DummyClass dummy = new DummyClass();}}"
						name="posts" id="radio5" onclick="this.form.submit();" /><label
						for="radio5"><span class="num">5</span>I found out that the above piece of code is
						perfectly legal in Java. I have the following questions.
						ThanksAdded one more question regarding Abstract method classes. <pre>
	public class TestClass {
		public static void main(String[] args) {
			TestClass t = new TestClass();
		}
		private static void testMethod() {
			abstract class TestMethod {
				int a;
				int b;
				int c;
				abstract void implementMe();
			}
			class DummyClass extends TestMethod {
				void implementMe() {
				}
			}
			DummyClass dummy = new DummyClass();
		}
	}						
						</pre>
					</label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p5") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p5");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="6">
					<input class="radio" type="radio"
						value="p6|In java it's a bit difficult to implement a deep object copy function. What steps you take to ensure the original object and the cloned one share no reference?"
						name="posts" id="radio6" onclick="this.form.submit();" /><label
						for="radio6"><span class="num">6</span>In java it's a bit difficult to implement a
						deep object copy function. What steps you take to ensure the
						original object and the cloned one share no reference? </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p6") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p6");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="7">
					<input class="radio" type="radio"
						value="p7|You can make a deep copy serialization without creating some files. Copy: Restore:ByteArrayOutputStream bos = new ByteArrayOutputStream();ObjectOutputStream oos = new ObjectOutputStream(bos);oos.writeObject(object);oos.flush();oos.close();bos.close();byte[] byteData = bos.toByteArray();; ByteArrayInputStream bais = new ByteArrayInputStream(byteData);(Object) object = (Object) new ObjectInputStream(bais).readObject();"
						name="posts" id="radio7" onclick="this.form.submit();" /><label
						for="radio7"><span class="num">7</span>You can make a deep copy serialization
						without creating some files. Copy: Restore: <pre>
		
		
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		ObjectOutputStream oos = new ObjectOutputStream(bos);
		oos.writeObject(object);
		oos.flush();
		oos.close();
		bos.close();
		byte[] byteData = bos.toByteArray();
		ByteArrayInputStream bais = new ByteArrayInputStream(byteData);
		(Object) object = (Object) new ObjectInputStream(bais).readObject();						
						</pre>
					</label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p7") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p7");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="8">
					<input class="radio" type="radio"
						value="p8|Java has the ability to create classes at runtime. These classes are known as Synthetic Classes or Dynamic Proxies. See for more information. Other open-source libraries, such as and also allow you to generate synthetic classes, and are more powerful than the libraries provided with the JRE. Synthetic classes are used by AOP (Aspect Oriented Programming) libraries such as Spring AOP and AspectJ, as well as ORM libraries such as Hibernate."
						name="posts" id="radio8" onclick="this.form.submit();" /><label
						for="radio8"><span class="num">8</span>Java has the ability to create classes at
						runtime. These classes are known as Synthetic Classes or Dynamic
						Proxies. See for more information. Other open-source libraries,
						such as and also allow you to generate synthetic classes, and are
						more powerful than the libraries provided with the JRE. Synthetic
						classes are used by AOP (Aspect Oriented Programming) libraries
						such as Spring AOP and AspectJ, as well as ORM libraries such as
						Hibernate. </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p8") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p8");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="9">
					<input class="radio" type="radio"
						value="p9|In short: the web server issues a unique identifier to on his visit. The visitor must bring back that ID for him to be recognised next time around. This identifier also allows the server to properly segregate objects owned by one session against that of another. If is: If is: Once he's on the service mode and on the groove, the servlet will work on the requests from all other clients.Why isn't it a good idea to have one instance per client? Think about this: Will you hire one pizza guy for every order that came? Do that and you'd be out of business in no time. It comes with a small risk though. Remember: this single guy holds all the order information in his pocket: so if you're not cautious about, he may end up giving the wrong order to a certain client."
						name="posts" id="radio9" onclick="this.form.submit();" /><label
						for="radio9"><span class="num">9</span>In short: the web server issues a unique
						identifier to on his visit. The visitor must bring back that ID
						for him to be recognised next time around. This identifier also
						allows the server to properly segregate objects owned by one
						session against that of another. If is: If is: Once he's on the
						service mode and on the groove, the servlet will work on the
						requests from all other clients.Why isn't it a good idea to have
						one instance per client? Think about this: Will you hire one pizza
						guy for every order that came? Do that and you'd be out of
						business in no time. It comes with a small risk though. Remember:
						this single guy holds all the order information in his pocket: so
						if you're not cautious about, he may end up giving the wrong order
						to a certain client. </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p9") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p9");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
				<div class="post" tabindex="10">
					<input class="radio" type="radio"
						value="p10|A safe way is to serialize the object, then deserialize.This ensures everything is a brand new reference.about how to do this efficiently. Caveats: It's possible for classes to override serialization such that new instances are created, e.g. for singletons.Also this of course doesn't work if your classes aren't Serializable."
						name="posts" id="radio10" onclick="this.form.submit();" /><label
						for="radio10"><span class="num">10</span>A safe way is to serialize the object, then
						deserialize.This ensures everything is a brand new reference.about
						how to do this efficiently. Caveats: It's possible for classes to
						override serialization such that new instances are created, e.g.
						for singletons.Also this of course doesn't work if your classes
						aren't Serializable. </label>
				</div>
				<div class="recos">
					<%
						if (request.getAttribute("p10") != null) {
							out.print("<span class=\"from\">From the wikibooks...</span><br />");
							List<Nugget> list = (List<Nugget>) request.getAttribute("p10");
							for (Nugget item : list) {
								out.print("<a href=\"" + item.getUrl() + "\" target=\"_blank\">"
										+ item.getTitle() + "</a>");
								out.print(
										"<div class=\"recoText\">" + item.getContents() + "</div><br />");
							}
						}
					%>
				</div>
			</div>
		</form>
	</div>
</body>
</html>