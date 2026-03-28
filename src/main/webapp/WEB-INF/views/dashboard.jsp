<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  boolean isAdmin = request.isUserInRole("ADMIN");
  boolean isStudent = request.isUserInRole("STUDENT");
  boolean isFaculty = request.isUserInRole("FACULTY");
  request.setAttribute("isAdmin",isAdmin);
  request.setAttribute("isStudent",isStudent);
  request.setAttribute("isFaculty",isFaculty);
%>

<c:if test="${isAdmin}">
    <jsp:include page="admin/aheader.jsp" />
</c:if>
<c:if test="${isStudent}">
    <jsp:include page="student/smenu.jsp" />
</c:if>
<c:if test="${isFaculty}">
    <jsp:include page="faculty/fmenu.jsp" />
</c:if>