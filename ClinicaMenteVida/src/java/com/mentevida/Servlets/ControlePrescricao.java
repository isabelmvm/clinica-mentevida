package com.mentevida.Servlets;

import com.mentevida.dao.PrescricaoDAO;
import com.mentevida.nucleo.Consulta;
import com.mentevida.nucleo.Prescricao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ControlePrescricao", urlPatterns = {"/ControlePrescricao"})
public class ControlePrescricao extends HttpServlet {
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        int idPrescricao = 0;
        
        if (request.getParameter("idPrescricao") != null) {
            idPrescricao = Integer.parseInt(request.getParameter("idPrescricao"));
        }
        
        if (request.getParameter("excluir") != null && request.getParameter("excluir").equals("true")) {
            try {
                PrescricaoDAO dao = new PrescricaoDAO();
                dao.deletarPrescricao(idPrescricao);
                
                out.println("<head><meta charset=\"utf-8\"><head>");
                out.println("<script>");
                out.println("alert('Registro deletado com sucesso!')");
                out.println("location='prescricao.jsp'");
                out.println("</script>");
            } catch (Exception e) {
                out.print(e);
            }
            return;
        }
        
        LocalDate dataPrescricao = LocalDate.parse(request.getParameter("data_prescricao"), dtf);
        String medicamentos = request.getParameter("medicamentos");
        String dosagem = request.getParameter("dosagem");
        String comentario = request.getParameter("comentario");
        int idConsulta = Integer.parseInt(request.getParameter("consulta"));
        
        boolean alterar = false;
        if (request.getParameter("alterar") != null && request.getParameter("alterar").equals("true")) {
            alterar = true;
        }
        
        try {
            Consulta consulta = new Consulta();
            consulta.setIdConsulta(idConsulta);
            PrescricaoDAO dao = new PrescricaoDAO();
            Prescricao aPrescricao = new Prescricao(0, dataPrescricao, medicamentos, dosagem, comentario, consulta);
            
            if (!alterar) {
                dao.cadastrarPrescricao(aPrescricao);
            } else {
                aPrescricao.setIdPrescricao(idPrescricao);
                dao.alterarPrescricao(aPrescricao);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Registro efetuado com sucesso!')");
            out.println("location='prescricao.jsp'");
            out.println("</script>");
            
        } catch (Exception e) {
            out.print(e);
        }
    }
}
