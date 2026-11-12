<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.senai.projeto.model.Receita" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAO" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAOimpl" %>

<%!
    // Escapa o texto para exibir com segurança no HTML
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
    ReceitaDAO dao = new ReceitaDAOimpl();
    List<Receita> receitas = dao.listar();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Listagem de Receitas</title>
    <style>
        :root {
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

        h1 {
            max-width: 1200px;
            margin: 0 auto 24px;
            text-align: center;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 50px;
            color: var(--madeira);
            text-shadow: 3px 3px 0 rgba(255,255,255,.8);
        }

        .menu { max-width: 1200px; margin: 0 auto 36px; text-align: center; }
        .menu a {
            display: inline-block;
            margin: 6px 8px;
            padding: 14px 30px;
            font-family: Georgia, serif;
            font-size: 19px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
            background: var(--tomate);
            border-bottom: 5px solid var(--tomate-escuro);
            border-radius: 50px;
            transition: transform .12s, background .15s;
        }
        .menu a + a { background: var(--oliva); border-bottom-color: #4d5a27; }
        .menu a:hover { background: var(--mostarda); border-bottom-color: #b98215; color: var(--madeira); transform: translateY(-2px); }

        /* Grade de cartões */
        .grade {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 28px;
            align-items: start;
        }

        .cartao {
            position: relative;
            padding: 30px 28px 26px;
            background: var(--papel);
            border-radius: 8px;
            border-top: 12px solid var(--tomate);
            box-shadow: 0 10px 26px rgba(91,58,36,.25);
        }
        .cartao::after {
            content: "";
            position: absolute;
            inset: 10px;
            border: 2px dashed rgba(224,165,38,.6);
            border-radius: 4px;
            pointer-events: none;
        }
        .cartao > * { position: relative; z-index: 1; }

        .cartao h2 {
            margin: 0 0 12px;
            font-family: Georgia, serif;
            font-size: 28px;
            line-height: 1.2;
            color: var(--madeira);
        }

        .info { display: flex; flex-wrap: wrap; gap: 10px; align-items: center; margin-bottom: 18px; }
        .chip {
            padding: 6px 14px;
            font-size: 16px;
            font-weight: bold;
            color: var(--madeira);
            background: #fdeccb;
            border-radius: 30px;
        }

        /* Etiquetas de dificuldade */
        .tag {
            padding: 6px 16px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            border-radius: 30px;
        }
        .tag.facil   { background: var(--oliva); }
        .tag.media   { background: var(--mostarda); color: var(--madeira); }
        .tag.dificil { background: var(--tomate); }

        .titulo-passos {
            margin: 0 0 6px;
            font-family: Georgia, serif;
            font-size: 18px;
            font-weight: bold;
            color: var(--tomate-escuro);
        }

        /* Passo a passo: mostra 3 linhas e abre ao clicar */
        .passos {
            margin: 0;
            font-size: 18px;
            line-height: 1.55;
            white-space: pre-line;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            line-clamp: 3;
            overflow: hidden;
        }
        .passos.aberto {
            display: block;
            -webkit-line-clamp: unset;
            line-clamp: unset;
            overflow: visible;
        }
        .vazio { color: #8a6d55; font-style: italic; }

        .btn-mais {
            display: none;
            margin: 10px 0 0;
            padding: 0;
            font-family: inherit;
            font-size: 17px;
            font-weight: bold;
            color: var(--oliva);
            background: none;
            border: none;
            border-bottom: 2px dotted var(--oliva);
            cursor: pointer;
        }
        .btn-mais:hover { color: var(--tomate); border-bottom-color: var(--tomate); }

        .acoes {
            margin-top: 22px;
            padding-top: 16px;
            border-top: 1px dashed #e6d3a8;
            display: flex;
            gap: 22px;
        }
        .acoes a { font-size: 18px; font-weight: bold; text-decoration: none; }
        .acoes a[href^="editar"]  { color: var(--oliva); }
        .acoes a[href^="editar"]:hover  { color: var(--madeira); }
        .acoes a[href^="excluir"] { color: var(--tomate); }
        .acoes a[href^="excluir"]:hover { color: var(--tomate-escuro); }

        .nenhuma {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px;
            text-align: center;
            font-size: 22px;
            background: var(--papel);
            border-top: 12px solid var(--mostarda);
            border-radius: 8px;
            box-shadow: 0 10px 26px rgba(91,58,36,.25);
        }
    </style>
</head>
<body>

<h1>📖 Livro de Receitas</h1>

<div class="menu">
    <a href="cadastro.jsp">+ Nova receita</a>
    <a href="index.jsp">Início</a>
</div>

<% if (receitas == null || receitas.isEmpty()) { %>

<div class="nenhuma">🍽️ Nenhuma receita cadastrada ainda.</div>

<% } else { %>

<div class="grade">
    <% for (Receita r : receitas) {
        String d = r.getDificuldade();
        String classe = "Fácil".equals(d) ? "facil" : ("Média".equals(d) ? "media" : "dificil");
        String descricao = r.getDescricao();
        boolean temDescricao = descricao != null && !descricao.trim().isEmpty();
    %>
    <div class="cartao">
        <h2><%= esc(r.getNome()) %></h2>

        <div class="info">
            <span class="chip">🍽️ <%= esc(r.getCategoria()) %></span>
            <span class="chip">⏱️ <%= r.getTempo() %> min</span>
            <span class="tag <%= classe %>"><%= esc(d) %></span>
        </div>

        <p class="titulo-passos">Modo de preparo</p>
        <% if (temDescricao) { %>
        <p class="passos"><%= esc(descricao.trim()) %></p>
        <button type="button" class="btn-mais">Mostrar mais</button>
        <% } else { %>
        <p class="vazio">Sem passo a passo cadastrado.</p>
        <% } %>

        <div class="acoes">
            <a href="editar.jsp?id=<%= r.getId() %>">✏️ Editar</a>
            <a href="excluir.jsp?id=<%= r.getId() %>"
               onclick="return confirm('Excluir esta receita?');">🗑️ Excluir</a>
        </div>
    </div>
    <% } %>
</div>

<% } %>

<script>
    // Só mostra o botão quando o texto realmente passa de 3 linhas
    document.querySelectorAll('.cartao').forEach(function (cartao) {
        var passos = cartao.querySelector('.passos');
        var botao  = cartao.querySelector('.btn-mais');
        if (!passos || !botao) return;

        if (passos.scrollHeight > passos.clientHeight + 1) {
            botao.style.display = 'inline-block';
        }

        botao.addEventListener('click', function () {
            var aberto = passos.classList.toggle('aberto');
            botao.textContent = aberto ? 'Mostrar menos' : 'Mostrar mais';
        });
    });
</script>

</body>
</html>