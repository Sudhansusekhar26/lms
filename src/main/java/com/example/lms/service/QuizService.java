package com.example.lms.service;

import com.example.lms.model.*;
import com.example.lms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class QuizService {

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private QuizSubmissionRepository quizSubmissionRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private AuditLogService auditLogService;

    public Quiz createQuiz(Long courseId, String title, String description, int timeLimitMinutes, int passingScorePct, String instructorEmail, String ip) {
        Course course = courseRepository.findById(courseId).orElseThrow(() -> new IllegalArgumentException("Course not found"));
        Quiz quiz = new Quiz(course, title, description, timeLimitMinutes, passingScorePct);
        Quiz saved = quizRepository.save(quiz);
        auditLogService.log(instructorEmail, "QUIZ_CREATED", "Created quiz: " + title + " (Course: " + course.getTitle() + ")", ip);
        return saved;
    }

    public Question addQuestion(Long quizId, String text, String optA, String optB, String optC, String optD, String correct, int points, String explanation) {
        Quiz quiz = quizRepository.findById(quizId).orElseThrow(() -> new IllegalArgumentException("Quiz not found"));
        Question question = new Question(quiz, text, optA, optB, optC, optD, correct.toUpperCase(), points, explanation);
        return questionRepository.save(question);
    }

    public Optional<Quiz> getQuizById(Long id) {
        return quizRepository.findById(id);
    }

    public List<Quiz> getQuizzesByCourse(Long courseId) {
        return quizRepository.findByCourseId(courseId);
    }

    public List<Quiz> getQuizzesByInstructor(String instructorEmail) {
        return quizRepository.findByCourseInstructorEmail(instructorEmail);
    }

    public List<Quiz> getAllPublishedQuizzes() {
        return quizRepository.findByPublishedTrue();
    }

    @Transactional
    public QuizSubmission evaluateSubmission(Long quizId, String studentEmail, String studentName, Map<String, String> formParams, String ip) {
        Quiz quiz = quizRepository.findById(quizId).orElseThrow(() -> new IllegalArgumentException("Quiz not found"));
        List<Question> questions = questionRepository.findByQuizId(quizId);

        int total = questions.size();
        int correct = 0;

        for (Question q : questions) {
            String submittedAnswer = formParams.get("question_" + q.getId());
            if (submittedAnswer != null && submittedAnswer.equalsIgnoreCase(q.getCorrectAnswer())) {
                correct++;
            }
        }

        int wrong = total - correct;
        double scorePct = total > 0 ? ((double) correct / total) * 100.0 : 0.0;
        String status = scorePct >= quiz.getPassingScorePct() ? "PASS" : "FAIL";

        QuizSubmission submission = new QuizSubmission(quiz, studentEmail, studentName, total, correct, wrong, Math.round(scorePct * 10.0) / 10.0, status);
        QuizSubmission saved = quizSubmissionRepository.save(submission);

        auditLogService.log(studentEmail, "QUIZ_SUBMITTED", "Submitted Quiz: " + quiz.getTitle() + " | Score: " + saved.getScorePct() + "% (" + status + ")", ip);
        return saved;
    }

    public List<QuizSubmission> getSubmissionsByStudent(String studentEmail) {
        return quizSubmissionRepository.findByStudentEmailOrderBySubmittedAtDesc(studentEmail);
    }

    public List<QuizSubmission> getSubmissionsByQuiz(Long quizId) {
        return quizSubmissionRepository.findByQuizIdOrderBySubmittedAtDesc(quizId);
    }

    public List<QuizSubmission> getSubmissionsByInstructor(String instructorEmail) {
        return quizSubmissionRepository.findByQuizCourseInstructorEmailOrderBySubmittedAtDesc(instructorEmail);
    }

    public List<Quiz> getAllQuizzes() {
        return quizRepository.findAll();
    }

    public List<QuizSubmission> getAllSubmissions() {
        return quizSubmissionRepository.findAllByOrderBySubmittedAtDesc();
    }

    @Transactional
    public void deleteQuiz(Long id, String adminEmail, String ip) {
        quizRepository.findById(id).ifPresent(quiz -> {
            quizSubmissionRepository.deleteAll(quizSubmissionRepository.findByQuizIdOrderBySubmittedAtDesc(id));
            questionRepository.deleteAll(questionRepository.findByQuizId(id));
            quizRepository.delete(quiz);
            auditLogService.log(adminEmail, "QUIZ_DELETED", "Deleted quiz: " + quiz.getTitle(), ip);
        });
    }

    public long countTotalSubmissions() { return quizSubmissionRepository.count(); }
    public long countTotalQuizzes() { return quizRepository.count(); }
}
