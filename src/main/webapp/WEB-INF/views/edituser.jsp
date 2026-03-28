<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->
<jsp:include page="aheader.jsp" />

<!-- <c:out value = "${usermaster}"/> -->

<form method="post" action="updateusers">
    Name : 
    <input type="text" name="name" value="${user_master[0].name}" />
    <br />

    Mobile : 
    <input type="text" name="mobile" value="${user_master[0].mobile}" />
    <br />

    Role : 
    <input type="text" name="role" value="${user_master[0].role}" />

    <input type="hidden" name="email" value="${user_master[0].email}" />
    <br />

    <input type="submit" name="btn" value="update" />
</form>