package com.mentevida.Servlets;

import com.mentevida.dao.FuncionarioDAO;
import com.mentevida.nucleo.Funcionario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControleFuncionario", urlPatterns = {"/ControleFuncionario"})
public class ControleFuncionario extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        try {
            FuncionarioDAO dao = new FuncionarioDAO();
            
            int idFuncionario = 0;
            boolean alterar = false;
            boolean excluir = false;

            if (request.getParameter("idFuncionario") != null) {
                idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));
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
                String funcao = request.getParameter("funcao");
                String telefone = request.getParameter("telefone");
                String email = request.getParameter("email");
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

                // Operação Insert e Update
                Funcionario funcionario = new Funcionario(idFuncionario, nome, telefone, email, funcao, idUsuario, "", "", false);
                if (!alterar) {
                    dao.cadastrarFuncionario(funcionario);
                } else {
                    dao.alterarFuncionario(funcionario);
                }
                
            } else {
                // operação delete
                dao.deletarFuncionario(idFuncionario);
            }
            
            out.println("<head><meta charset=\"utf-8\"><head>");
            out.println("<script>");
            out.println("alert('Operação efetuada com sucesso!')");
            out.println("location='funcionario.jsp'");
            out.println("</script>");
        } catch (Exception e) {
            out.print(e);
        }
    }

}
