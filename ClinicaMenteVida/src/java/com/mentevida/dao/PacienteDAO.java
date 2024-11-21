package com.mentevida.dao;

import com.mentevida.nucleo.Paciente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class PacienteDAO {
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private final Connection con;
    
    public PacienteDAO() throws Exception {
        con = ConnectionManager.getConnection();
    }
    
    /* -- SQL Operations -- */
    
    // Select
    
    public List<Paciente> mostrarTodosPacientes() throws SQLException {
        List<Paciente> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from paciente");
            rs = st.executeQuery();
            
            // loop adiciona o objeto Paciente numa lista
            while (rs.next()) {
                Paciente tempPaciente = rowToPaciente(rs);
                list.add(tempPaciente);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    public List<Paciente> mostrarIdPacientes(int id) throws SQLException {
        List<Paciente> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from paciente where id_paciente = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto Paciente numa lista
            while (rs.next()) {
                Paciente tempPaciente = rowToPaciente(rs);
                list.add(tempPaciente);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    public List<Paciente> mostrarNomePacientes(String nome) throws SQLException {
        List<Paciente> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from paciente where nome like ?");
            st.setString(1, "%" + nome + "%");
            rs = st.executeQuery();
            
            // loop adiciona o objeto Paciente numa lista
            while (rs.next()) {
                Paciente tempPaciente = rowToPaciente(rs);
                list.add(tempPaciente);
            }
            return list;
            
        } finally {
            close(st, rs);
        }
    }
    
    // Add - Update - Remove
    
    public void cadastrarPaciente(Paciente oPaciente) throws SQLException {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("insert into paciente (nome, data_nascimento, telefone, email, historico_medico) values (?, ?, ?, ?, ?)");
            st.setString(1, oPaciente.getNome());
            st.setString(2, oPaciente.getDataNascimento().toString());
            st.setString(3, oPaciente.getTelefone());
            st.setString(4, oPaciente.getEmail());
            st.setString(5, oPaciente.getHistoricoMedico());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void alterarPaciente(Paciente oPaciente) throws SQLException {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("update paciente set nome = ?, data_nascimento = ?, telefone = ?, email = ?, historico_medico = ? " +
                    "where id_paciente = ?");
            st.setString(1, oPaciente.getNome());
            st.setString(2, oPaciente.getDataNascimento().toString());
            st.setString(3, oPaciente.getTelefone());
            st.setString(4, oPaciente.getEmail());
            st.setString(5, oPaciente.getHistoricoMedico());
            st.setInt(6, oPaciente.getIdPaciente());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void deletarPaciente(int id) throws SQLException {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("delete from paciente where id_paciente = ?");
            st.setInt(1, id);
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    // Passa os resultados da query para um Paciente object
    private Paciente rowToPaciente(ResultSet rs) throws SQLException {
        int idPaciente = rs.getInt("id_paciente");
        String nome = rs.getString("nome");
        LocalDate dataNascimento = LocalDate.parse(rs.getString("data_nascimento"), dtf);
        String telefone = rs.getString("telefone");
        String email = rs.getString("email");
        String historicoMedico = rs.getString("historico_medico");

        return new Paciente(idPaciente, nome, dataNascimento, telefone, email, historicoMedico);
    }

    private void close(PreparedStatement st, ResultSet rs) throws SQLException {
        if (st != null) {
            st.close();
        }
        if (rs != null) {
            rs.close();
        }
    }
}
