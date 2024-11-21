package com.mentevida.Servlets;

import com.mentevida.dao.ConnectionManager;
import com.mentevida.dao.RelatorioDAO;
import com.mentevida.nucleo.Consulta;
import com.mentevida.nucleo.Relatorio;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ControleRelatorio", urlPatterns = {"/ControleRelatorio"})
@MultipartConfig (
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 100
)
public class ControleRelatorio extends HttpServlet {
    final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        
        int idRelatorio = 0;
        boolean alterar = false;
        
        if (request.getParameter("excluir") != null && request.getParameter("excluir").equals("true")) {
            try {
                idRelatorio = Integer.parseInt(request.getParameter("idRelatorio"));
                RelatorioDAO dao = new RelatorioDAO();
                dao.deletarRelatorio(idRelatorio);
                
                out.println("<head><meta charset=\"utf-8\"><head>");
                out.println("<script>");
                out.println("alert('Registro deletado com sucesso.')");
                out.println("location='relatorio.jsp'");
                out.println("</script>");
            } catch (Exception e) {
                response.getWriter().write(e.getMessage());
            }
        }
        
        if (request.getParameter("alterar") != null && request.getParameter("alterar").equals("true")) {
            idRelatorio = Integer.parseInt(request.getParameter("idRelatorio"));
            alterar = true;
        }
        
        LocalDate dataRelatorio = LocalDate.parse(request.getParameter("data"), dtf);
        Consulta consulta = new Consulta();
        consulta.setIdConsulta(Integer.parseInt(request.getParameter("consulta")));
        
        try {
            RelatorioDAO dao = new RelatorioDAO();
            Relatorio oRelatorio = new Relatorio(idRelatorio, dataRelatorio, "", consulta);
            
            if (!alterar) {
                dao.cadastrarRelatorio(oRelatorio);
                oRelatorio.setIdRelatorio(dao.mostrarTodasRelatorios().getLast().getIdRelatorio());
            } else {
                Relatorio tempRelatorio = dao.mostrarIdRelatorio(idRelatorio).get(0);
                oRelatorio.setEndereco(tempRelatorio.getEndereco());
                dao.alterarRelatorio(oRelatorio);
            }
            
            if (request.getPart("relatorio") != null) {
                String diretorio = ConnectionManager.getDiretorio("Relatorios") + "relatorio" + oRelatorio.getIdRelatorio() + "consulta" + consulta.getIdConsulta() + ".pdf";
                String diretorioReal = ConnectionManager.getUploads() + diretorio;
                for (Part part : request.getParts()) {
                    part.write(diretorioReal);
                }

                oRelatorio.setEndereco(diretorio);
                dao.alterarRelatorio(oRelatorio);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Registro efetuado com sucesso!')");
            out.println("location='relatorio.jsp'");
            out.println("</script>");
        } catch (Exception e) {
            response.getWriter().print("Erro: " + e);
        }
    }
    
}
