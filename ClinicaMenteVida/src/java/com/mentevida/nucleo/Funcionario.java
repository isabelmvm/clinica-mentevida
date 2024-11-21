package com.mentevida.nucleo;

public class Funcionario extends Usuario {
    private int idFuncionario;
    private String nome;
    private String telefone;
    private String email;
    private String cargo;
    
    public Funcionario(){} // Construtor para gerar objectos genéricos

    public Funcionario(int idFuncionario, String nome, String telefone, String email, String cargo, int idUsuario, String username, String senha, boolean isAdmin) {
        super(idUsuario, username, senha, isAdmin);
        this.idFuncionario = idFuncionario;
        this.nome = nome;
        this.telefone = telefone;
        this.email = email;
        this.cargo = cargo;
    }
    
    @Override
    public String toString() {
        return "[idFuncionario=" + getIdFuncionario() +
                "nome=" + getNome() +
                "senha=" + getSenha() +
                "telefone=" + getTelefone() +
                "email=" + getEmail() +
                "cargo=" + getCargo() +
                "idUsuario=" + getIdUsuario() +
                "]";
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
}
