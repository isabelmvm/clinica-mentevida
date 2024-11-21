
package com.mentevida.nucleo;

public class Medico extends Usuario {
    private int idMedico;
    private String nome;
    private String especialidade;
    private String telefone;
    private String email;
    
    public Medico() {} // Construtor para gerar objetos genéricos

    public Medico(int idMedico, String nome, String especialidade, String telefone, String email, int idUsuario, String username, String senha, boolean isAdmin) {
        super(idUsuario, username, senha, isAdmin);
        this.idMedico = idMedico;
        this.nome = nome;
        this.especialidade = especialidade;
        this.telefone = telefone;
        this.email = email;
    }
    
    @Override
    public String toString() {
        return "[idFuncionario=" + getIdMedico() +
                "nome=" + getNome() +
                "telefone=" + getTelefone() +
                "email=" + getEmail() +
                "especialidade=" + getEspecialidade() +
                "usuario=" + getIdUsuario() +
                "]";
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idMedico) {
        this.idMedico = idMedico;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
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
}
