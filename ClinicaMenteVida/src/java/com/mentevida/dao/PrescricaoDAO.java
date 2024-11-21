package com.mentevida.dao;

import com.mentevida.nucleo.Prescricao;
import com.mentevida.nucleo.Consulta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class PrescricaoDAO {
    private final Connection con;
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public PrescricaoDAO() throws Exception {
        con = ConnectionManager.getConnection();
    }
    
    /* -- SQL Operations -- */
    
    // Select
    
    public List<Prescricao> mostrarTodasPrescricoes() throws Exception {
        List<Prescricao> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from prescricao");
            rs = st.executeQuery();
            
            // loop adiciona o objeto PrescricaoDAO numa lista
            while (rs.next()) {
                Prescricao tempPrescricao = rowToPrescricao(rs);
                list.add(tempPrescricao);
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
    
    public List<Prescricao> mostrarIdPrescricao(int id) throws Exception {
        List<Prescricao> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from prescricao where id_prescricao = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto PrescricaoDAO numa lista
            while (rs.next()) {
                Prescricao tempPrescricao = rowToPrescricao(rs);
                list.add(tempPrescricao);
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
    
    public void cadastrarPrescricao(Prescricao aPrescricao) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("insert into prescricao (data_prescricao, medicamentos, dosagem, comentario, id_consulta) values (?, ?, ?, ?, ?)");
            st.setString(1, aPrescricao.getDataPrescricao().toString());
            st.setString(2, aPrescricao.getMedicamentos());
            st.setString(3, aPrescricao.getDosagem());
            st.setString(4, aPrescricao.getComentario());
            st.setInt(5, aPrescricao.getConsulta().getIdConsulta());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void alterarPrescricao(Prescricao aPrescricao) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("UPDATE `prescricao` SET `data_prescricao` = ?, `medicamentos` = ?, `dosagem` = ?, `comentario` = ?, `id_consulta` = ? WHERE `prescricao`.`id_prescricao` = ?");
            st.setString(1, aPrescricao.getDataPrescricao().toString());
            st.setString(2, aPrescricao.getMedicamentos());
            st.setString(3, aPrescricao.getDosagem());
            st.setString(4, aPrescricao.getComentario());
            st.setInt(5, aPrescricao.getConsulta().getIdConsulta());
            st.setInt(6, aPrescricao.getIdPrescricao());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void deletarPrescricao(int id) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("delete from prescricao where id_prescricao = ?");
            st.setInt(1, id);
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    private Prescricao rowToPrescricao(ResultSet rs) throws Exception {
        int idPrescricao = rs.getInt("id_prescricao");
        LocalDate dataPrescricao = LocalDate.parse(rs.getString("data_prescricao"), dtf);
        String medicamentos = rs.getString("medicamentos");
        String dosagem = rs.getString("dosagem");
        String comentario = rs.getString("comentario");
        Consulta consulta = new Consulta();
        consulta.setIdConsulta(rs.getInt("id_consulta"));
        
        return new Prescricao(idPrescricao, dataPrescricao, medicamentos, dosagem, comentario, consulta);
    }
}
