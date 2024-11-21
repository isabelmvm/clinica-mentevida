package com.mentevida.Servlets;

import com.mentevida.dao.AgendamentoDAO;
import com.mentevida.nucleo.Agendamento;
import com.mentevida.nucleo.Funcionario;
import com.mentevida.nucleo.Medico;
import com.mentevida.nucleo.Paciente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ControleAgendamento", urlPatterns = {"/ControleAgendamento"})
public class ControleAgendamento extends HttpServlet {
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idAgendamento = 0;
        
        if (request.getParameter("excluir") != null && request.getParameter("excluir").equals("true")) {
            if (request.getParameter("idAgendamento") != null) {
                try {
                    idAgendamento = Integer.parseInt(request.getParameter("idAgendamento"));
                    AgendamentoDAO dao = new AgendamentoDAO();
                    dao.deletarAgendamento(idAgendamento);
                    
                    PrintWriter out = response.getWriter();
                    out.println("<head><meta charset=\"utf-8\"><head>");
                    out.println("<script>");
                    out.println("alert('Registro deletado com sucesso!')");
                    out.println("location='agendamento.jsp'");
                    out.println("</script>");
                } catch (Exception e) {
                    response.getWriter().write(e.getMessage());
                }
                return;
            }
        }
        
        LocalDateTime data_agendamento = LocalDateTime.parse(request.getParameter("data_agendamento"), dtf);
        Boolean status = Boolean.valueOf(request.getParameter("status"));
        int idPaciente = Integer.parseInt(request.getParameter("paciente"));
        int idMedico = Integer.parseInt(request.getParameter("medico"));
        int idFuncionario = Integer.parseInt(request.getParameter("funcionario"));
        
        boolean alterar = false;
        if (request.getParameter("alterar") != null && request.getParameter("alterar").equals("true")) {
            alterar = true;
            if (request.getParameter("idAgendamento") != null) {
                idAgendamento = Integer.parseInt(request.getParameter("idAgendamento"));
            }
        }
        
        PrintWriter out = response.getWriter();
        
        try {
            AgendamentoDAO dao = new AgendamentoDAO();
            
            Paciente p = new Paciente();
            p.setIdPaciente(idPaciente);
            Medico m = new Medico();
            m.setIdMedico(idMedico);
            Funcionario f = new Funcionario();
            f.setIdFuncionario(idFuncionario);
            
            Agendamento oAgendamento = new Agendamento(idAgendamento, data_agendamento, status, f, m, p);
            
            if (!alterar) {
                dao.cadastrarAgendamento(oAgendamento);
            } else {
                oAgendamento.setIdAgendamento(idAgendamento);
                dao.alterarAgendamento(oAgendamento);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Registro efetuado com sucesso!')");
            out.println("location='agendamento.jsp'");
            out.println("</script>");
        } catch (Exception e) {
            out.print(e);
        }
    }

}
