package com.mentevida.Servlets;

import com.mentevida.dao.MedicoDAO;
import com.mentevida.nucleo.Medico;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleMedico", urlPatterns = {"/ControleMedico"})
public class ControleMedico extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        try {
            MedicoDAO dao = new MedicoDAO();
            
            int idMedico = 0;
            boolean alterar = false;
            boolean excluir = false;

            if (request.getParameter("idMedico") != null) {
                idMedico = Integer.parseInt(request.getParameter("idMedico"));
                if (request.getParameter("alterar") != null) {
                    alterar = Boolean.parseBoolean(request.getParameter("alterar"));
                }
                
                // Checa se operação de excluir foi requisitada
                if (request.getParameter("excluir") != null) {
                    excluir = true;
                }
            }
            
            if (!excluir) {
                String nome = request.getParameter("nome");
                String especialidade = request.getParameter("especialidade");
                String telefone = request.getParameter("telefone");
                String email = request.getParameter("email");
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

                // Operação Insert e Update
                Medico medico = new Medico(idMedico, nome, especialidade, telefone, email, idUsuario, "", "", false);
                if (!alterar) {
                    dao.cadastrarMedico(medico);
                } else {
                    dao.alterarMedico(medico);
                }
                
            } else {
                // operação delete
                dao.deleteMedico(idMedico);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Operação efetuada com sucesso!')");
            out.println("location='medico.jsp'");
            out.println("</script>");
        } catch (Exception e) {
            out.print(e);
        }
    }

}
