<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.nucleo.Paciente"%>
<%@page import="com.mentevida.dao.PacienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="A Clínica Mente & Vida oferece serviços especializados para o diagnóstico e tratamento de transtornos mentais.">
        <link rel="stylesheet" href="css/paciente.css">
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
        
        <main>
            <h2>Gerenciar Pacientes</h2>
            
            <p>
                <form action="paciente.jsp" method="GET">
                Pesquisar: 
                    <input type="text" name="nome" size="100" placeholder="insira um nome e clique em Pesquisar">
                    <input type="submit" value="Pesquisar">
                </form>
            </p>

            <table width="100%" border="1">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Data de Nascimento<br>(mês/dia/ano)</th>
                    <th>Telefone</th>
                    <th>Email</th>
                    <th>Histórico Médico</th>
                    <th>Ações</th>
                </tr>
                <%
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM-dd-YYYY");
                    PacienteDAO dao = new PacienteDAO();
                    List<Paciente> paciente;
                    String nome = null;
                    if (request.getParameter("nome") != null) {
                        nome = (String) request.getParameter("nome");
                        paciente = dao.mostrarNomePacientes(nome);
                    } else {
                        paciente = dao.mostrarTodosPacientes();
                    }
                    
                    for (int i = 0; i < paciente.size(); i++) {
                %>
                <tr>
                    <td>
                        <%= paciente.get(i).getIdPaciente() %>
                    </td>
                    <td>
                        <%= paciente.get(i).getNome() %>
                    </td>
                    <td>
                        <%= paciente.get(i).getDataNascimento().format(dtf) %>
                    </td>
                    <td>
                        <%= paciente.get(i).getTelefone() %>
                    </td>
                    <td>
                        <%= paciente.get(i).getEmail() %>
                    </td>
                    <td>
                        <%= paciente.get(i).getHistoricoMedico() %>
                    </td>
                    <td>
                        <form class="botoesAcao" action="gerenciaPaciente.jsp" method="POST">
                           <input type="hidden" name="idPaciente" value="<%=paciente.get(i).getIdPaciente()%>">
                            <button class="btn-editar"> 
                                Editar
                            </button>
                        </form>
                        
                        <form class="botoesAcao" action="ControlePaciente" method="POST" onsubmit="return confirm('Você tem certeza de que quer excluir o paciente <%=paciente.get(i).getIdPaciente()%>?');">
                            <input type="hidden" name="idPaciente" value="<%=paciente.get(i).getIdPaciente()%>">
                            <input type="hidden" name="excluir" value="true">
                            <button class="btn-excluir">
                                Excluir
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>

            <p><a href="gerenciaPaciente.jsp" class="novo-Paciente">Novo Paciente</a></p> 
        </main>
    </body>
</html>
