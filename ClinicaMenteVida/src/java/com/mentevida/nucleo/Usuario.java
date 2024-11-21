package com.mentevida.nucleo;

public abstract class Usuario {
    private int idUsuario;
    private String username;
    private String senha;
    private boolean isAdmin;
    
    public Usuario(){} // construtor generico

    public Usuario(int idUsuario, String username, String senha, boolean isAdmin) {
        this.idUsuario = idUsuario;
        this.username = username;
        this.senha = senha;
        this.isAdmin = isAdmin;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public abstract String toString();

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
}
