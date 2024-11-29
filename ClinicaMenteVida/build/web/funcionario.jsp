<%@page import="com.mentevida.nucleo.Funcionario"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.dao.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Gerenciamento de Funcionários da Clínica Mente & Vida.">
        <title>Funcionarios - Clínica Mente & Vida</title>
        <link rel="stylesheet" href="css/relatorio.css">
    </head>
    <body>
         <header class="topo">
        <img src="img/psc.png" alt="Logo da Clínica" class="clinica-imagem">
        <div>
            <h1>Clínica Mente & Vida</h1>
            <p>Saúde Mental e Bem-Estar</p>
        </div>
        <nav class="menu">
            <ul class="nav-list">
                <li onclick="location = 'home.jsp'">Início</li>
                <li onclick="location = 'paciente.jsp'">Pacientes</li>
                <li onclick="location = 'medico.jsp'">Médicos</li>
                <li onclick="location = 'funcionario.jsp'">Funcionários</li>
                <li onclick="location = 'agendamento.jsp'">Agendamentos</li>
                <li onclick="location = 'consulta.jsp'">Consultas</li>
                <li onclick="location = 'prescricao.jsp'">Prescrições</li>
                <li onclick="location = 'relatorio.jsp'">Relatórios</li>
                <li onclick="location = 'perfil.jsp'">Perfil</li>
            </ul>
        </nav>
    </header>

        <%
            int idFuncionario = 0;
            String nome = "";
            String funcao = "";
            String telefone = "";
            String email = "";
            int idUsuario = 0;
        %>

        <main>
            <h2>Funcionarios Registrados</h2>

            <table width="100%" border="1">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Função</th>
                    <th>Telefone</th>
                    <th>Email</th>
                    <th>ID Usuario</th>
                    <th>Ações</th>
                </tr>
                <%
                    FuncionarioDAO dao = new FuncionarioDAO();
                    List<Funcionario> listaFuncionario = dao.mostrarTodosFuncionarios();
                    Funcionario funcionario = null;
                    int i = 0;
                    while (i < listaFuncionario.size()) {
                        funcionario = listaFuncionario.get(i);

                        idFuncionario = funcionario.getIdFuncionario();
                        nome = funcionario.getNome();
                        funcao = funcionario.getCargo();
                        telefone = funcionario.getTelefone();
                        email = funcionario.getEmail();
                        idUsuario = funcionario.getIdUsuario();
                %>
                <tr>
                    <td>
                        <%=idFuncionario%>
                    </td>
                    <td>
                        <%=nome%>
                    </td>
                    <td>
                        <%=funcao%>
                    </td>
                    <td>
                        <%=telefone%>
                    </td>
                    <td>
                        <%=email%>
                    </td>
                    <td>
                        <%=idUsuario%>
                    </td>
                    <td>
                        <form class="botoesAcao" action="gerenciaFuncionario.jsp" method="POST">
                            <button class="btn-editar">
                                Editar
                            </button>
                            <input type="hidden" name="idFuncionario" value="<%=idFuncionario%>">
                        </form>

                        <form class="botoesAcao" action="ControleFuncionario" method="POST" onsubmit="return confirm('Você tem certeza de que quer excluir o funcionário <%=idFuncionario%>?');">
                            <input type="hidden" name="idFuncionario" value="<%=idFuncionario%>">
                            <input type="hidden" name="excluir" value="true">
                            <button class="btn-excluir">
                                Excluir
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                        i++;
                    }
                %>

            </table>
                
            <p><a href="gerenciaFuncionario.jsp" class="novo-relatorio">Novo Médico</a></p>
        </main>

    </body>
</html>
