<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.model.Receita" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAO" %>
<%@ page import="br.com.senai.projeto.dao.ReceitaDAOimpl" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");

        Receita receita = new Receita();
        receita.setNome(request.getParameter("nome"));
        receita.setCategoria(request.getParameter("categoria"));
        receita.setTempo(Integer.parseInt(request.getParameter("tempoPreparo")));
        receita.setDificuldade(request.getParameter("dificuldade"));
        receita.setDescricao(request.getParameter("descricao"));

        ReceitaDAO dao = new ReceitaDAOimpl();
        dao.cadastrar(receita);

        response.sendRedirect("listagem.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cadastrar Receita</title>
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
            max-width: 720px;
            margin: 0 auto 28px;
            text-align: center;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 46px;
            color: var(--madeira);
            text-shadow: 3px 3px 0 rgba(255,255,255,.8);
        }

        form {
            max-width: 720px;
            margin: 0 auto;
            padding: 44px 40px 40px;
            background: var(--papel);
            border-radius: 8px;
            border-top: 12px solid var(--tomate);
            box-shadow: 0 12px 30px rgba(91,58,36,.28);
            position: relative;
        }
        form::after {
            content: "";
            position: absolute;
            inset: 12px;
            border: 2px dashed rgba(224,165,38,.7);
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
        input:focus, select:focus, textarea:focus {
            border-color: var(--mostarda);
            box-shadow: 0 0 0 4px rgba(224,165,38,.25);
        }

        .acoes { position: relative; z-index: 1; margin-top: 10px; }

        button {
            padding: 16px 40px;
            font-family: Georgia, serif;
            font-size: 20px;
            font-weight: bold;
            color: #fff;
            background: var(--tomate);
            border: none;
            border-bottom: 5px solid var(--tomate-escuro);
            border-radius: 50px;
            cursor: pointer;
            transition: transform .12s, background .15s;
        }
        button:hover  { background: var(--oliva); border-bottom-color: #4d5a27; transform: translateY(-2px); }
        button:active { transform: translateY(1px); }

        .acoes a {
            margin-left: 20px;
            font-size: 18px;
            color: var(--oliva);
            font-weight: bold;
            text-decoration: none;
        }
        .acoes a:hover { color: var(--tomate); }
    </style>
</head>
<body>

<h1>🥕 Nova Receita</h1>

<form action="cadastro.jsp" method="post">

    <div class="campo">
        <label for="nome">Nome da receita</label>
        <span class="ajuda">Como a receita vai aparecer na lista. Ex.: Bolo de cenoura com cobertura de chocolate.</span>
        <input type="text" id="nome" name="nome" maxlength="150" required>
    </div>

    <div class="campo">
        <label for="categoria">Categoria</label>
        <span class="ajuda">O tipo de prato. Ex.: Sobremesa, Massa, Salada, Lanche, Bebida.</span>
        <input type="text" id="categoria" name="categoria" maxlength="100" required>
    </div>

    <div class="campo">
        <label for="tempoPreparo">Tempo de preparo (minutos)</label>
        <span class="ajuda">Tempo total até ficar pronto, contando forno e cozimento. Use só números. Ex.: 45.</span>
        <input type="number" id="tempoPreparo" name="tempoPreparo" min="1" required>
    </div>

    <div class="campo">
        <label for="dificuldade">Dificuldade</label>
        <span class="ajuda">Fácil: poucos ingredientes e técnica simples. Média: exige atenção a tempos e pontos. Difícil: técnica avançada ou vários preparos.</span>
        <select id="dificuldade" name="dificuldade">
            <option value="Fácil">Fácil</option>
            <option value="Média">Média</option>
            <option value="Difícil">Difícil</option>
        </select>
    </div>

    <div class="campo">
        <label for="descricao">Modo de preparo (passo a passo)</label>
        <span class="ajuda">Escreva os ingredientes e os passos, um por linha, na ordem em que devem ser feitos. Máximo de 5000 caracteres.</span>
        <textarea id="descricao" name="descricao" maxlength="5000" required
                  placeholder="1. Misture os ovos, o óleo e as cenouras no liquidificador.&#10;2. Acrescente o açúcar e bata bem.&#10;3. Misture a farinha e o fermento.&#10;4. Asse a 180 °C por 40 minutos."></textarea>
    </div>

    <div class="acoes">
        <button type="submit">Cadastrar</button>
        <a href="listagem.jsp">Cancelar</a>
    </div>

</form>

</body>
</html>