package com.mentevida.dao;

import com.mentevida.auth.Encryptor;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    private final Connection con;

    public UsuarioDAO() throws Exception {
        con = ConnectionManager.getConnection();
    }

    // Select
    public List<String[]> mostrarTodosUsuarios() throws Exception {
        List<String[]> list = new ArrayList<>();

        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("SELECT \n" + "    u.*, \n" + "    COALESCE(f.nome, m.nome) AS Nome,\n"
                    + "    ua.Cargo,\n" + "    COALESCE(f.id_funcionario, m.id_medico) AS Id\n" + "FROM \n"
                    + "    usuario u\n" + "LEFT JOIN \n" + "    UsuarioAssociacao ua ON ua.idUsuario = u.idUsuario\n"
                    + "LEFT JOIN \n" + "    funcionario f ON ua.Cargo = 'Funcionario' AND f.idUsuario = ua.idUsuario\n" + "LEFT JOIN \n"
                    + "    medico m ON ua.Cargo = 'Medico' AND m.idUsuario = ua.idUsuario  \n" + "ORDER BY `u`.`idUsuario`;");
            rs = st.executeQuery();

            String idUsuario;
            String username;
            String senha;
            String admin;
            String nome;
            String cargo;
            String id;

            while (rs.next()) {
                idUsuario = Integer.toString(rs.getInt("idUsuario"));
                username = rs.getString("username");
                senha = rs.getString("senha");
                admin = Boolean.toString(rs.getBoolean("admin"));
                nome = rs.getString("Nome");
                cargo = rs.getString("Cargo");
                id = rs.getString("Id");
                String[] tempUsuario = {idUsuario, username, senha, admin, nome, cargo, id};
                list.add(tempUsuario);
            }
            // resultado = {id, username, senha, admin, nome, cargo, id(func/medico)}
            return list;
        } finally {
            if (st != null) {
                st.close();
                rs.close();
            }
        }
    }

    public List<String[]> mostrarIdUsuario(int id) throws Exception {
        List<String[]> list = new ArrayList<>();

        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from usuario where idUsuario = ?");
            st.setInt(1, id);
            rs = st.executeQuery();

            String idUsuario;
            String username;
            String senha;
            String admin;

            while (rs.next()) {
                idUsuario = Integer.toString(rs.getInt("idUsuario"));
                username = rs.getString("username");
                senha = rs.getString("senha");
                admin = Boolean.toString(rs.getBoolean("admin"));
                String[] tempUsuario = {idUsuario, username, senha, admin};
                list.add(tempUsuario);
            }
            // Usuario -> {idUsuario, username, senha, admin}
            return list;
        } finally {
            if (st != null) {
                st.close();
                rs.close();
            }
        }
    }

    public List<String[]> mostrarUsernameUsuarios(String input) throws Exception {
        List<String[]> list = new ArrayList<>();

        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from usuario where username = ?");
            st.setString(1, input);
            rs = st.executeQuery();

            // Usuario -> {idUsuario, username, senha, admin}
            String idUsuario;
            String username;
            String senha;
            String admin;

            while (rs.next()) {
                idUsuario = Integer.toString(rs.getInt("idUsuario"));
                username = rs.getString("username");
                senha = rs.getString("senha");
                admin = Boolean.toString(rs.getBoolean("admin"));
                String[] tempUsuario = {idUsuario, username, senha, admin};
                list.add(tempUsuario);
            }

            return list;
        } finally {
            if (st != null) {
                st.close();
                rs.close();
            }
        }
    }

    public List<String[]> pesquisarUsernameUsuarios(String input) throws Exception {
        List<String[]> list = new ArrayList<>();

        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("SELECT \n" + "    u.*, \n" + "    COALESCE(f.nome, m.nome) AS Nome,\n"
                    + "    ua.Cargo,\n" + "    COALESCE(f.id_funcionario, m.id_medico) AS Id\n" + "FROM \n"
                    + "    usuario u\n" + "LEFT JOIN \n" + "    UsuarioAssociacao ua ON ua.idUsuario = u.idUsuario\n"
                    + "LEFT JOIN \n" + "    funcionario f ON ua.Cargo = 'Funcionario' AND f.idUsuario = ua.idUsuario\n" + "LEFT JOIN \n"
                    + "    medico m ON ua.Cargo = 'Medico' AND m.idUsuario = ua.idUsuario  \n"
                    + "WHERE " + "    u.username LIKE ? " + "ORDER BY " + "u.idUsuario;");
            st.setString(1, "%" + input + "%");
            rs = st.executeQuery();

            // resultado = {id, username, senha, admin, nome, cargo, id(func/medico)}
            String idUsuario;
            String username;
            String senha;
            String admin;
            String nome;
            String cargo;
            String id;

            while (rs.next()) {
                idUsuario = Integer.toString(rs.getInt("idUsuario"));
                username = rs.getString("username");
                senha = rs.getString("senha");
                admin = Boolean.toString(rs.getBoolean("admin"));
                nome = rs.getString("Nome");
                cargo = rs.getString("Cargo");
                id = rs.getString("Id");
                String[] tempUsuario = {idUsuario, username, senha, admin, nome, cargo, id};
                list.add(tempUsuario);
            }

            return list;
        } finally {
            if (st != null) {
                st.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
    }

    // Add - Update - Remove
    public void cadastrarUsuario(String[] oUsuario) throws SQLException, NoSuchAlgorithmException {
        // oUsuario -> {idUsuario, username, senha, admin}
        PreparedStatement st = null;

        try {
            st = con.prepareStatement("insert into usuario (username, senha, admin) values (?, ?, ?)");
            st.setString(1, oUsuario[1]);
            st.setString(2, Encryptor.encrypt(oUsuario[2]));
            st.setBoolean(3, Boolean.parseBoolean(oUsuario[3]));

            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    public void alterarUsuario(String[] oUsuario) throws SQLException, NoSuchAlgorithmException {
        // oUsuario -> {idUsuario, username, senha, admin}
        PreparedStatement st = null;

        try {
            st = con.prepareStatement("update usuario set username = ?, senha = ?, admin = ? where idUsuario = ?");
            st.setString(1, oUsuario[1]);
            st.setString(2, Encryptor.encrypt(oUsuario[2]));
            st.setBoolean(3, Boolean.parseBoolean(oUsuario[3]));
            st.setInt(4, Integer.parseInt(oUsuario[0]));

            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    public void deletarUsuario(int id) throws SQLException {
        PreparedStatement st = null;

        try {
            st = con.prepareStatement("delete from usuario where idUsuario = ?");
            st.setInt(1, id);

            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    public static void main(String[] args) throws Exception {
        UsuarioDAO dao = new UsuarioDAO();
        String[] usuario = {"12", "eufuncionario", "123", "true"};
        List<String[]> list = dao.pesquisarUsernameUsuarios("dada");
        for (int i = 0; i < list.size(); i++) {
            String[] result = list.get(i);
            for (int j = 0; j < result.length; j++) {
                System.out.println(result[j]);
            }
            System.out.println("-----------------------");
        }
    }
}
