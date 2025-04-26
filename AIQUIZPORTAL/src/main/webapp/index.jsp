<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AI Quiz Portal</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #1c92d2, #f2fcfe);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        h1 {
            font-size: 3rem;
            color: #fff;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px #00000055;
        }
        .button-group {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }
        a {
            padding: 12px 28px;
            background: #007bff;
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        a:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }
        @media (max-width: 500px) {
            h1 {
                font-size: 2rem;
            }
            a {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <h1>Welcome to AI Quiz Portal</h1>
    <div class="button-group">
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    </div>
</body>
</html>
