package br.com.senai.projeto.config;

import java.sql.*;

public class Conexao {

    // Pasta fixa na home do usuário, para o banco não depender de onde o Tomcat foi iniciado
    private static final String URL =
            "jdbc:h2:file:" + System.getProperty("user.home").replace("\\", "/")
                    + "/projeto-data/banco";

    private static final String USUARIO = "sa";
    private static final String SENHA = "";

    public static Connection conectar() throws SQLException {
        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver H2 não encontrado!", e);
        }
        return DriverManager.getConnection(URL, USUARIO, SENHA);
    }

    public static void createTable() {
        String sqlTabela = "CREATE TABLE IF NOT EXISTS receitas (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY, " +
                "nome VARCHAR(150) NOT NULL, " +
                "categoria VARCHAR(100) NOT NULL, " +
                "tempo INT NOT NULL, " +
                "dificuldade VARCHAR(20) NOT NULL, " +
                "descricao VARCHAR(5000))";

        // Para bancos já criados antes: adiciona a coluna se ela ainda não existir
        String sqlColuna = "ALTER TABLE receitas ADD COLUMN IF NOT EXISTS descricao VARCHAR(5000)";

        try (Connection conn = conectar();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sqlTabela);
            stmt.execute(sqlColuna);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao criar a tabela receitas", e);
        }
    }
}