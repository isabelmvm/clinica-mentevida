/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mentevida.Servlets;

import com.mentevida.auth.Encryptor;
import com.mentevida.dao.FuncionarioDAO;
import com.mentevida.dao.MedicoDAO;
import com.mentevida.dao.UsuarioDAO;
import com.mentevida.nucleo.Funcionario;
import com.mentevida.nucleo.Medico;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControlePerfil", urlPatterns = {"/ControlePerfil"})
public class ControlePerfil extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        int idCargo = Integer.parseInt(request.getParameter("idCargo")); // 0 = Medico, 1 = Funcionario
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        String _senha = request.getParameter("senha");

        try {
            
            UsuarioDAO usudao = new UsuarioDAO();
            String[] usu = usudao.mostrarIdUsuario(idUsuario).get(0); // {0, 1, 2, 3} = {idUsuario, username. senha, admin}

            // validar senha
            String senhaEncriptada = Encryptor.encrypt(_senha);
            if (!senhaEncriptada.equals(usu[2])) {
                out.println("<head><meta charset=\"utf-8\"></head>");
                out.println("<script>");
                out.println("alert('Senha incorreta.')");
                out.println("location = gerenciaPerfil.jsp");
                out.println("</script>");
                
            } else {
                // verifica se há nova senha
                if (request.getParameter("novaSenha") != null) {
                    if (request.getParameter("novaSenha").length() > 1) {
                        _senha = request.getParameter("novaSenha");
                    } else {
                        out.println("<head><meta charset=\"utf-8\"></head>");
                        out.println("<script>");
                        out.println("alert('Senha muito curta.')");
                        out.println("location = perfil.jsp;");
                        out.println("</script>");
                        return;
                    }
                }

                if (idCargo == 0) {
                    MedicoDAO meddao = new MedicoDAO();
                    Medico medico = meddao.mostrarUserIdMedicos(idUsuario).get(0);
                    medico.setNome(nome);
                    medico.setEmail(email);
                    medico.setTelefone(telefone);
                    
                    medico.setSenha(_senha);
                    usu[2] = medico.getSenha();

                    meddao.alterarMedico(medico);
                    usudao.alterarUsuario(usu);
                } else {
                    FuncionarioDAO fundao = new FuncionarioDAO();
                    
                    Funcionario funcionario = fundao.mostrarUserIdFuncionario(idUsuario).get(0);
                    funcionario.setNome(nome);
                    funcionario.setEmail(email);
                    funcionario.setTelefone(telefone);

                    usu[2] = _senha;

                    fundao.alterarFuncionario(funcionario);
                    usudao.alterarUsuario(usu);
                }
                // mensagem de êxito
                out.println("<head><meta charset=\"utf-8\"><head>");
                out.println("<script>");
                out.println("alert('Registro efetuado com sucesso!')");
                out.println("location='perfil.jsp'");
                out.println("</script>");
            }
        } catch (Exception e) {
            out.println(e);
        }

    }

}
