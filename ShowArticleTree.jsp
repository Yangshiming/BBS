<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*"  %>


<%!
String str = null;
private void tree(Connection conn, int pid, int level)
{
	Statement stmt = null;
	ResultSet rs = null;
	
	String prStr = "";
	String sqlString = "select * from article where pid=" + pid;
	for(int i = 0;i< level;i++){
		prStr += "----";
	}
	
	try{
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sqlString);
		while(rs.next()){
			str += "<tr><td>" + rs.getInt("id") + "</td><td>" + prStr + "<a href='ShowArticleDetail.jsp?id="+rs.getInt("id")+"'>"+ rs.getString("title")+"</a>" + "</td><tr>";
			if(rs.getInt("isleaf") == 1){
				tree(conn, rs.getInt("id"), level+1);
			}
		} 
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		
			try{
				if(rs != null){
					rs.close();
					rs = null;
				}
				if(stmt != null){
					stmt.close();
					stmt = null;
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
	}
}
%>

<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&PASSWORD=";
Connection  conn = DriverManager.getConnection(url);

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from article where pid=0");

while(rs.next()){
	str +="<tr><td>" + rs.getInt("id") + "</td><td>" +"<a href='ShowArticleDetail.jsp?id="+rs.getInt("id")+"'>"+ rs.getString("title")+"</a>"+ "</td><tr>";
	if(rs.getInt("isleaf") == 1){
		tree(conn, rs.getInt("id"), 1);
	}
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

<table border="1">
<%= str %>
</table>


</body>

<%
rs.close();
stmt.close();
conn.close();

%>
</html> 
