package com.mentevida.Servlets;

import com.mentevida.dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleUsuario", urlPatterns = {"/ControleUsuario"})
public class ControleUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        boolean alterar = false;
        String idUsuario = "0";
        if (request.getParameter("idUsuario") != null) {
            idUsuario = request.getParameter("idUsuario");
            alterar = true;
            
        }
        if (request.getParameter("excluir") != null && request.getParameter("excluir").equals("true")) {
            try {
                UsuarioDAO dao = new UsuarioDAO();
                dao.deletarUsuario(Integer.parseInt(idUsuario));
                
                out.println("<head><meta charset=\"utf-8\"><head>");
                out.println("<script>");
                out.println("alert('Registro deletado com sucesso.')");
                out.println("location='usuario.jsp'");
                out.println("</script>");
                return;
            } catch (Exception e) {
                out.print(e);
            }
        }
        
        
        String username = request.getParameter("username");
        String admin = request.getParameter("admin");
        
        String senha = "";
        boolean temSenha = false;
        
        // verifica se senha
        if (request.getParameter("senha") != null) {
            if (request.getParameter("senha").length() > 1) {
                senha = request.getParameter("senha");
                temSenha = true;
            } else {
                out.println("<head><meta charset=\"utf-8\"></head>");
                out.println("<script>");
                out.println("alert('Senha muito curta.')");
                out.println("location = usuario.jsp;");
                out.println("</script>");
                return;
            }
        }
        
        try {
            UsuarioDAO dao = new UsuarioDAO();
            String[] usu = {idUsuario, username, senha, admin};
            
            if (!temSenha) {
                usu = dao.mostrarIdUsuario(Integer.parseInt(idUsuario)).get(0);
                usu[1] = username;
                usu[3] = admin;
            }
            
            if (!alterar) {
                dao.cadastrarUsuario(usu);
            } else {
                dao.alterarUsuario(usu);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Registro efetuado com sucesso!')");
            out.println("location='usuario.jsp'");
            out.println("</script>");
            
        } catch (Exception e) {
            out.print(e);
        }
    }
}
