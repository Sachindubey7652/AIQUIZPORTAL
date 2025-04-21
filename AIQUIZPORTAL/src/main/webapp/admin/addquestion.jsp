<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Question</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* Form Container */
        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        .form-container label {
            display: block;
            font-weight: bold;
            margin-top: 10px;
            color: #333;
        }

        .form-container input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-container input:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .form-container button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-container button:hover {
            background-color: #45a049;
        }

        /* Responsive Design */
        @media screen and (max-width: 600px) {
            .form-container {
                padding: 20px;
            }

            .form-container input, .form-container button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Add Question</h1>
        <form action="AddQuestionServlet" method="POST">
            <label for="questionText">Question:</label>
            <input type="text" id="questionText" name="questionText" placeholder="Enter your question" required>

            <label for="optionA">Option A:</label>
            <input type="text" id="optionA" name="optionA" placeholder="Enter Option A" required>

            <label for="optionB">Option B:</label>
            <input type="text" id="optionB" name="optionB" placeholder="Enter Option B" required>

            <label for="optionC">Option C:</label>
            <input type="text" id="optionC" name="optionC" placeholder="Enter Option C" required>

            <label for="optionD">Option D:</label>
            <input type="text" id="optionD" name="optionD" placeholder="Enter Option D" required>

            <label for="correctAnswer">Correct Answer:</label>
            <input type="text" id="correctAnswer" name="correctAnswer" placeholder="Enter Correct Answer" required>

            <button type="submit">Add Question</button>
        </form>
    </div>
</body>
</html>
