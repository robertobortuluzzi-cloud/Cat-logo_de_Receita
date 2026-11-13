<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Catálogo de Receitas</title>
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
            padding: 64px 24px 90px;
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
            max-width: 800px;
            margin: 0 auto 36px;
            text-align: center;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 54px;
            line-height: 1.1;
            color: var(--madeira);
            text-shadow: 3px 3px 0 rgba(255,255,255,.8);
        }
        h1 span {
            display: block;
            margin-bottom: 8px;
            font-size: 18px;
            letter-spacing: 4px;
            color: var(--tomate);
            text-transform: uppercase;
        }

        .ficha {
            max-width: 800px;
            margin: 0 auto;
            padding: 48px 36px;
            background: var(--papel);
            border-radius: 8px;
            border-top: 12px solid var(--tomate);
            box-shadow: 0 12px 30px rgba(91,58,36,.28);
            position: relative;
        }
        .ficha::after {
            content: "";
            position: absolute;
            inset: 12px;
            border: 2px dashed rgba(224,165,38,.7);
            border-radius: 4px;
            pointer-events: none;
        }

        ul { list-style: none; margin: 0; padding: 0; display: flex; gap: 20px; flex-wrap: wrap; justify-content: center; position: relative; z-index: 1; }
        li a {
            display: inline-block;
            padding: 18px 38px;
            font-family: Georgia, serif;
            font-size: 22px;
            font-weight: bold;
            color: #fff;
            text-decoration: none;
            background: var(--tomate);
            border-radius: 50px;
            border-bottom: 5px solid var(--tomate-escuro);
            transition: transform .12s, background .15s;
        }
        li:nth-child(2) a { background: var(--oliva); border-bottom-color: #4d5a27; }
        li a:hover { transform: translateY(-3px); background: var(--mostarda); border-bottom-color: #b98215; color: var(--madeira); }
    </style>
</head>
<body>

<h1><span>🍳 Livro de</span>Catálogo de Receitas</h1>

<div class="ficha">
    <ul>
        <li><a href="cadastro.jsp">🥕 Cadastrar receita</a></li>
        <li><a href="listagem.jsp">📖 Ver receitas</a></li>
    </ul>
</div>

</body>
</html>