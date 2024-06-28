<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("email");

    String JDBC_URL = "jdbc:mysql://localhost:3306/logindetails";
    String DB_USERNAME = "root";
    String DB_PASSWORD = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

        String checkStatusQuery = "SELECT status FROM admin WHERE email = ?";
        pstmt = conn.prepareStatement(checkStatusQuery);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int status = rs.getInt("status");

            if (status == 0) {
              
                response.sendRedirect("logouts.jsp");
            } else {
               
                String updateStatusQuery = "UPDATE admin SET status = 0 WHERE email = ?";
                pstmt = conn.prepareStatement(updateStatusQuery);
                pstmt.setString(1, email);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    session.invalidate();
                    response.sendRedirect("login.jsp");
                } else {
                    out.println("<p class='error-msg'>Logout failed. Please try again.</p>");
                }
            }
        } else {
            out.println("<p class='error-msg'>User not found.</p>");
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
%>
