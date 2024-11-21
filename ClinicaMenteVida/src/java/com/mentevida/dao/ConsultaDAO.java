package com.mentevida.dao;

import com.mentevida.nucleo.Consulta;
import com.mentevida.nucleo.Medico;
import com.mentevida.nucleo.Paciente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ConsultaDAO {
    private final Connection con;

    public ConsultaDAO() throws Exception {
        con = ConnectionManager.getConnection();
    }
    
    /* -- SQL Operations -- */
    
    // Select
    
    public List<Consulta> mostrarTodasConsultas() throws Exception {
        List<Consulta> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from consulta");
            rs = st.executeQuery();
            
            // loop adiciona o objeto Consulta numa lista
            while (rs.next()) {
                Consulta tempConsulta = rowToConsulta(rs);
                list.add(tempConsulta);
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
    
    public List<Consulta> mostrarIdConsulta(int id) throws Exception {
        List<Consulta> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from consulta where id_consulta = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto Consulta numa lista
            while (rs.next()) {
                Consulta tempConsulta = rowToConsulta(rs);
                list.add(tempConsulta);
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
    
    public void cadastrarConsulta(Consulta aConsulta) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("insert into consulta (duracao, valor, id_paciente, id_medico) values (?, ?, ?, ?)");
            st.setInt(1, aConsulta.getDuracao()); // minutos
            st.setDouble(2, aConsulta.getValor());
            st.setInt(3, aConsulta.getPaciente().getIdPaciente());
            st.setInt(4, aConsulta.getMedico().getIdMedico());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void alterarConsulta(Consulta aConsulta) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("update consulta set duracao = ?, valor = ?, id_paciente = ?, id_medico = ? where id_consulta = ?");
            st.setInt(1, aConsulta.getDuracao()); // minutos
            st.setDouble(2, aConsulta.getValor());
            st.setInt(3, aConsulta.getPaciente().getIdPaciente());
            st.setInt(4, aConsulta.getMedico().getIdMedico());
            st.setInt(5, aConsulta.getIdConsulta());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void deletarConsulta(int id) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("delete from consulta where id_consulta = ?");
            st.setInt(1, id);
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    private Consulta rowToConsulta(ResultSet rs) throws Exception {
        int idConsulta = rs.getInt("id_consulta");
        int duracao = rs.getInt("duracao");
        double valor = rs.getDouble("valor");
        
        Paciente paciente = new Paciente();
        paciente.setIdPaciente(rs.getInt("id_paciente"));
        Medico medico = new Medico();
        medico.setIdMedico(rs.getInt("id_medico"));
        
        return new Consulta(idConsulta, duracao, valor, medico, paciente);
    }
    
    public static void main(String[] args) throws Exception {
        ConsultaDAO dao = new ConsultaDAO();
        Paciente p = new Paciente();
        Medico m = new Medico();
        
        m.setIdMedico(2);
        p.setIdPaciente(6);
        Consulta c = new Consulta(1, 30, 200, m, p);
        dao.deletarConsulta(1);
        
        System.out.println(dao.mostrarTodasConsultas());
    }
}
