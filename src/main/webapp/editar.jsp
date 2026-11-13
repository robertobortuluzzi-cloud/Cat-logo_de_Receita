
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.model.Receita" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAO" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAOimpl" %>

<%!
    // Método responsável por escapar caracteres especiais e evitar problemas na exibição HTML.
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%
    // Cria o objeto responsável por acessar e atualizar os dados das receitas.
    ReceitaDAO dao = new ReceitaDAOimpl();

    // Verifica se o formulário foi enviado pelo método POST.
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");

        // Cria um objeto Receita e preenche seus atributos com os dados recebidos do formulário.
        Receita receita = new Receita();
        receita.setId(Integer.parseInt(request.getParameter("id")));
        receita.setNome(request.getParameter("nome"));
        receita.setCategoria(request.getParameter("categoria"));
        receita.setTempo(Integer.parseInt(request.getParameter("tempoPreparo")));
        receita.setDificuldade(request.getParameter("dificuldade"));
        receita.setDescricao(request.getParameter("descricao"));

        // Atualiza os dados da receita no banco de dados.
        dao.atualizar(receita);

        // Retorna o usuário para a página de listagem após a atualização.
        response.sendRedirect("listagem.jsp");
        return;
    }

    // Recupera o ID da receita enviado pela URL.
    String idParam = request.getParameter("id");

    // Caso o ID não seja informado, retorna para a listagem.
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("listagem.jsp");
        return;
    }

    // Busca no banco de dados a receita correspondente ao ID informado.
    Receita receita = dao.buscarPorId(Integer.parseInt(idParam));

    // Se a receita não existir, retorna para a página de listagem.
    if (receita == null) {
        response.sendRedirect("listagem.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Receita</title>
    <style>
        :root {
            /* Variáveis que definem as cores principais do design. */
            --tomate: #c8452d;
            --tomate-escuro: #9e3220;
            --mostarda: #e0a526;
            --oliva: #6b7a3a;
            --creme: #fff8ea;
            --papel: #fffdf6;
            --madeira: #5b3a24;
            --texto: #3d2b1f;
        }
        * { box-sizing: border-box; }

        body {
            margin: 0;
            padding: 56px 24px 90px;
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
            font-size: 18px;
            color: var(--texto);
            background-color: #fff3df;
            background-image:
                    linear-gradient(rgba(200,69,45,.16) 50%, transparent 50%),
                    linear-gradient(90deg, rgba(200,69,45,.16) 50%, transparent 50%);
            background-size: 64px 64px;
        }

        /* Estilização do título principal da página. */
        h1 {
            max-width: 720px;
            margin: 0 auto 28px;
            text-align: center;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 46px;
            color: var(--madeira);
            text-shadow: 3px 3px 0 rgba(255,255,255,.8);
        }

        /* Define a aparência e o posicionamento do formulário. */
        form {
            max-width: 720px;
            margin: 0 auto;
            padding: 44px 40px 40px;
            background: var(--papel);
            border-radius: 8px;
            border-top: 12px solid var(--mostarda);
            box-shadow: 0 12px 30px rgba(91,58,36,.28);
            position: relative;
        }
        form::after {
            content: "";
            position: absolute;
            inset: 12px;
            border: 2px dashed rgba(200,69,45,.45);
            border-radius: 4px;
            pointer-events: none;
        }
        form br { display: none; }

        .campo { position: relative; z-index: 1; margin-bottom: 26px; }

        label {
            display: block;
            margin-bottom: 4px;
            font-family: Georgia, serif;
            font-size: 20px;
            font-weight: bold;
            color: var(--tomate-escuro);
        }
        .ajuda {
            display: block;
            margin: 0 0 10px;
            font-size: 15px;
            line-height: 1.4;
            color: #8a6d55;
        }

        /* Estilização dos campos de preenchimento do formulário. */
        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 14px 16px;
            font-family: inherit;
            font-size: 18px;
            color: var(--texto);
            background: var(--creme);
            border: 2px solid #ecd9b0;
            border-radius: 10px;
            outline: none;
            transition: border-color .15s, box-shadow .15s;
        }
        textarea { min-height: 220px; resize: vertical; line-height: 1.5; }

        /* Destaca os campos quando o usuário seleciona algum deles. */
        input:focus, select:focus, textarea:focus {
            border-color: var(--mostarda);
            box-shadow: 0 0 0 4px rgba(224,165,38,.25);
        }

        .acoes { position: relative; z-index: 1; margin-top: 10px; }

        /* Estilização do botão de salvar e seus efeitos visuais. */
        button {
            padding: 16px 40px;
            font-family: Georgia, serif;
            font-size: 20px;
            font-weight: bold;
            color: #fff;
            background: var(--oliva);
            border: none;
            border-bottom: 5px solid #4d5a27;
            border-radius: 50px;
            cursor: pointer;
            transition: transform .12s, background .15s;
        }
        button:hover  { background: var(--tomate); border-bottom-color: var(--tomate-escuro); transform: translateY(-2px); }
        button:active { transform: translateY(1px); }

        .acoes a {
            margin-left: 20px;
            font-size: 18px;
            color: var(--tomate);
            font-weight: bold;
            text-decoration: none;
        }
        .acoes a:hover { color: var(--tomate-escuro); }
    </style>
</head>
<body>

<h1>✏️ Editar Receita</h1>

<!-- Formulário que permite alterar as informações de uma receita já cadastrada. -->
<form action="editar.jsp" method="post">

    <!-- Mantém o ID da receita para identificar qual registro será atualizado. -->
    <input type="hidden" name="id" value="<%= receita.getId() %>">

    <div class="campo">
        <label for="nome">Nome da receita</label>
        <span class="ajuda">Como a receita vai aparecer na lista. Ex.: Bolo de cenoura com cobertura de chocolate.</span>
        <input type="text" id="nome" name="nome" maxlength="150"
               value="<%= esc(receita.getNome()) %>" required>
    </div>

    <div class="campo">
        <label for="categoria">Categoria</label>
        <span class="ajuda">O tipo de prato. Ex.: Sobremesa, Massa, Salada, Lanche, Bebida.</span>
        <input type="text" id="categoria" name="categoria" maxlength="100"
               value="<%= esc(receita.getCategoria()) %>" required>
    </div>

    <div class="campo">
        <label for="tempoPreparo">Tempo de preparo (minutos)</label>
        <span class="ajuda">Tempo total até ficar pronto, contando forno e cozimento. Use só números. Ex.: 45.</span>
        <input type="number" id="tempoPreparo" name="tempoPreparo" min="1"
               value="<%= receita.getTempo() %>" required>
    </div>

    <div class="campo">
        <label for="dificuldade">Dificuldade</label>
        <span class="ajuda">Fácil: poucos ingredientes e técnica simples. Média: exige atenção a tempos e pontos. Difícil: técnica avançada ou vários preparos.</span>

        <!-- As opções permitem selecionar a dificuldade atual ou escolher outra. -->
        <select id="dificuldade" name="dificuldade">
            <option value="Fácil"   <%= "Fácil".equals(receita.getDificuldade())   ? "selected" : "" %>>Fácil</option>
            <option value="Média"   <%= "Média".equals(receita.getDificuldade())   ? "selected" : "" %>>Média</option>
            <option value="Difícil" <%= "Difícil".equals(receita.getDificuldade()) ? "selected" : "" %>>Difícil</option>
        </select>
    </div>

    <div class="campo">
        <label for="descricao">Modo de preparo (passo a passo)</label>
        <span class="ajuda">Escreva os ingredientes e os passos, um por linha, na ordem em que devem ser feitos. Máximo de 5000 caracteres.</span>
        <textarea id="descricao" name="descricao" maxlength="5000" required><%= esc(receita.getDescricao()) %></textarea>
    </div>

    <div class="acoes">
        <!-- Botão que envia os dados modificados para serem salvos. -->
        <button type="submit">Salvar</button>

        <!-- Link que cancela a edição e retorna à listagem. -->
        <a href="listagem.jsp">Cancelar</a>
    </div>

</form>

</body>
</html>
