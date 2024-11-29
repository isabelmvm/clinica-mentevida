<%@page import="com.mentevida.nucleo.Medico"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.dao.MedicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Gerenciamento de Funcionários da Clínica Mente & Vida.">
        <title>Medicos - Clínica Mente & Vida</title>
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
            int idMedico = 0;
            String nome = "";
            String especialidade = "";
            String telefone = "";
            String email = "";
            int idUsuario = 0;
        %>

        <main>
            <h2>Medicos Registrados</h2>


            <table width="100%" border="1">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Especialidade</th>
                    <th>Telefone</th>
                    <th>Email</th>
                    <th>ID Usuario</th>
                    <th>Ações</th>
                </tr>
                <%
                    MedicoDAO dao = new MedicoDAO();
                    List<Medico> listaMedico = dao.mostrarTodosMedicos();
                    Medico medico = null;
                    int i = 0;
                    while (i < listaMedico.size()) {
                        medico = listaMedico.get(i);

                        idMedico = medico.getIdMedico();
                        nome = medico.getNome();
                        especialidade = medico.getEspecialidade();
                        telefone = medico.getTelefone();
                        email = medico.getEmail();
                        idUsuario = medico.getIdUsuario();
                %>
                <tr>
                    <td>
                        <%=idMedico%>
                    </td>
                    <td>
                        <%=nome%>
                    </td>
                    <td>
                        <%=especialidade%>
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
                        <form class="botoesAcao" action="gerenciaMedico.jsp" method="POST">
                            <button class="btn-editar">
                                Editar
                            </button>
                            <input type="hidden" name="idMedico" value="<%=idMedico%>">
                        </form>

                        <form class="botoesAcao" action="ControleMedico" method="POST" onsubmit="return confirm('Você tem certeza de que quer excluir o médico <%=idMedico%>?');">
                            <input type="hidden" name="idMedico" value="<%=idMedico%>">
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
                
            <p><a href="gerenciaMedico.jsp" class="novo-relatorio">Novo Médico</a></p>
        </main>

    </body>
</html>
