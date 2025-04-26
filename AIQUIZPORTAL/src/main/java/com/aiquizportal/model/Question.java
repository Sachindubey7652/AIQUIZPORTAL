package com.aiquizportal.model;

public class Question {
    private int questionId;  // maps to id in DB
    private int quizId;
    private String questionText;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correctAnswer;

    public Question() {}

    public Question(int questionId, int quizId, String questionText,
                    String optionA, String optionB,
                    String optionC, String optionD,
                    String correctAnswer) {
        this.questionId   = questionId;
        this.quizId       = quizId;
        this.questionText = questionText;
        this.optionA      = optionA;
        this.optionB      = optionB;
        this.optionC      = optionC;
        this.optionD      = optionD;
        this.correctAnswer= correctAnswer;
    }
    public Question(int quizId, String questionText, String optionA, String optionB, String optionC, String optionD, String correctAnswer) {
        this.quizId = quizId;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctAnswer = correctAnswer;
    }


    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    @Override
    public String toString() {
        return "Question{" +
               "questionId=" + questionId +
               ", quizId=" + quizId +
               ", questionText='" + questionText + '\'' +
               ", optionA='" + optionA + '\'' +
               ", optionB='" + optionB + '\'' +
               ", optionC='" + optionC + '\'' +
               ", optionD='" + optionD + '\'' +
               ", correctAnswer='" + correctAnswer + '\'' +
               '}';
    }
}
