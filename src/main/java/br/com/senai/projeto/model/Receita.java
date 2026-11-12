package br.com.senai.projeto.model;

public class Receita {

    private int id;
    private String nome;
    private String categoria;
    private int tempo;
    private String dificuldade;
    private String descricao;

    public Receita() {
    }

    public Receita(int id, String nome, String categoria,
                   int tempo, String dificuldade, String descricao) {
        this.id = id;
        this.nome = nome;
        this.categoria = categoria;
        this.tempo = tempo;
        this.dificuldade = dificuldade;
        this.descricao = descricao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getTempo() {
        return tempo;
    }

    public void setTempo(int tempo) {
        this.tempo = tempo;
    }

    public String getDificuldade() {
        return dificuldade;
    }

    public void setDificuldade(String dificuldade) {
        this.dificuldade = dificuldade;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
}