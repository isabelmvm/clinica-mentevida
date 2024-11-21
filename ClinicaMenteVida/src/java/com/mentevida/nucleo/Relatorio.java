package com.mentevida.nucleo;

import java.time.LocalDate;

public class Relatorio {
    private int idRelatorio;
    private LocalDate dataRelatorio;
    private String endereco;
    private Consulta consulta;

    public Relatorio(int idRelatorio, LocalDate dataRelatorio, String endereco, Consulta consulta) {
        this.idRelatorio = idRelatorio;
        this.dataRelatorio = dataRelatorio;
        this.endereco = endereco;
        this.consulta = consulta;
    }
    
    public String toString() {
        return "[idRelatorio=" + getIdRelatorio() +
                "dataRelatorio=" + getDataRelatorio() +
                "endereco=" + getEndereco() +
                "consulta=" + getConsulta().getIdConsulta() +
                "]";
    }

    public int getIdRelatorio() {
        return idRelatorio;
    }

    public void setIdRelatorio(int idRelatorio) {
        this.idRelatorio = idRelatorio;
    }

    public LocalDate getDataRelatorio() {
        return dataRelatorio;
    }

    public void setDataRelatorio(LocalDate dataRelatorio) {
        this.dataRelatorio = dataRelatorio;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }
}
