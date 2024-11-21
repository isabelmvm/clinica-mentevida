package com.mentevida.dao;

import com.mentevida.nucleo.Medico;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MedicoDAO {
    private final Connection con;
    private UsuarioDAO usu;
    
    public MedicoDAO() throws Exception {
        con = ConnectionManager.getConnection();
        usu = new UsuarioDAO();
    }
    
    /* -- SQL Operations -- */
    
    // Select
    
    public List<Medico> mostrarTodosMedicos() throws Exception {
        List<Medico> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from medico");
            rs = st.executeQuery();
            
            // loop adiciona o objeto Medico numa lista
            while (rs.next()) {
                Medico tempMedico = rowToMedico(rs);
                list.add(tempMedico);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    public List<Medico> mostrarIdMedicos(int id) throws Exception {
        List<Medico> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from medico where id_medico = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto Medico numa lista
            while (rs.next()) {
                Medico tempMedico = rowToMedico(rs);
                list.add(tempMedico);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    public List<Medico> mostrarUserIdMedicos(int id) throws Exception {
        List<Medico> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from medico where idUsuario = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto Medico numa lista
            while (rs.next()) {
                Medico tempMedico = rowToMedico(rs);
                list.add(tempMedico);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    public List<Medico> mostrarNomeMedicos(String nome) throws Exception {
        List<Medico> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from medico where nome like ?");
            st.setString(1, "%" + nome + "%");
            rs = st.executeQuery();
            
            // loop adiciona o objeto Medico numa lista
            while (rs.next()) {
                Medico tempMedico = rowToMedico(rs);
                list.add(tempMedico);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    // Add - Update - Remove
    
    public void cadastrarMedico(Medico oMedico) throws Exception, NoSuchAlgorithmException {
        PreparedStatement st = null;
        try {
            /*
            // Caso queira criar um novo usuário junto ao perfil do médico
            if (oMedico.getIdUsuario() == -1) {
                // Gerar usuário do médico
                String username = oMedico.getUsername();
                String senha = oMedico.getSenha();
                String admin = Boolean.toString(oMedico.isAdmin());
                String[] usuario = {"", username, senha, admin}; // [idUsuario, username, senha, admin] -- admin = "true" / "false"
                usu.cadastrarUsuario(usuario);
                
                usuario = usu.mostrarUsernameUsuarios(username).get(0);
                oMedico.setIdMedico(Integer.parseInt(usuario[0]));
            }
            */
            
            st = con.prepareStatement("insert into medico (nome, especialidade, telefone, email, idUsuario) values (?, ?, ?, ?, ?)"); 
            
            st.setString(1, oMedico.getNome());
            st.setString(2, oMedico.getEspecialidade());
            st.setString(3, oMedico.getTelefone());
            st.setString(4, oMedico.getEmail());
            if (oMedico.getIdUsuario() != 0) {
                st.setInt(5, oMedico.getIdUsuario());
            } else {
                st.setNull(5, 0);
            }
            
            st.executeUpdate();
            
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void alterarMedico(Medico oMedico) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("update medico set nome = ?, especialidade = ?, telefone = ?, email = ?, idUsuario = ?" +
                    " where id_medico = ?");
            st.setString(1, oMedico.getNome());
            st.setString(2, oMedico.getEspecialidade());
            st.setString(3, oMedico.getTelefone());
            st.setString(4, oMedico.getEmail());
            if (oMedico.getIdUsuario() > 0) {
                st.setInt(5, oMedico.getIdUsuario());
            } else { 
                st.setNull(5, 0);
            }
            st.setInt(6, oMedico.getIdMedico());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void deleteMedico(int id) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("delete from medico where id_medico = ?");
            st.setInt(1, id);
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    private Medico rowToMedico(ResultSet rs) throws Exception, Exception {
        
        int idUsuario = 0;
        String username = null;
        String senha = null;
        Boolean admin = false;
        
        if (rs.getString("idUsuario") != null) {
            idUsuario = rs.getInt("idUsuario");
            if (usu.mostrarIdUsuario(idUsuario).get(0) != null) {
                String[] usuario = usu.mostrarIdUsuario(idUsuario).get(0); // [id, username, senha, admin]
                username = usuario[1];
                senha = usuario[2];
                admin = Boolean.getBoolean(usuario[3]);
            }
        }
        
        int idMedico = rs.getInt("id_medico");
        String nome = rs.getString("nome");
        String especialidade = rs.getString("especialidade");
        String telefone = rs.getString("telefone");
        String email = rs.getString("email");

        return new Medico(idMedico, nome, especialidade, telefone, email, idUsuario, username, senha, admin);
    }

    private void close(PreparedStatement st, ResultSet rs) throws Exception {
        if (st != null) {
            st.close();
        }
        if (rs != null) {
            rs.close();
        }
    }
    
    public static void main(String[] args) throws Exception {
        MedicoDAO dao = new MedicoDAO();
        Medico medico = new Medico(0, "teste", "teste", "123456789", "teste", 0, "", "", false);

        System.out.println(dao.mostrarTodosMedicos());
    }
}
