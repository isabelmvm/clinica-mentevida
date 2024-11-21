package com.mentevida.dao;

import com.mentevida.nucleo.Relatorio;
import com.mentevida.nucleo.Consulta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class RelatorioDAO {
    private final Connection con;
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public RelatorioDAO() throws Exception {
        con = ConnectionManager.getConnection();
    }
    
    /* -- SQL Operations -- */
    
    // Select
    
    public List<Relatorio> mostrarTodasRelatorios() throws Exception {
        List<Relatorio> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from relatorio");
            rs = st.executeQuery();
            
            // loop adiciona o objeto Relatorio numa lista
            while (rs.next()) {
                Relatorio tempRelatorio = rowToRelatorio(rs);
                list.add(tempRelatorio);
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
    
    public List<Relatorio> mostrarIdRelatorio(int id) throws Exception {
        List<Relatorio> list = new ArrayList<>();
        
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            st = con.prepareStatement("select * from relatorio where id_relatorio = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            
            // loop adiciona o objeto Relatorio numa lista
            while (rs.next()) {
                Relatorio tempRelatorio = rowToRelatorio(rs);
                list.add(tempRelatorio);
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
    
    public void cadastrarRelatorio(Relatorio aRelatorio) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("insert into relatorio (data_relatorio, endereco, consulta_id_consulta) values (?, ?, ?)");
            st.setString(1, aRelatorio.getDataRelatorio().toString());
            st.setString(2, aRelatorio.getEndereco());
            st.setInt(3, aRelatorio.getConsulta().getIdConsulta());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void alterarRelatorio(Relatorio aRelatorio) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("update relatorio set data_relatorio = ?, endereco = ?, consulta_id_consulta = ? where id_relatorio = ?");
            st.setString(1, aRelatorio.getDataRelatorio().toString());
            st.setString(2, aRelatorio.getEndereco());
            st.setInt(3, aRelatorio.getConsulta().getIdConsulta());
            st.setInt(4, aRelatorio.getIdRelatorio());
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }
    
    public void deletarRelatorio(int id) throws Exception {
        PreparedStatement st = null;
        try {
            st = con.prepareStatement("delete from relatorio where id_relatorio = ?");
            st.setInt(1, id);
            
            st.executeUpdate();
        } finally {
            if (st != null) {
                st.close();
            }
        }
    }

    private Relatorio rowToRelatorio(ResultSet rs) throws Exception {
        int idRelatorio = rs.getInt("id_relatorio");
        LocalDate dataRelatorio = LocalDate.parse(rs.getString("data_relatorio"), dtf);
        String endereco = rs.getString("endereco");
        Consulta consulta = new Consulta();
        consulta.setIdConsulta(rs.getInt("consulta_id_consulta"));
        
        return new Relatorio(idRelatorio, dataRelatorio, endereco, consulta);
    }
    
    public static void main(String[] args) throws Exception {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Consulta c = new Consulta();
        c.setIdConsulta(2);
        LocalDate data = LocalDate.parse("2024-09-15", dtf);
        Relatorio oRelatorio = new Relatorio(1, data, "C\\Relatorios\\relatorio3.pdf", c);
        
        RelatorioDAO dao = new RelatorioDAO();
        
        dao.deletarRelatorio(1);
        System.out.println(dao.mostrarTodasRelatorios());
    }
}
