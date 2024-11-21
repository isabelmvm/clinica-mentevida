package com.mentevida.dao;

import com.mentevida.nucleo.Agendamento;
import com.mentevida.nucleo.Funcionario;
import com.mentevida.nucleo.Medico;
import com.mentevida.nucleo.Paciente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDAO {
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private final Connection con;
    
    public AgendamentoDAO() throws Exception{
        con = ConnectionManager.getConnection();
    }
    
     /* -- SQL Operations -- */
    
    // Select
    
    public List<Agendamento> mostrarTodosAgendamentos() throws Exception {
        List<Agendamento> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from agendamento");
            rs = st.executeQuery();
            
            // loop adiciona o objeto AgendamentoDAO numa lista
            while (rs.next()) {
                Agendamento tempAgendamento = rowToAgendamento(rs);
                list.add(tempAgendamento);
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
    
    public List<Agendamento> mostrarIdAgendamento(int id) throws Exception {
        List<Agendamento> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from agendamento where id_agendamento = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto AgendamentoDAO numa lista
            while (rs.next()) {
                Agendamento tempAgendamento = rowToAgendamento(rs);
                list.add(tempAgendamento);
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
    
    // Insert, Update, Delete
    
    public void cadastrarAgendamento(Agendamento oAgendamento) throws Exception {
        PreparedStatement st = null;
        try {            
            st = con.prepareStatement("insert into agendamento (data_agendamento, status, paciente_id_paciente, medico_id_medico, funcionario_id_funcionario) values (?, ?, ?, ?, ?)");
            st.setString(1, oAgendamento.getDataAgendamento().toString());
            st.setBoolean(2, oAgendamento.getStatus());
            st.setInt(3, oAgendamento.getPaciente().getIdPaciente());
            st.setInt(4, oAgendamento.getMedico().getIdMedico());
            st.setInt(5, oAgendamento.getFuncionario().getIdFuncionario());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void alterarAgendamento(Agendamento oAgendamento) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("update agendamento set data_agendamento = ?, status = ?, paciente_id_paciente = ?, medico_id_medico = ?, funcionario_id_funcionario = ? where id_agendamento = ?");
            st.setString(1, oAgendamento.getDataAgendamento().toString());
            st.setBoolean(2, oAgendamento.getStatus());
            st.setInt(3, oAgendamento.getPaciente().getIdPaciente());
            st.setInt(4, oAgendamento.getMedico().getIdMedico());
            st.setInt(5, oAgendamento.getFuncionario().getIdFuncionario());
            st.setInt(6, oAgendamento.getIdAgendamento());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void deletarAgendamento(int id) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("delete from agendamento where id_agendamento = ?");
            st.setInt(1, id);
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    private Agendamento rowToAgendamento(ResultSet rs) throws Exception {
        int idAgendamento = rs.getInt("id_agendamento");
        LocalDateTime dataAgendamento = LocalDateTime.parse(rs.getString("data_agendamento"), dtf);
        Boolean status = rs.getBoolean("status");
        Paciente paciente = new Paciente();
        paciente.setIdPaciente(rs.getInt("paciente_id_paciente"));
        Medico medico = new Medico();
        medico.setIdMedico(rs.getInt("medico_id_medico"));
        Funcionario funcionario = new Funcionario();
        funcionario.setIdFuncionario(rs.getInt("funcionario_id_funcionario"));
        
        return new Agendamento(idAgendamento, dataAgendamento, status, funcionario, medico, paciente);
    }
    
    public static void main(String[] args) throws Exception {
        AgendamentoDAO dao = new AgendamentoDAO();
        System.out.println(dao.mostrarTodosAgendamentos());
    }
}
