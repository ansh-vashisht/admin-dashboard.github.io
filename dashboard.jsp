<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Page</title>
    <style>
        body {
            background-color: antiquewhite;
            text-align: center;
        }
        a {
            display: inline-block;
            font-size: 20px;
            background: lightgreen;
            padding: 10px 30px;
            text-decoration: none;
            font-weight: 500;
            margin: 10px;
            color: blue;
            letter-spacing: 2px;
        }
        a:hover {
            letter-spacing: 6px;
        }
        p{
        font-size: xx-large;
        }
    </style>
</head>
<body>
<%  String password = "";
    String user = "root";
     String url = "jdbc:mysql://localhost:3306/logindetails";
     Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            out.println();
        } catch (SQLException e) {
            out.println();
        } finally {
            if (con != null) {
                try {
                    con.close();                
                } catch (SQLException e) {
                    out.println();
                }
            }
        }
%>

    <div>
        <p><b>Welcome</b></p>
        <p>Choose one of the options below:</p>
        <a href="signup.jsp">SignUp</a>
        <a href="login.jsp">Login</a>
    </div>
</body>
</html>
