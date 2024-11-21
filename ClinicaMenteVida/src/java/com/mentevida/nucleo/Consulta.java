package com.mentevida.nucleo;

import java.time.LocalDate;

public class Consulta {
    private int idConsulta;
    private int duracao;
    private double valor;
    private Medico medico;
    private Paciente paciente;
    
    public Consulta() {} // Construtor para objetos genéricos

    public Consulta(int idConsulta, int duracao, double valor, Medico medico, Paciente paciente) {
        this.idConsulta = idConsulta;
        this.duracao = duracao;
        this.valor = valor;
        this.medico = medico;
        this.paciente = paciente;
    }
    
    public String toString() {
        return "[idConsulta=" + getIdConsulta() +
                "duracao=" + getDuracao() +
                "valor=" + getValor() +
                "medico=" + getMedico().getIdMedico() +
                "paciente=" + getPaciente().getIdPaciente() +
                "]";
    }

    public int getIdConsulta() {
        return idConsulta;
    }

    public void setIdConsulta(int idConsulta) {
        this.idConsulta = idConsulta;
    }

    public int getDuracao() {
        return duracao;
    }

    public void setDuracao(int duracao) {
        this.duracao = duracao;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }
}
