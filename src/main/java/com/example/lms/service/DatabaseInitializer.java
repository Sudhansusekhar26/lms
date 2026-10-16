package com.example.lms.service;

import com.example.lms.model.*;
import com.example.lms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.*;

@Component
public class DatabaseInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private VerifiedRegistrationRepository verifiedRegistrationRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private SectionRepository sectionRepository;

    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private QuizSubmissionRepository quizSubmissionRepository;

    @Autowired
    private LessonProgressRepository lessonProgressRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private LiveClassRepository liveClassRepository;

    @Autowired
    private AnnouncementRepository announcementRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    static class ModuleDef {
        String title;
        String[] topics;

        ModuleDef(String title, String... topics) {
            this.title = title;
            this.topics = topics;
        }
    }

    @Override
    public void run(String... args) {
        try {
            // 1. Seed Pre-approved Verified Registration Numbers in MySQL Table
            if (verifiedRegistrationRepository.count() == 0) {
                VerifiedRegistration vrAdm = new VerifiedRegistration("ADM-2026-001", "ROLE_ADMIN", "System Admin", "Central IT");
                vrAdm.setUsed(true);
                vrAdm.setUsedByEmail("admin@lms.com");
                verifiedRegistrationRepository.save(vrAdm);

                VerifiedRegistration vrFac0 = new VerifiedRegistration("FAC-2026-500", "ROLE_FACULTY", "Prof. Alan Turing", "Computer Systems");
                vrFac0.setUsed(true);
                vrFac0.setUsedByEmail("faculty@lms.com");
                verifiedRegistrationRepository.save(vrFac0);

                VerifiedRegistration vrStu0 = new VerifiedRegistration("STU-2026-100", "ROLE_STUDENT", "Alex Johnson", "Software Engineering");
                vrStu0.setUsed(true);
                vrStu0.setUsedByEmail("student@lms.com");
                verifiedRegistrationRepository.save(vrStu0);

                verifiedRegistrationRepository.save(new VerifiedRegistration("STU-2026-101", "ROLE_STUDENT", "Student Candidate 1", "Programming"));
                verifiedRegistrationRepository.save(new VerifiedRegistration("STU-2026-102", "ROLE_STUDENT", "Student Candidate 2", "Backend Development"));
                verifiedRegistrationRepository.save(new VerifiedRegistration("STU-2026-103", "ROLE_STUDENT", "Student Candidate 3", "Full Stack"));
                verifiedRegistrationRepository.save(new VerifiedRegistration("STU-2026-104", "ROLE_STUDENT", "Student Candidate 4", "Computer Science"));
                verifiedRegistrationRepository.save(new VerifiedRegistration("STU-2026-105", "ROLE_STUDENT", "Student Candidate 5", "Database Engineering"));

                verifiedRegistrationRepository.save(new VerifiedRegistration("FAC-2026-501", "ROLE_FACULTY", "Dr. James Gosling", "Java Technologies"));
                verifiedRegistrationRepository.save(new VerifiedRegistration("FAC-2026-502", "ROLE_FACULTY", "Prof. Donald Knuth", "Algorithms"));
                verifiedRegistrationRepository.save(new VerifiedRegistration("FAC-2026-503", "ROLE_FACULTY", "Dr. Barbara Liskov", "Distributed Systems"));
            }

            // 2. Seed Default Users
            // 2. Seed Default Users with Complete Profiles
            Optional<UserMaster> adminOpt = userRepository.findByEmail("admin@lms.com");
            UserMaster admin = adminOpt.orElseGet(() -> new UserMaster("admin@lms.com", passwordEncoder.encode("admin123"), "ROLE_ADMIN", "System Administrator", "+91 98765 00001", "ADM-2026-001"));
            admin.setStatus("ACTIVE");
            admin.setBio("Chief Systems Administrator overseeing LMS curriculum, infrastructure, and institutional security governance.");
            admin.setDob("1980-01-15");
            admin.setGender("Male");
            admin.setAddress("Administrative Block, Floor 3, Innovation Campus");
            admin.setCity("Bhubaneswar");
            admin.setState("Odisha");
            admin.setCountry("India");
            admin.setDepartment("Central IT & Academic Operations");
            admin.setDesignation("Chief Administrator");
            if (admin.getLastLogin() == null) admin.setLastLogin(LocalDateTime.now().minusHours(2));
            userRepository.save(admin);

            Optional<UserMaster> facultyOpt = userRepository.findByEmail("faculty@lms.com");
            UserMaster faculty = facultyOpt.orElseGet(() -> new UserMaster("faculty@lms.com", passwordEncoder.encode("faculty123"), "ROLE_FACULTY", "Prof. Alan Turing", "+91 98765 12345", "FAC-2026-500"));
            faculty.setStatus("ACTIVE");
            faculty.setBio("Senior Professor of Computer Systems & Software Architecture with specialization in Distributed Cloud Computing and AI Systems.");
            faculty.setDob("1985-06-23");
            faculty.setGender("Male");
            faculty.setAddress("Staff Quarters Q-12, Green Hills University Campus");
            faculty.setCity("Bhubaneswar");
            faculty.setState("Odisha");
            faculty.setCountry("India");
            faculty.setDepartment("Computer Science & Engineering");
            faculty.setDesignation("Professor");
            faculty.setQualification("Ph.D. in Computer Science (MIT), M.Tech (Distinction)");
            faculty.setSpecialization("Cloud Architecture, Distributed Systems, Java Enterprise & AI");
            faculty.setExperience("12+ Years");
            faculty.setJoiningDate("2018-07-01");
            if (faculty.getLastLogin() == null) faculty.setLastLogin(LocalDateTime.now().minusHours(1));
            userRepository.save(faculty);

            Optional<UserMaster> studentOpt = userRepository.findByEmail("student@lms.com");
            UserMaster student = studentOpt.orElseGet(() -> new UserMaster("student@lms.com", passwordEncoder.encode("student123"), "ROLE_STUDENT", "Alex Johnson", "+91 98765 43210", "STU-2026-100"));
            student.setStatus("ACTIVE");
            student.setBio("Aspiring Cloud Architect & Software Engineer passionate about Java Spring Boot, Microservices, and Distributed Systems.");
            student.setDob("2003-05-15");
            student.setGender("Male");
            student.setAddress("Hostel Block H-4, Room 302, University Campus");
            student.setCity("Bhubaneswar");
            student.setState("Odisha");
            student.setCountry("India");
            student.setRollNumber("CSE-2023-042");
            student.setProgram("B.Tech CSE");
            student.setDepartment("Department of Computer Science & Engineering");
            student.setSemester("6th Semester");
            student.setAcademicYear("3rd Year");
            student.setBatch("2023 - 2027");
            student.setSection("Section A");
            if (student.getLastLogin() == null) student.setLastLogin(LocalDateTime.now().minusMinutes(30));
            userRepository.save(student);

            // 3. Ensure Academic Categories Exist
            Map<String, Category> catMap = new HashMap<>();
            String[][] categoriesData = {
                    {"Programming", "Core coding languages and algorithmic problem solving foundations.", "fa-code"},
                    {"Backend Development", "Server-side architectures, REST APIs, databases, and microservices.", "fa-server"},
                    {"Web Development", "Frontend engineering, responsive UI design, and modern JavaScript.", "fa-globe"},
                    {"Database", "Relational SQL databases, queries, indexing, and transactional integrity.", "fa-database"},
                    {"Computer Science", "Data structures, algorithms, complexity analysis, and computing theory.", "fa-microchip"},
                    {"Full Stack", "End-to-end full stack software development and cloud deployment.", "fa-layer-group"},
                    {"Development Tools", "Version control, Git, GitHub workflows, CI/CD, and productivity tools.", "fa-screwdriver-wrench"},
                    {"Software Engineering", "SDLC, STLC, manual & automated testing, and quality assurance.", "fa-vial-circle-check"}
            };

            for (String[] cat : categoriesData) {
                Category c = categoryRepository.findByName(cat[0]).orElseGet(() -> categoryRepository.save(new Category(cat[0], cat[1], cat[2])));
                catMap.put(cat[0], c);
            }

            // 4. Safely Remove any old legacy courses before the 10 defined courses
            Set<String> validCourseTitles = new HashSet<>(Arrays.asList(
                    "Java Programming",
                    "Advanced Java & JDBC",
                    "Spring Boot Development",
                    "Web Development",
                    "JavaScript Programming",
                    "SQL & MySQL Database",
                    "Data Structures & Algorithms",
                    "Full Stack Java Development",
                    "Git & GitHub",
                    "Software Testing"
            ));

            List<Course> existingCourses = courseRepository.findAll();
            for (Course ec : existingCourses) {
                if (!validCourseTitles.contains(ec.getTitle())) {
                    try {
                        lessonProgressRepository.deleteAll(lessonProgressRepository.findByCourseId(ec.getId()));
                        enrollmentRepository.deleteAll(enrollmentRepository.findByCourseId(ec.getId()));
                        liveClassRepository.deleteAll(liveClassRepository.findByCourseIdOrderByScheduledAtAsc(ec.getId()));

                        List<Quiz> quizzes = quizRepository.findByCourseId(ec.getId());
                        for (Quiz q : quizzes) {
                            quizSubmissionRepository.deleteAll(quizSubmissionRepository.findByQuizIdOrderBySubmittedAtDesc(q.getId()));
                            questionRepository.deleteAll(questionRepository.findByQuizId(q.getId()));
                            quizRepository.delete(q);
                        }

                        List<Section> sections = sectionRepository.findByCourseIdOrderByOrderNumAsc(ec.getId());
                        for (Section s : sections) {
                            lessonRepository.deleteAll(lessonRepository.findBySectionIdOrderByOrderNumAsc(s.getId()));
                            sectionRepository.delete(s);
                        }

                        courseRepository.delete(ec);
                    } catch (Exception ex) {
                        System.err.println("Could not delete legacy course " + ec.getTitle() + ": " + ex.getMessage());
                    }
                }
            }

            // 5. Seed the 10 Defined Academic Courses with Individual Lessons per Sub-topic
            String instructorEmail = "faculty@lms.com";
            String instructorName = "Prof. Alan Turing";

            // ----------------------------------------------------
            // 1. Java Programming — 8 Weeks
            // ----------------------------------------------------
            ModuleDef[] javaModules = new ModuleDef[]{
                    new ModuleDef("Module 1: Introduction to Java", "Java features", "JDK, JRE, JVM", "Installation & first program"),
                    new ModuleDef("Module 2: Java Basics", "Variables & data types", "Operators", "Input/output", "Type casting"),
                    new ModuleDef("Module 3: Control Statements", "if/else", "switch", "for, while, do-while", "break & continue"),
                    new ModuleDef("Module 4: Arrays & Strings", "1D/2D arrays", "String", "StringBuilder", "StringBuffer"),
                    new ModuleDef("Module 5: OOP Concepts", "Class & Object", "Constructor", "Inheritance", "Polymorphism", "Encapsulation", "Abstraction"),
                    new ModuleDef("Module 6: Exception Handling", "try/catch", "finally", "throw/throws", "Custom exceptions"),
                    new ModuleDef("Module 7: Collections", "ArrayList", "LinkedList", "HashSet", "HashMap", "Iterator"),
                    new ModuleDef("Module 8: Practice & Project", "Coding problems", "Mini Java project")
            };
            seedCourse(
                    "Java Programming",
                    "Learn Java fundamentals, OOP, exception handling, collections and basic problem solving.",
                    "8 Weeks", "Beginner", "Free",
                    "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Programming"), instructorEmail, instructorName, javaModules,
                    "Java Programming Certification Assessment",
                    "Live Workshop: Solving Java OOP & Collections Coding Challenges"
            );

            // ----------------------------------------------------
            // 2. Advanced Java & JDBC — 8 Weeks
            // ----------------------------------------------------
            ModuleDef[] advJavaModules = new ModuleDef[]{
                    new ModuleDef("Module 1: Advanced Java Introduction", "JDBC", "Servlets", "JSP", "Web application architecture"),
                    new ModuleDef("Module 2: JDBC", "JDBC architecture", "Connection", "Statement", "PreparedStatement", "ResultSet"),
                    new ModuleDef("Module 3: Database Operations", "INSERT", "UPDATE", "DELETE", "SELECT", "CRUD operations"),
                    new ModuleDef("Module 4: Servlets", "Servlet lifecycle", "doGet()", "doPost()", "Request & Response", "Session management"),
                    new ModuleDef("Module 5: JSP", "JSP basics", "Scriptlets", "JSP directives", "Expression Language", "JSTL"),
                    new ModuleDef("Module 6: MVC Architecture", "Model", "View", "Controller", "DAO pattern"),
                    new ModuleDef("Module 7: Authentication", "Registration", "Login/logout", "Sessions", "Form validation"),
                    new ModuleDef("Module 8: Mini Project", "Java + JSP + Servlet + MySQL project")
            };
            seedCourse(
                    "Advanced Java & JDBC",
                    "Learn JDBC, Servlets, JSP, database connectivity and web application development using Java.",
                    "8 Weeks", "Intermediate", "Free",
                    "https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Backend Development"), instructorEmail, instructorName, advJavaModules,
                    "Advanced Java & JDBC Evaluation",
                    "Live Masterclass: Architecting Web MVC with Servlets & JDBC"
            );

            // ----------------------------------------------------
            // 3. Spring Boot Development — 10 Weeks
            // ----------------------------------------------------
            ModuleDef[] springBootModules = new ModuleDef[]{
                    new ModuleDef("Module 1: Spring & Spring Boot Introduction", "Spring Framework", "Spring Boot", "Project structure", "Maven"),
                    new ModuleDef("Module 2: Dependency Injection", "IoC", "DI", "Beans", "Component scanning"),
                    new ModuleDef("Module 3: Spring MVC", "Controller", "Service", "Repository", "Request/Response"),
                    new ModuleDef("Module 4: REST API", "GET", "POST", "PUT", "DELETE", "HTTP status codes"),
                    new ModuleDef("Module 5: Spring Data JPA", "Entity", "Repository", "CRUD", "Relationships"),
                    new ModuleDef("Module 6: Hibernate", "ORM", "One-to-One", "One-to-Many", "Many-to-Many"),
                    new ModuleDef("Module 7: MySQL Integration", "Database configuration", "Queries", "CRUD API"),
                    new ModuleDef("Module 8: Validation & Exception Handling", "Validation", "Global exception handling", "Custom exceptions"),
                    new ModuleDef("Module 9: Security", "Authentication", "Authorization", "Spring Security basics"),
                    new ModuleDef("Module 10: Project", "Build a complete REST-based application")
            };
            seedCourse(
                    "Spring Boot Development",
                    "Learn Spring Boot, REST APIs, MVC, JPA, Hibernate and build backend applications.",
                    "10 Weeks", "Intermediate", "Free",
                    "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Backend Development"), instructorEmail, instructorName, springBootModules,
                    "Spring Boot & REST API Evaluation",
                    "Live Masterclass: Building Microservices with Spring Boot & Docker"
            );

            // ----------------------------------------------------
            // 4. Web Development — 10 Weeks
            // ----------------------------------------------------
            ModuleDef[] webDevModules = new ModuleDef[]{
                    new ModuleDef("Module 1: HTML", "HTML structure", "Forms", "Tables", "Semantic elements"),
                    new ModuleDef("Module 2: CSS", "Selectors", "Box model", "Flexbox", "Grid", "Responsive design"),
                    new ModuleDef("Module 3: Bootstrap", "Containers", "Grid system", "Navbar", "Cards", "Forms", "Components"),
                    new ModuleDef("Module 4: JavaScript Basics", "Variables", "Data types", "Operators", "Conditions", "Loops"),
                    new ModuleDef("Module 5: JavaScript Functions", "Functions", "Arrow functions", "Scope", "Objects", "Arrays"),
                    new ModuleDef("Module 6: DOM", "DOM manipulation", "Events", "Form handling", "Validation"),
                    new ModuleDef("Module 7: Advanced JavaScript", "ES6", "JSON", "Promises", "async/await"),
                    new ModuleDef("Module 8: API Integration", "Fetch API", "REST API", "GET/POST requests"),
                    new ModuleDef("Module 9: Responsive Website", "Mobile-first design", "Media queries", "UI optimization"),
                    new ModuleDef("Module 10: Project", "Complete responsive website")
            };
            seedCourse(
                    "Web Development",
                    "Learn HTML, CSS, JavaScript and Bootstrap to create responsive and interactive websites.",
                    "10 Weeks", "Beginner", "Free",
                    "https://images.unsplash.com/photo-1547658719-da2b51169166?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Web Development"), instructorEmail, instructorName, webDevModules,
                    "Web Development Comprehensive Quiz",
                    "Live Workshop: Building Responsive Portals with Bootstrap 5"
            );

            // ----------------------------------------------------
            // 5. JavaScript Programming — 6 Weeks
            // ----------------------------------------------------
            ModuleDef[] jsModules = new ModuleDef[]{
                    new ModuleDef("Module 1: JavaScript Fundamentals", "Variables", "Data types", "Operators", "Conditions"),
                    new ModuleDef("Module 2: Loops & Functions", "for", "while", "forEach", "Functions", "Arrow functions"),
                    new ModuleDef("Module 3: Arrays & Objects", "Array methods", "Objects", "Destructuring", "Spread/rest operators"),
                    new ModuleDef("Module 4: DOM & Events", "Select elements", "Change content", "Events", "Forms"),
                    new ModuleDef("Module 5: Modern JavaScript", "ES6+", "Modules", "Promises", "async/await", "Fetch API"),
                    new ModuleDef("Module 6: Project", "Todo App", "Quiz App", "API-based application")
            };
            seedCourse(
                    "JavaScript Programming",
                    "Learn variables, functions, arrays, objects, DOM, events, ES6 and asynchronous JavaScript.",
                    "6 Weeks", "Beginner", "Free",
                    "https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Web Development"), instructorEmail, instructorName, jsModules,
                    "JavaScript Modern ES6 Assessment",
                    "Live Workshop: Async JavaScript, Promises & Fetch API"
            );

            // ----------------------------------------------------
            // 6. SQL & MySQL Database — 6 Weeks
            // ----------------------------------------------------
            ModuleDef[] sqlModules = new ModuleDef[]{
                    new ModuleDef("Module 1: Database Fundamentals", "Database concepts", "DBMS/RDBMS", "Tables", "Rows & columns"),
                    new ModuleDef("Module 2: SQL Basics", "CREATE", "INSERT", "SELECT", "UPDATE", "DELETE"),
                    new ModuleDef("Module 3: Constraints", "Primary Key", "Foreign Key", "UNIQUE", "NOT NULL", "CHECK"),
                    new ModuleDef("Module 4: Queries", "WHERE", "ORDER BY", "GROUP BY", "HAVING", "Aggregate functions"),
                    new ModuleDef("Module 5: Joins & Advanced SQL", "INNER JOIN", "LEFT JOIN", "RIGHT JOIN", "Subqueries", "Views"),
                    new ModuleDef("Module 6: Database Project", "Design database", "Create relationships", "Build CRUD application")
            };
            seedCourse(
                    "SQL & MySQL Database",
                    "Learn SQL queries, tables, joins, constraints, relationships, subqueries and database management.",
                    "6 Weeks", "Beginner", "Free",
                    "https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Database"), instructorEmail, instructorName, sqlModules,
                    "SQL Queries & Database Design Evaluation",
                    "Live Masterclass: Complex Joins, Indexing & Query Optimization"
            );

            // ----------------------------------------------------
            // 7. Data Structures & Algorithms — 12 Weeks
            // ----------------------------------------------------
            ModuleDef[] dsaModules = new ModuleDef[]{
                    new ModuleDef("Module 1: DSA Introduction", "Algorithms", "Complexity", "Big O notation"),
                    new ModuleDef("Module 2: Arrays", "Traversal", "Searching", "Insertion/deletion", "Two-pointer technique"),
                    new ModuleDef("Module 3: Strings", "String manipulation", "Palindrome", "Anagram", "Pattern problems"),
                    new ModuleDef("Module 4: Linked List", "Singly linked list", "Doubly linked list", "Circular linked list"),
                    new ModuleDef("Module 5: Stack", "Stack operations", "Applications", "Parentheses problems"),
                    new ModuleDef("Module 6: Queue", "Queue", "Circular queue", "Deque", "Priority queue"),
                    new ModuleDef("Module 7: Searching", "Linear search", "Binary search"),
                    new ModuleDef("Module 8: Sorting", "Bubble sort", "Selection sort", "Insertion sort", "Merge sort", "Quick sort"),
                    new ModuleDef("Module 9: Trees", "Binary tree", "BST", "Tree traversal"),
                    new ModuleDef("Module 10: Graphs", "Graph representation", "BFS", "DFS"),
                    new ModuleDef("Module 11: Recursion", "Recursive functions", "Backtracking basics"),
                    new ModuleDef("Module 12: Problem Solving", "Coding problems", "Interview questions", "Final DSA project")
            };
            seedCourse(
                    "Data Structures & Algorithms",
                    "Learn arrays, linked lists, stacks, queues, trees, searching, sorting and algorithm complexity.",
                    "12 Weeks", "Intermediate", "Free",
                    "https://images.unsplash.com/photo-1509228468518-180dd4864904?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Computer Science"), instructorEmail, instructorName, dsaModules,
                    "DSA & Algorithmic Problem Solving Assessment",
                    "Live Workshop: Solving LeetCode Trees & Graphs Challenges"
            );

            // ----------------------------------------------------
            // 8. Full Stack Java Development — 16 Weeks
            // ----------------------------------------------------
            ModuleDef[] fullStackModules = new ModuleDef[]{
                    new ModuleDef("Module 1: HTML & CSS", "HTML5 structure", "CSS3 styling", "Flexbox & Grid"),
                    new ModuleDef("Module 2: Bootstrap", "Bootstrap 5 grid", "Components", "Responsive layouts"),
                    new ModuleDef("Module 3: JavaScript", "Variables", "Functions", "Arrays & Objects", "ES6+"),
                    new ModuleDef("Module 4: DOM & API Integration", "DOM events", "Fetch API", "REST consumption"),
                    new ModuleDef("Module 5: Java Fundamentals", "Core syntax", "OOP", "Exception handling"),
                    new ModuleDef("Module 6: Advanced Java", "Collections framework", "Streams API", "Multithreading"),
                    new ModuleDef("Module 7: SQL & MySQL", "Relational schema", "CRUD operations", "Joins & indexing"),
                    new ModuleDef("Module 8: JDBC", "Connection management", "PreparedStatement", "Transactions"),
                    new ModuleDef("Module 9: Spring Framework", "IoC Container", "Dependency Injection", "Spring core"),
                    new ModuleDef("Module 10: Spring Boot", "Auto-configuration", "Starters", "REST Controller"),
                    new ModuleDef("Module 11: REST API", "HTTP methods", "JSON payloads", "Status code handling"),
                    new ModuleDef("Module 12: JPA & Hibernate", "Entity mappings", "Repositories", "JPQL queries"),
                    new ModuleDef("Module 13: Authentication & Security", "Spring Security", "BCrypt hashing", "RBAC roles"),
                    new ModuleDef("Module 14: Frontend + Backend Integration", "JSP/JSTL views", "AJAX endpoints", "Session management"),
                    new ModuleDef("Module 15: Git & GitHub + Deployment", "Version control", "GitHub repositories", "Production build"),
                    new ModuleDef("Module 16: Final Full Stack Project", "LMS Architecture", "Full Stack Implementation", "Final Project: Learning Management System (LMS)")
            };
            seedCourse(
                    "Full Stack Java Development",
                    "Build complete web applications using HTML, CSS, JavaScript, Java, Spring Boot and MySQL.",
                    "16 Weeks", "Advanced", "Free",
                    "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Full Stack"), instructorEmail, instructorName, fullStackModules,
                    "Full Stack Java Architecture Certification Exam",
                    "Live Masterclass: End-to-End LMS Deployment & Cloud Architecture"
            );

            // ----------------------------------------------------
            // 9. Git & GitHub — 4 Weeks
            // ----------------------------------------------------
            ModuleDef[] gitModules = new ModuleDef[]{
                    new ModuleDef("Module 1: Git Basics", "Git introduction", "Installation", "Repository", "git init"),
                    new ModuleDef("Module 2: Git Commands", "git add", "git commit", "git status", "git log", "git push/pull"),
                    new ModuleDef("Module 3: GitHub", "Repository creation", "Clone", "Remote", "README"),
                    new ModuleDef("Module 4: Branching & Collaboration", "Branch", "Merge", "Pull Request", "Conflict resolution", "Team collaboration")
            };
            seedCourse(
                    "Git & GitHub",
                    "Learn Git commands, repositories, branching, merging, commits and GitHub project management.",
                    "4 Weeks", "Beginner", "Free",
                    "https://images.unsplash.com/photo-1618401471353-b98aedd04e11?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Development Tools"), instructorEmail, instructorName, gitModules,
                    "Git CLI & GitHub Collaboration Assessment",
                    "Live Workshop: Resolving Merge Conflicts & GitHub Workflows"
            );

            // ----------------------------------------------------
            // 10. Software Testing — 6 Weeks
            // ----------------------------------------------------
            ModuleDef[] testingModules = new ModuleDef[]{
                    new ModuleDef("Module 1: Testing Fundamentals", "Software testing", "SDLC", "STLC", "Verification & Validation"),
                    new ModuleDef("Module 2: Testing Types", "Functional testing", "Non-functional testing", "Manual testing", "Regression testing", "Smoke testing"),
                    new ModuleDef("Module 3: Test Cases", "Test scenario", "Test case", "Test data", "Expected vs actual result"),
                    new ModuleDef("Module 4: Test Design Techniques", "Boundary Value Analysis", "Equivalence Partitioning", "Decision Table", "State Transition"),
                    new ModuleDef("Module 5: Defect Management", "Bug/defect", "Severity", "Priority", "Defect life cycle", "Reopened/closed defects"),
                    new ModuleDef("Module 6: Practical Testing", "Test a web application", "Write test cases", "Report defects", "Final testing assignment")
            };
            seedCourse(
                    "Software Testing",
                    "Learn SDLC, STLC, test cases, functional testing, non-functional testing and defect management.",
                    "6 Weeks", "Beginner", "Free",
                    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&auto=format&fit=crop&q=60",
                    catMap.get("Software Engineering"), instructorEmail, instructorName, testingModules,
                    "Software Testing & Quality Assurance Certification",
                    "Live Workshop: Manual Test Matrix & Defect Life Cycle Tracking"
            );

            // 6. Seed Announcement if empty
            if (announcementRepository.count() == 0) {
                announcementRepository.save(new Announcement(
                        "Welcome to the Academic Spring 2026 Term",
                        "All 10 core engineering programs (Java, Spring Boot, Web Dev, SQL, DSA, Full Stack, Git, Testing) are now live for enrollment.",
                        "ALL",
                        "admin@lms.com"
                ));
            }
        } catch (Exception e) {
            System.err.println("Database initialization warning: " + e.getMessage());
        }
    }

    private void seedCourse(String title, String description, String duration, String level, String price,
                            String thumbnailUrl, Category category, String instructorEmail, String instructorName,
                            ModuleDef[] modules, String quizTitle, String liveClassTitle) {
        Course course = courseRepository.findByTitle(title).orElseGet(() -> {
            Course c = new Course(title, description, level, duration, price, thumbnailUrl, instructorEmail, instructorName, category);
            return courseRepository.save(c);
        });

        course.setDescription(description);
        course.setDuration(duration);
        course.setLevel(level);
        course.setPrice(price);
        course.setThumbnailUrl(thumbnailUrl);
        course.setCategory(category);
        course.setUpcoming("Full Stack Java Development".equalsIgnoreCase(title));
        course = courseRepository.save(course);

        // Count expected total lessons across all modules
        int expectedTotalLessons = 0;
        for (ModuleDef m : modules) {
            expectedTotalLessons += m.topics.length;
        }

        List<Section> existingSections = sectionRepository.findByCourseIdOrderByOrderNumAsc(course.getId());
        long currentLessonCount = lessonRepository.countBySectionCourseId(course.getId());

        // Reseed sections & individual lessons if section count or lesson count doesn't match
        if (existingSections.isEmpty() || existingSections.size() != modules.length || currentLessonCount != expectedTotalLessons) {
            // Delete old lesson progress, sections and lessons safely
            try {
                lessonProgressRepository.deleteAll(lessonProgressRepository.findByCourseId(course.getId()));
            } catch (Exception ignored) {}

            for (Section s : existingSections) {
                lessonRepository.deleteAll(lessonRepository.findBySectionIdOrderByOrderNumAsc(s.getId()));
                sectionRepository.delete(s);
            }

            int moduleIndex = 1;
            for (ModuleDef mDef : modules) {
                Section sec = sectionRepository.save(new Section(course, mDef.title, moduleIndex));

                int topicIndex = 1;
                for (String topic : mDef.topics) {
                    String lessonTitle = moduleIndex + "." + topicIndex + " " + topic;
                    String pdfName = title.replaceAll("[^a-zA-Z0-9]", "-") + "-M" + moduleIndex + "-L" + topicIndex + ".pdf";

                    String lessonNotes = "### " + lessonTitle + "\n\n" +
                            "**Syllabus Topic Overview:**\n" +
                            "Comprehensive conceptual breakdown, syntax rules, best practices, and practical examples for `" + topic + "`.\n\n" +
                            "**Key Learning Objectives:**\n" +
                            "- Master the core theoretical principles of " + topic + ".\n" +
                            "- Implement hands-on coding exercises and live demonstrations.\n" +
                            "- Understand enterprise software architecture integration patterns.\n\n" +
                            "**Study Materials:**\n" +
                            "Refer to the attached lecture slides and study notes PDF: `" + pdfName + "`.";

                    lessonRepository.save(new Lesson(
                            sec,
                            lessonTitle,
                            topicIndex,
                            "https://www.youtube.com/embed/dQw4w9WgXcQ",
                            lessonNotes,
                            "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                            pdfName,
                            25 + (topicIndex * 5)
                    ));
                    topicIndex++;
                }
                moduleIndex++;
            }
        }

        // Seed Quiz if none
        if (quizRepository.findByCourseId(course.getId()).isEmpty()) {
            Quiz qz = quizRepository.save(new Quiz(course, quizTitle, "Comprehensive assessment evaluating all modules of " + title + ".", 20, 60));
            questionRepository.save(new Question(qz, "What is the primary architectural concept taught in " + title + "?", "Foundational Syntax & Best Practices", "Advanced Framework Design", "Full Stack Implementation", "All of the Above", "D", 2, "This course covers foundational to advanced principles comprehensively."));
            questionRepository.save(new Question(qz, "Which statement best describes the modular curriculum of " + title + "?", "Hands-on projects and theoretical rigor", "Surface level syntax only", "Deprecated frameworks", "None of the above", "A", 2, "Every module provides industry-aligned practical projects."));
        }

        // Seed Live Class if none
        if (liveClassRepository.findByCourseIdOrderByScheduledAtAsc(course.getId()).isEmpty()) {
            liveClassRepository.save(new LiveClass(
                    course, instructorEmail,
                    liveClassTitle,
                    "Interactive live broadcast covering code challenges, Q&A, and practical implementation.",
                    LocalDateTime.now().plusDays(2).plusHours(4), 60, "LIVE-" + course.getId() + "-ROOM"
            ));
        }
    }
}
