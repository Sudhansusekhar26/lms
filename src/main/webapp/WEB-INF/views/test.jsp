<!-- <%@ page import="java.util.*" %>
<% 
    List<String> li=(List<String>)request.getAttribute("data");
    for(String k:li){
    out.print(k +"<br>");
    }
     %> -->

     <!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${data}" var="i">
    <c:out value="${i}" />
    <hr />
</c:forEach> <hr> -->

<!-- Express -->
  Name : ${name} <br> 
  Roll No : ${roll} <br>

   <!-- jsp -->
    <% 
    String name = (String) request.getAttribute("name");
    Integer roll = (Integer) request.getAttribute("roll");
    
    %>
    <hr>
    Name  : <%=name %> <br>
    Roll No  : <%=roll %> <hr>

    <!-- jstl -->
     <c:out value="${name}" /> <br>
     <c:out value="${roll}" />
              

