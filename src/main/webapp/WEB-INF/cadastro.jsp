<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.model.Receita" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAO" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String nome = request.getParameter("nome");
        String categoria = request.getParameter("categoria");
        int tempoPreparo = Integer.parseInt(
                request.getParameter("tempoPreparo")
        );
        String dificuldade = request.getParameter("dificuldade");

        Receita receita = new Receita(
                nome, categoria, tempoPreparo, dificuldade
        );

        ReceitaDAO dao = new ReceitaDAO();
        dao.cadastrar(receita);

        response.sendRedirect("listagem.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Catálogo de Receitas</title>
</head>
<body>

<h1>Cadastrar Receita</h1>

<form action="cadastro.jsp" method="post">

    <label>Nome:</label>
    <input type="text" name="nome" required>

    <br><br>

    <label>Categoria:</label>
    <input type="text" name="categoria" required>

    <br><br>

    <label>Tempo de preparo (minutos):</label>
    <input type="number" name="tempoPreparo" required>

    <br><br>

    <label>Dificuldade:</label>
    <select name="dificuldade">
        <option value="Fácil">Fácil</option>
        <option value="Média">Média</option>
        <option value="Difícil">Difícil</option>
    </select>

    <br><br>

    <button type="submit">Cadastrar</button>

</form>

</body>
</html>