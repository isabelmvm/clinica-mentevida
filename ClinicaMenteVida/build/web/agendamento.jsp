<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.mentevida.dao.FuncionarioDAO"%>
<%@page import="com.mentevida.nucleo.Funcionario"%>
<%@page import="com.mentevida.nucleo.Medico"%>
<%@page import="com.mentevida.nucleo.Paciente"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.nucleo.Agendamento"%>
<%@page import="com.mentevida.dao.MedicoDAO"%>
<%@page import="com.mentevida.dao.PacienteDAO"%>
<%@page import="com.mentevida.dao.AgendamentoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="A Clínica Mente & Vida oferece serviÃ§os especializados para o diagnóstico e tratamento de transtornos mentais."> 

        <link rel="stylesheet" href="css/agendamento.css"> <!-- Link para o CSS -->
            
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
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM-dd-yyyy HH:mm");
            AgendamentoDAO dao = new AgendamentoDAO();
            PacienteDAO pDao = new PacienteDAO();
            MedicoDAO mDao = new MedicoDAO();
            FuncionarioDAO fDao = new FuncionarioDAO();

            List<Agendamento> listaAgendamento = null;
            Agendamento agendamento = null;
            Paciente paciente = null;
            Medico medico = null;
            Funcionario funcionario = null;

            int idAgendamento = 0;
            LocalDateTime dataAgendamento = null;
            Boolean status = false;
            String nomePaciente = "";
            String nomeMedico = "";
            String nomeFuncionario = "";


        %>

        <main>
            <h2>Visualizar Agendamento</h2>

            <table width="100%" border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Data<br>(mês/dia/ano)</th>
                        <th>Status</th>
                        <th>Paciente</th>
                        <th>Medico</th>
                        <th>Funcionario</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%                        
                        listaAgendamento = dao.mostrarTodosAgendamentos();

                        for (int i = 0; i < listaAgendamento.size(); i++) {
                            agendamento = listaAgendamento.get(i);
                            paciente = pDao.mostrarIdPacientes(agendamento.getPaciente().getIdPaciente()).get(0);
                            medico = mDao.mostrarIdMedicos(agendamento.getMedico().getIdMedico()).get(0);
                            funcionario = fDao.mostrarIdFuncionario(agendamento.getFuncionario().getIdFuncionario()).get(0);

                            idAgendamento = agendamento.getIdAgendamento();
                            dataAgendamento = agendamento.getDataAgendamento();
                            status = agendamento.getStatus();
                            nomePaciente = paciente.getNome();
                            nomeMedico = medico.getNome();
                            nomeFuncionario = funcionario.getNome();
                    %>
                    <tr>
                        <td>
                            <%=idAgendamento%>
                        </td>
                        <td>
                            <%=dataAgendamento.format(dtf)%>
                        </td>
                        <td>
                            <%=status%>
                        </td>
                        <td>
                            <%=nomePaciente%>
                        </td>
                        <td>
                            <%=nomeMedico%>
                        </td>
                        <td>
                            <%=nomeFuncionario%>
                        </td>

                        <td>
                            <form class="botoesAcao" action="gerenciaAgendamento.jsp" method="POST">
                                <button class="btn-editar">
                                    Editar
                                </button>
                                <input type="hidden" name="idAgendamento" value="<%=idAgendamento%>">
                            </form>

                            <form class="botoesAcao" action="ControleAgendamento" method="POST" onsubmit="return confirm('Você tem certeza de que quer excluir o agendamento <%=idAgendamento%>?');">
                                <input type="hidden" name="idAgendamento" value="<%=idAgendamento%>">
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
                </tbody>
            </table>
            <p><a href="gerenciaAgendamento.jsp" class="novo-agendamento">Novo Agendamento</a></p>
        </main>

    </body>
</html>
