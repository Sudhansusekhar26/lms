 <jsp:include page="aheader.jsp"></jsp:include>



<% String email=(String)session.getAttribute("email"); %>
<% String name=(String)session.getAttribute("name"); %>
Admin Dashboard
<hr />
wel come , <%=name %>



 <jsp:include page="footer.jsp"></jsp:include>