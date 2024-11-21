package com.mentevida.nucleo;

import java.time.LocalDateTime;

public class Agendamento {
    private int idAgendamento;
    private LocalDateTime dataAgendamento;
    private boolean status;
    private Funcionario funcionario;
    private Medico medico;
    private Paciente paciente;

    public Agendamento(int idAgendamento, LocalDateTime dataAgendamento, boolean status, Funcionario funcionario, Medico medico, Paciente paciente) {
        this.idAgendamento = idAgendamento;
        this.dataAgendamento = dataAgendamento;
        this.status = status;
        this.funcionario = funcionario;
        this.medico = medico;
        this.paciente = paciente;
    }
    
    public String toString() {
        return "[idAgendamento=" + getIdAgendamento() +
                "dataAgendamento=" + getDataAgendamento() +
                "status=" + getStatus() +
                "funcionario=" + getFuncionario().getIdFuncionario() +
                "medico=" + getMedico().getIdMedico() +
                "paciente=" + getPaciente().getIdPaciente() +
                "]";
    }

    public int getIdAgendamento() {
        return idAgendamento;
    }

    public void setIdAgendamento(int idAgendamento) {
        this.idAgendamento = idAgendamento;
    }

    public LocalDateTime getDataAgendamento() {
        return dataAgendamento;
    }

    public void setDataAgendamento(LocalDateTime dataAgendamento) {
        this.dataAgendamento = dataAgendamento;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Funcionario getFuncionario() {
        return funcionario;
    }

    public void setFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
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
