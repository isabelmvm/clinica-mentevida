package com.mentevida.Servlets;

import com.mentevida.dao.ConnectionManager;
import com.mentevida.dao.PacienteDAO;
import com.mentevida.nucleo.Paciente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import java.time.LocalDate;

@WebServlet(name = "ControlePaciente", urlPatterns = {"/ControlePaciente"})
@MultipartConfig (
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 100
)
public class ControlePaciente extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("excluir") != null && request.getParameter("excluir").equals("true")) {
            try {
                int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                PacienteDAO dao = new PacienteDAO();
                dao.deletarPaciente(idPaciente);
                PrintWriter pw = response.getWriter();
                pw.println("<head><meta charset=\"utf-8\"><head>");
                pw.println("<script>");
                pw.println("alert('Paciente deletado.')");
                pw.println("location='paciente.jsp'");
                pw.println("</script>");
            } catch (Exception e) {
                response.getWriter().print("Erro: " + e);
            }
            return;
        }
        
        String nome = request.getParameter("nome");
        String data_nascimento = request.getParameter("data_nascimento");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        boolean alterar = false;
        
        if (request.getParameter("alterar") != null && request.getParameter("alterar").equals("true")) {
            alterar = true;
        }
        
        try {
            Paciente paciente = null;
            PacienteDAO dao = new PacienteDAO();
            
            if (!alterar) {
                paciente = new Paciente(0, nome, LocalDate.parse(data_nascimento), telefone, email, "");
                
                // adicionar campos do paciente
                dao.cadastrarPaciente(paciente);
            } else {
                int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                Paciente tempPaciente = dao.mostrarIdPacientes(idPaciente).get(0);
                paciente = new Paciente(idPaciente, nome, LocalDate.parse(data_nascimento), telefone, email, tempPaciente.getHistoricoMedico());
                
                dao.alterarPaciente(paciente);
            }
            
            
            if (request.getPart("historico_medico") != null) {
                // upload do arquivo
                if (!alterar) {
                    paciente = dao.mostrarTodosPacientes().getLast();
                }
                String diretorio = ConnectionManager.getDiretorio("Pacientes") + "historico" + paciente.getIdPaciente() + paciente.getNome().replaceAll("\\s", "") + ".pdf";
                String diretorioReal = ConnectionManager.getUploads() + diretorio;

                for (Part part : request.getParts()) {
                    part.write(diretorioReal);
                }
                // atualizar paciente com endereço do upload
                paciente.setHistoricoMedico(diretorio);
                dao.alterarPaciente(paciente);
            }
            
            PrintWriter pw = response.getWriter();
            pw.println("<head><meta charset=\"utf-8\"><head>");
            pw.println("<script>");
            pw.println("alert('Registro efetuado com sucesso!')");
            pw.println("location='paciente.jsp'");
            pw.println("</script>");
        } catch (Exception e) {
            response.getWriter().print("Erro: " + e);
        }
    }
}
