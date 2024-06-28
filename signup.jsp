<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
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
        .input-group input, .input-group select {
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
        <h2>User Sign Up</h2>
        <form action="" method="post" id="form">
            <div class="input-group">
                <label for="username">Name</label>
                <input type="text" id="username" name="username" required/>
            </div>
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required/>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required/>
            </div>
            <div class="input-group">
                <label for="gender">Gender</label>
                <input type="text" id="gender" name="gender" required/>
            </div>
            <div class="input-group">
                <label for="age">Age</label>
                <input type="number" id="age" name="age" required/>
            </div>
            <button type="submit" class="btn-submit" name="sign">Register</button>
            <div class="login-signup">
                <span>Already a member? <a href="login.jsp">Login Now</a></span>
            </div>
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String username = request.getParameter("username");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String gender = request.getParameter("gender");
                    int age = Integer.parseInt(request.getParameter("age"));

                    String JDBC_URL = "jdbc:mysql://localhost:3306/logindetails";
                    String DB_USERNAME = "root";
                    String DB_PASSWORD = "";

                    Connection conn = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

                        String checkQuery = "SELECT * FROM admin WHERE email=?";
                        PreparedStatement  pstmt = conn.prepareStatement(checkQuery);
                        pstmt.setString(1, email);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next()) {
                            out.println("<p class='error-msg'>Account already exists</p><br><a href='login.jsp'>Try logging here</a>");
                        } else {
                            String insertQuery = "INSERT INTO admin(name, email, password, gender, age, status) VALUES (?, ?, ?, ?, ?, 1)";
                            pstmt = conn.prepareStatement(insertQuery);
                            pstmt.setString(1, username);
                            pstmt.setString(2, email);
                            pstmt.setString(3, password);
                            pstmt.setString(4, gender);
                            pstmt.setInt(5, age);

                            int rowsAffected = pstmt.executeUpdate();
                            if (rowsAffected > 0) {
                                response.sendRedirect("login.jsp");
                            } else {
                                out.println("<p class='error-msg'>Registration failed. Please try again.</p>");
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
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
