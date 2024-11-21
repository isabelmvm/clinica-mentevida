package com.mentevida.nucleo;

import java.time.LocalDate;

public class Paciente {
    private int idPaciente;
    private String nome;
    private LocalDate dataNascimento;
    private String telefone;
    private String email;
    private String historicoMedico;
    
    public Paciente() {} // Construtor para gerar objetos genéricos

    public Paciente(int idPaciente, String nome, LocalDate dataNascimento, String telefone, String email, String historicoMedico) {
        this.idPaciente = idPaciente;
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.telefone = telefone;
        this.email = email;
        this.historicoMedico = historicoMedico;
    }
    
    @Override
    public String toString() {
        return "[idPaciente=" + getIdPaciente() +
                "nome=" + getNome() +
                "dataNascimento=" + getDataNascimento() +
                "telefone=" + getTelefone() +
                "email=" + getEmail() +
                "historicoMedico=" + getHistoricoMedico() +
                "]";
    }

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
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

    public String getHistoricoMedico() {
        return historicoMedico;
    }

    public void setHistoricoMedico(String historicoMedico) {
        this.historicoMedico = historicoMedico;
    }
}
