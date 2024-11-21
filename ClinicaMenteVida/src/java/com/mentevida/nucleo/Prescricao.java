package com.mentevida.nucleo;

import java.time.LocalDate;

public class Prescricao {
    private int idPrescricao;
    private LocalDate dataPrescricao;
    private String medicamentos;
    private String dosagem;
    private String comentario;
    private Consulta consulta;

    public Prescricao(int idPrescricao, LocalDate dataPrescricao, String medicamentos, String dosagem, String comentario, Consulta consulta) {
        this.idPrescricao = idPrescricao;
        this.dataPrescricao = dataPrescricao;
        this.medicamentos = medicamentos;
        this.dosagem = dosagem;
        this.comentario = comentario;
        this.consulta = consulta;
    }
    
    public String toString() {
        return "[idPrescricao=" + getIdPrescricao() +
                "dataPrescricao=" + getDataPrescricao() +
                "medicamentos=" + getMedicamentos() +
                "dosagem=" + getDosagem() +
                "comentario=" + getComentario() +
                "consulta=" + getConsulta().getIdConsulta() +
                "]";
    }

    public int getIdPrescricao() {
        return idPrescricao;
    }

    public void setIdPrescricao(int idPrescricao) {
        this.idPrescricao = idPrescricao;
    }

    public LocalDate getDataPrescricao() {
        return dataPrescricao;
    }

    public void setDataPrescricao(LocalDate dataPrescricao) {
        this.dataPrescricao = dataPrescricao;
    }

    public String getMedicamentos() {
        return medicamentos;
    }

    public void setMedicamentos(String medicamentos) {
        this.medicamentos = medicamentos;
    }

    public String getDosagem() {
        return dosagem;
    }

    public void setDosagem(String dosagem) {
        this.dosagem = dosagem;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }
}
