<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: lightgreen;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .container h2 {
            text-align: center;
            color: #333;
        }
        .input-group {
            margin-bottom: 20px;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .input-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .btn-submit {
            background-color: #06C167;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #049a5c;
        }
        .login-signup {
            text-align: center;
            margin-top: 20px;
        }
        .login-signup a {
            color: #06C167;
            font-weight: bold;
            text-decoration: none;
        }
        .error-msg {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>User Login</h2>
        <form action="" method="post" id="form">
            <div class="input-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" required/>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required/>
            </div>
            <button type="submit" class="btn-submit" name="sign">Login</button>
            <div class="login-signup">
                <span>Don't have an account? <a href="signup.jsp">Sign Up Now</a></span>
            </div>
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    String JDBC_URL = "jdbc:mysql://localhost:3306/logindetails";
                    String DB_USERNAME = "root";
                    String DB_PASSWORD = "";

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

                        String query = "SELECT * FROM admin WHERE email=?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, email);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String dbPassword = rs.getString("password");
                            int status = rs.getInt("status");

                            if (password.equals(dbPassword)) {
                                if (status == 1) {
                                    session.setAttribute("email", email);
                                    session.setAttribute("name", rs.getString("name"));
                                    session.setAttribute("id", rs.getInt("id"));
                                    response.sendRedirect("admin.jsp");
                                } else {
                                    out.println("<p class='error-msg'>Account is not active. Please contact support.</p>");
                                }
                            } else {
                                out.println("<p class='error-msg'>Incorrect password. Try again.</p>");
                            }
                        } else {
                            out.println("<p class='error-msg'>Account does not exist.</p>");
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </form>
    </div>
</body>
</html>
