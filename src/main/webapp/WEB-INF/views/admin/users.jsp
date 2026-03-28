<jsp:include page="aheader.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table border="1px" width="100%">
    <tr><th> Name</th><th> Email Id</th><th> Mobile No</th><th> Role</th><th> Action</th></tr>
<c:forEach var="user" items="${user_master}">
    <form method="post" action="/users">
    <tr>
        <td>${user.name}</td>
        <td>${user.email}</td>
        <td>${user.mobile}</td>
        <td>${user.role}</td>
        <td>
            <input type="hidden" value="${user.email}" name="email" />
            <input type="submit" value="edit" name="btn" />
            <input type="submit" value="delete" name="btn" />
        </td>
    </tr>
    </form>
</c:forEach>
</table>
<jsp:include page="afooter.jsp" />