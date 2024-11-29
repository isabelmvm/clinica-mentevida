<%@page import="com.mentevida.nucleo.Agendamento"%>
<%@page import="com.mentevida.dao.AgendamentoDAO"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.mentevida.nucleo.Funcionario"%>
<%@page import="com.mentevida.dao.FuncionarioDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.nucleo.Medico"%>
<%@page import="com.mentevida.dao.MedicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="A Clínica Mente & Vida oferece serviÃ§os especializados para o diagnÃ³stico e tratamento de transtornos mentais."> 

        <title>Novo Agendamento - Clínica Mente & Vida</title>
        <link rel="stylesheet" href="css/novoAgendamento.css"> <!-- Link para o CSS -->
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
            int idAgendamento = 0;
            LocalDateTime dataAgendamento = null;
            int idPaciente = 0;
            int idMedico = 0;
            int idFuncionario = 0;

            boolean alterar = false;
            if (request.getParameter("idAgendamento") != null) {
                idAgendamento = Integer.parseInt(request.getParameter("idAgendamento"));
                
                AgendamentoDAO dao = new AgendamentoDAO();
                Agendamento agendamento = dao.mostrarIdAgendamento(idAgendamento).get(0);
                dataAgendamento = agendamento.getDataAgendamento();
                idPaciente = agendamento.getPaciente().getIdPaciente();
                idMedico = agendamento.getMedico().getIdMedico();
                idFuncionario = agendamento.getFuncionario().getIdFuncionario();
                
                alterar = true;
            }

            MedicoDAO medDAO = new MedicoDAO();
            FuncionarioDAO funDAO = new FuncionarioDAO();
            List<Medico> medico = medDAO.mostrarTodosMedicos();
            List<Funcionario> funcionario = funDAO.mostrarTodosFuncionarios();

            int i = 0;
            int j = 0;
        %>

        <main>
            <h2>Gerenciar Agendamento</h2>

            <form id="form-agendamento" method="POST" action="ControleAgendamento">
                <label for="id_agendamento">ID:</label>
                <input type="number" value="<%=idAgendamento%>" disabled>
                <input type="hidden" id="idAgendamento" name="idAgendamento" value="<%=idAgendamento%>">

                <label for="data_agendamento">Data:</label>
                <input type="datetime-local" id="data_agendamento" name="data_agendamento" value="<%=dataAgendamento%>" required>

                <label for="status">Status:</label>
                <input type="radio" id="status" name="status" value="true"> Compareceu
                <input type="radio" id="status" name="status" value="false" checked> Não compareceu

                <label for="paciente">Paciente:</label>
                <input type="number" id="paciente" name="paciente" value="<%=idPaciente%>" min="1" placeholder="Nome ou ID" autocomplete="off" required/><a href="paciente.jsp" target="_blank"><button type="button">Procurar</button></a>

                <label for="medico">Medico:</label>
                <input list="medicos" id="medico" name="medico" value="<%=idMedico%>" placeholder="Nome ou ID" autocomplete="off" required/>
                <datalist id="medicos">
                    <%
                        while (i < medico.size()) {
                    %>
                    <option value="<%= medico.get(i).getIdMedico()%>"><%="ID: " + medico.get(i).getIdMedico() + " | " + medico.get(i).getNome()%></option>
                    <%
                            i++;
                        }
                    %>
                </datalist>

                <label for="funcionario">Funcionario:</label>
                <input list="funcionarios" id="funcionario" name="funcionario" value="<%=idFuncionario%>" autocomplete="off" placeholder="Nome ou ID" required/>
                <datalist id="funcionarios">
                    <% while (j < funcionario.size()) {%>
                    <option value="<%= funcionario.get(j).getIdFuncionario()%>"><%="ID: " + funcionario.get(j).getIdFuncionario() + " | " + funcionario.get(j).getNome()%></option>
                    <%
                            j++;
                        }
                    %>
                </datalist> 
                <%
                    if (alterar) {
                        out.print("<input type='hidden' name='alterar' value='true'>");
                    }
                %>
                <p><input type="submit" value= "Efetuar Registro"></p> 
            </form>

            <div class="container">
                <a href="home.html" class="botoes" >Home</a>
                <a href="relatorio.html" class="botoes" >Voltar</a>
            </div>
        </main>

    </body>
</html>
