<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAO" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAOimpl" %>

<%
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.isEmpty()) {
        ReceitaDAO dao = new ReceitaDAOimpl();
        dao.excluir(Integer.parseInt(idParam));
    }

    response.sendRedirect("listagem.jsp");
%>