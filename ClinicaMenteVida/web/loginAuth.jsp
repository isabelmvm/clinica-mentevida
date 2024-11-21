<%@page import="com.mentevida.dao.MedicoDAO"%>
<%@page import="com.mentevida.nucleo.Medico"%>
<%@page import="com.mentevida.nucleo.Funcionario"%>
<%@page import="com.mentevida.dao.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mentevida.auth.Encryptor"%>
<%@page import="com.mentevida.dao.UsuarioDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            private int validarCargo(String cargo) {
                int cargoValue;
                switch (cargo.toLowerCase()) {
                    case "medic":
                        cargoValue = 0;
                        break;
                    case "func":
                        cargoValue = 1;
                        break;
                    default:
                        cargoValue = -1;
                        break;
                }
                return cargoValue;
            }

            private boolean validaFuncionario(int id) {
                Funcionario func = null;
                try {
                    FuncionarioDAO dao = new FuncionarioDAO();
                    func = dao.mostrarUserIdFuncionario(id).get(0);
                } catch (Exception e) {
                    return false;
                }
                if (func == null) {
                    return false;
                }
                return true;
            }

            private boolean validaMedico(int id) {
                Medico med = null;
                try {
                    MedicoDAO dao = new MedicoDAO();
                    med = dao.mostrarUserIdMedicos(id).get(0);
                } catch (Exception e) {
                    return false;
                }
                if (med == null) {
                    return false;
                }
                return true;
            }
        %>
        <%
            String _username = request.getParameter("username");
            String _password = Encryptor.encrypt(request.getParameter("password"));
            int cargo = validarCargo(request.getParameter("cargo"));
            boolean login = false;
            boolean admin = false;

            UsuarioDAO dao = new UsuarioDAO();
            try {
                // Procura o usuário na database
                String[] user = dao.mostrarUsernameUsuarios(_username).get(0); // {0, 1, 2, 3} = {id, username, senha, admin}

                // validação de senha
                if (!user[2].equals(_password)) {
                    out.print("Senha incorreta.");
                    out.print("<a href='index.jsp'>Voltar</a>");
                } else {
                    // validar cargo
                    out.print(cargo);
                    switch (cargo) {
                        case 0:
                            if (validaMedico(Integer.parseInt(user[0]))) {
                                login = true;
                            }
                            break;
                        case 1:
                            if (validaFuncionario(Integer.parseInt(user[0]))) {
                                login = true;
                            }
                            break;
                        default:
                            break;
                    }
                    
                    if (request.getParameter("admin") != null) {
                        if (request.getParameter("admin").equals("true") && Boolean.valueOf(user[3])) {
                            admin = Boolean.valueOf(user[3]);
                        } else {
                            admin = false;
                        }
                    }

                    if (login) {

                        session.setAttribute("user", Integer.parseInt(user[0]));
                        session.setAttribute("cargo", cargo);
                        session.setAttribute("admin", admin);
                        response.sendRedirect("home.jsp");
                    } else {
                        out.print("Login inválido.");
                    }
                }
                // usuário não encontrado
            } catch (Exception ignore) {
                out.print("Usuário inválido.<br>");
                out.print("<a href='index.jsp'>Voltar</a>");
                session.setAttribute("login", false);
            }

        %>
    </body>
</html>
