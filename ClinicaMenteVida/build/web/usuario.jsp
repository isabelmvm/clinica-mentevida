<%@page import="java.util.List"%>
<%@page import="com.mentevida.nucleo.Usuario"%>
<%@page import="com.mentevida.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="A Clínica Mente & Vida oferece serviços especializados para o diagnóstico e tratamento de transtornos mentais.">
        <link rel="stylesheet" href="css/usuario.css">
    </head>
    <body>
        
        <main>
            <h2>Gerenciar Usuarios</h2>
            
            <p>
                <form action="usuario.jsp" method="GET">
                Pesquisar: 
                    <input type="text" name="username" size="100" placeholder="insira um nome e clique em Pesquisar">
                    <input type="submit" value="Pesquisar">
                </form>
            </p>

            <table width="100%" border="1">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Admin</th>
                    <th>Nome</th>
                    <th>Cargo</th>
                    <th>ID</th>
                    <th>Ações</th>
                </tr>
                <%
                    UsuarioDAO dao = new UsuarioDAO();
                    List<String[]> usuario;
                    String nomePesquisa = null;
                    
                    String idUsuario = "";
                    String username = "";
                    String admin = "";
                    String nome = "";
                    String cargo = "";
                    String id = "";
                    
                    
                    
                    
                    if (request.getParameter("username") != null) {
                        nomePesquisa = request.getParameter("username");
                        usuario = dao.pesquisarUsernameUsuarios(nomePesquisa); // resultado = {id, username, senha, admin, nome, cargo, id(func/medico)}
                    } else {
                        usuario = dao.mostrarTodosUsuarios(); // resultado = {id, username, senha, admin, nome, cargo, id(func/medico)}
                    }
                    
                    for (int i = 0; i < usuario.size(); i++) {
                        idUsuario = usuario.get(i)[0];
                        username = usuario.get(i)[1];
                        admin = usuario.get(i)[3];
                        nome = usuario.get(i)[4];
                        cargo = usuario.get(i)[5];
                        id = usuario.get(i)[6];
                %>
                <tr>
                    <td>
                        <%= idUsuario %>
                    </td>
                    <td>
                        <%= username %>
                    </td>
                    <td>
                        <%= admin %>
                    </td>
                    <td>
                        <%= nome %>
                    </td>
                    <td>
                        <%= cargo %>
                    </td>
                    <td>
                        <%= id %>
                    </td>
                    <td>
                        <form class="botoesAcao" action="gerenciaUsuario.jsp" method="POST">
                            <button>
                                Editar
                            </button>
                            <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                        </form>
                        
                        <form class="botoesAcao" action="ControleUsuario" method="POST" onsubmit="return confirm('Você tem certeza de que quer excluir o usuario <%=idUsuario%>?');">
                            <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                            <input type="hidden" name="excluir" value="true">
                            <button>
                                Excluir
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>

            <p><a href="gerenciaUsuario.jsp" class="novo-Usuario">Novo Usuario</a></p> 
        </main>
    </body>
</html>