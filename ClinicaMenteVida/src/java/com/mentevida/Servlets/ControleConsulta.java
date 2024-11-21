package com.mentevida.Servlets;

import com.mentevida.dao.ConsultaDAO;
import com.mentevida.nucleo.Consulta;
import com.mentevida.nucleo.Medico;
import com.mentevida.nucleo.Paciente;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleConsulta", urlPatterns = {"/ControleConsulta"})
public class ControleConsulta extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        try {
            ConsultaDAO dao = new ConsultaDAO();
            
            int idConsulta = 0;
            boolean alterar = false;
            boolean excluir = false;

            if (request.getParameter("idConsulta") != null) {
                idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                if (request.getParameter("alterar") != null) {
                    alterar = Boolean.parseBoolean(request.getParameter("alterar"));
                }
                
                // Checa se operação de excluir foi requisitada
                if (request.getParameter("excluir") != null) {
                    excluir = true;
                }
            }
            
            if (!excluir) {
                int duracao = Integer.parseInt(request.getParameter("duracao"));
                double valor = Double.parseDouble(request.getParameter("valor"));
                int idPaciente = Integer.parseInt(request.getParameter("paciente"));
                int idMedico = Integer.parseInt(request.getParameter("medico"));
                
                Medico medico = new Medico();
                medico.setIdMedico(idMedico);
                Paciente paciente = new Paciente();
                paciente.setIdPaciente(idPaciente);

                // Operação Insert e Update
                Consulta consulta = new Consulta(idConsulta, duracao, valor, medico, paciente);
                if (!alterar) {
                    dao.cadastrarConsulta(consulta);
                } else {
                    dao.alterarConsulta(consulta);
                }
                
            } else {
                // operação delete
                dao.deletarConsulta(idConsulta);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Operação efetuada com sucesso!')");
            out.println("location='consulta.jsp'");
            out.println("</script>");
        } catch (Exception e) {
            out.print(e);
        }
    }

}
