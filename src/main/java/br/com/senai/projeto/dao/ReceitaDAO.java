
package br.com.senai.projeto.dao;

import br.com.senai.projeto.model.Receita;
import java.util.List;

public interface ReceitaDAO {

    void cadastrar(Receita entidade);

    List<Receita> listar();

    Receita buscarPorId(int id);

    void atualizar(Receita entidade);

    void excluir(int id);
}
