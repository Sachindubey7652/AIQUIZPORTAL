<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Registration</title>
</head>
<body>
    <h2>Register</h2>

    <form action="register" method="post">
        <label>Name:</label><br>
        <input type="text" name="name" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button type="submit">Register</button>
    </form>

    <p style="color: green;">
        <%= request.getParameter("success") != null ? "Registration successful. Please login." : "" %>
    </p>
    <p style="color: red;">
        <%= request.getParameter("error") != null ? "Registration failed. Try again." : "" %>
    </p>

    <p>Already registered? <a href="login.jsp">Login here</a></p>
</body>
</html>
