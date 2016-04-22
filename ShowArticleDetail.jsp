<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"  %>

<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&PASSWORD=";
Connection  conn = DriverManager.getConnection(url);

Statement stmt = conn.createStatement();
String str=request.getParameter("id");
int ID = Integer.parseInt(str);
ResultSet rs = stmt.executeQuery("select * from article where id="+ ID);

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<table border="1">
<%
if(rs.next()){
%>
	<tr>
		<td>ID</td>  <td><%= rs.getInt("id") %></td>
	</tr>
	<tr>
		<td>title</td>  <td><%= rs.getString("title") %></td>
	</tr>
	<tr>
		<td>content</td>  <td><%= rs.getString("cont") %></td>
	</tr>

<%	
}
%>

<%
rs.close();
stmt.close();
conn.close();
%>
</table>
</body>
</html>
