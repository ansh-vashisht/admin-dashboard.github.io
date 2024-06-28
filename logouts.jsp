<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: antiquewhite;
            margin: 0;
            padding: 0;
        }

        .card {
          background-color: #c2ffc5;
            width: 500px;
            height: 300px;
            margin: 100px auto;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .card h1 {
            color: #2A2C30;
            text-align: center;
            margin-bottom: 20px;
        }

        .card p {
            color: #000000;
            text-align: center;
            font-size: 20px;
            line-height: 1.6;
        }

        .home {
            display: block;
            text-align: center;
            color: #2A2C30;
            margin-top: 20px;
            text-decoration: none;
        }

        .home:hover {
            color: #2A2C30;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>Thank You</h1>
        
        <p>We will contact you soon for further procedures.</p>
        <a href="dashboard.jsp" class="home">Return to Home</a>
    </div>
</body>
</html>