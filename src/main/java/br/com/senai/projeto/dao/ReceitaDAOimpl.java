package br.com.senai.projeto.dao;

import br.com.senai.projeto.config.Conexao;
import br.com.senai.projeto.model.Receita;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReceitaDAOimpl implements ReceitaDAO {

    public ReceitaDAOimpl() {
        Conexao.createTable();
    }

    @Override
    public void cadastrar(Receita entidade) {
        String sql = "INSERT INTO receitas (nome, categoria, tempo, dificuldade, descricao) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexao.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entidade.getNome());
            ps.setString(2, entidade.getCategoria());
            ps.setInt(3, entidade.getTempo());
            ps.setString(4, entidade.getDificuldade());
            ps.setString(5, entidade.getDescricao());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao cadastrar receita", e);
        }
    }

    @Override
    public List<Receita> listar() {
        String sql = "SELECT id, nome, categoria, tempo, dificuldade, descricao FROM receitas ORDER BY id DESC";
        List<Receita> lista = new ArrayList<>();

        try (Connection conn = Conexao.conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(new Receita(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("categoria"),
                        rs.getInt("tempo"),
                        rs.getString("dificuldade"),
                        rs.getString("descricao")
                ));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar receitas", e);
        }
        return lista;
    }

    @Override
    public Receita buscarPorId(int id) {
        String sql = "SELECT id, nome, categoria, tempo, dificuldade, descricao FROM receitas WHERE id = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Receita(
                            rs.getInt("id"),
                            rs.getString("nome"),
                            rs.getString("categoria"),
                            rs.getInt("tempo"),
                            rs.getString("dificuldade"),
                            rs.getString("descricao")
                    );
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar receita", e);
        }
        return null;
    }

    @Override
    public void atualizar(Receita entidade) {
        String sql = "UPDATE receitas SET nome = ?, categoria = ?, tempo = ?, dificuldade = ?, descricao = ? WHERE id = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entidade.getNome());
            ps.setString(2, entidade.getCategoria());
            ps.setInt(3, entidade.getTempo());
            ps.setString(4, entidade.getDificuldade());
            ps.setString(5, entidade.getDescricao());
            ps.setInt(6, entidade.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar receita", e);
        }
    }

    @Override
    public void excluir(int id) {
        String sql = "DELETE FROM receitas WHERE id = ?";

        try (Connection conn = Conexao.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir receita", e);
        }
    }
}