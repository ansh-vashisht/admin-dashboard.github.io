<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Details</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: antiquewhite;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: honeydew;
            border-radius: 8px;
        }
        .container h2 {
            text-align: center;
            color: #333;
        }
        .header {
            background-color: #06C167;
            padding: 10px;
            color: white;
            text-align: right;
            margin-bottom: 20px;
        }
        .header p {
            margin: 0;
            font-size: 24px;
        }
        .header a {
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
        .chart-container {
            width: 100%;
            text-align: center;
            margin-bottom: 20px;
        }
        .bar-chart {
            width: 600px; 
             height: 400px;
            margin: 0 auto;
        }
        .pie-chart {
            width: 400px; 
            height: 400px; 
            margin: 0 auto;
        }
    </style>
</head>
<body>

<div class="header">
    <p>Welcome <%= session.getAttribute("name") %>!</p>
    <a href="Logout.jsp">Logout</a>
</div>

<div class="container">
    <h2>User Gender Distribution</h2>
    <div class="chart-container">
        <canvas id="genderChart" class="bar-chart"></canvas>
    </div>
    
    <h2>User Age Distribution</h2>
    <div class="chart-container">
        <canvas id="ageChart" class="pie-chart"></canvas>
    </div>
</div>

<%
    String JDBC_URL = "jdbc:mysql://localhost:3306/logindetails";
    String DB_USERNAME = "root";
    String DB_PASSWORD = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int maleCount = 0;
    int femaleCount = 0;
    Map<String, Integer> ageMap = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

        String queryMale = "SELECT count(*) AS count FROM admin WHERE gender='male'";
        pstmt = conn.prepareStatement(queryMale);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            maleCount = rs.getInt("count");
        }

        String queryFemale = "SELECT count(*) AS count FROM admin WHERE gender='female'";
        pstmt = conn.prepareStatement(queryFemale);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            femaleCount = rs.getInt("count");
        }
        String queryAge = "SELECT age, count(*) AS count FROM admin GROUP BY age";
        pstmt = conn.prepareStatement(queryAge);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            int age = rs.getInt("age");
            int count = rs.getInt("count");
            ageMap.put(Integer.toString(age), count);
        }

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) 
            	rs.close();
            if (pstmt != null) 
            	pstmt.close();
            if (conn != null) 
            	conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<script>
    var genderCtx = document.getElementById('genderChart').getContext('2d');
    var genderChart = new Chart(genderCtx, {
        type: 'bar',
        data: {
            labels: ['Male', 'Female'],
            datasets: [{
                label: 'User Gender Distribution',
                data: [<%= maleCount %>, <%= femaleCount %>],
                backgroundColor: ['rgba(54, 162, 235, 0.6)', 'rgba(255, 99, 132, 0.6)'],
                borderColor: ['rgba(54, 162, 235, 1)', 'rgba(255, 99, 132, 1)'],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });

    var ageCtx = document.getElementById('ageChart').getContext('2d');
    var ageChart = new Chart(ageCtx, {
        type: 'pie',
        data: {
            labels: [<%
                boolean first = true;
                for (String age : ageMap.keySet()) {
                    if (!first) out.print(",");
                    out.print("\"" + age + "\"");
                    first = false;
                }
            %>],
            datasets: [{
                label: 'User Age Distribution',
                data: [<%
                    boolean firstCount = true;
                    for (int count : ageMap.values()) {
                        if (!firstCount) out.print(",");
                        out.print(count);
                        firstCount = false;
                    }
                %>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.6)',
                    'rgba(54, 162, 235, 0.6)',
                    'rgba(255, 206, 86, 0.6)',
                    'rgba(75, 192, 192, 0.6)'
                ],
                borderWidth: 1
            }]
        },
    });
</script>

</body>
</html>
