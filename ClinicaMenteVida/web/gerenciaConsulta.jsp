<%@page import="com.mentevida.nucleo.Medico"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.dao.MedicoDAO"%>
<%@page import="com.mentevida.nucleo.Consulta"%>
<%@page import="com.mentevida.dao.ConsultaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/prescricao.css">

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
            int idConsulta = 0;
            int duracao = 0;
            double valor = 0;
            int idPaciente = 0;
            int idMedico = 0;
            
            boolean alterar = false;
            boolean usuarioExistente = false;
            String disabled = "";

            if (request.getParameter("idConsulta") != null) {
                idConsulta = Integer.parseInt(request.getParameter("idConsulta"));

                ConsultaDAO dao = new ConsultaDAO();
                Consulta consulta = dao.mostrarIdConsulta(idConsulta).get(0);

                idConsulta = consulta.getIdConsulta();
                duracao = consulta.getDuracao();
                idPaciente = consulta.getPaciente().getIdPaciente();
                idMedico = consulta.getMedico().getIdMedico();
                
                alterar = true;
            }
            
            MedicoDAO medDAO = new MedicoDAO();
            List<Medico> medico = medDAO.mostrarTodosMedicos();
            int i = 0;
            int j = 0;
        %>

        <h2>Cadastrar Consultas</h2>  

        <form id="form-consulta" action="ControleConsulta" method="POST">
            <label for="consulta">ID:</label>
            <input type="number" value="<%=idConsulta%>" disabled></input>

            <label for="duracao">Duração: (minutos)</label>
            <input type="number" id="duracao" name="duracao" value="<%=duracao%>" placeholder="Entre com a duração da Consulta" required></input>

            <label for="valor">Valor (R$):</label>
            <input type="number" id="valor" name="valor" placeholder="Entre com o valor da consulta" value="<%=valor%>" required>

            <label for="paciente">Paciente (ID):</label>
            <input type="number" id="paciente" name="paciente" value="<%=idPaciente%>" placeholder="Entre com  ID do paciente" required>
            <a href="paciente.jsp" target="_blank"><button type="button">Procurar</button></a>

            <label for="medico">Medico:</label>
            <input list="medicos" id="medico" name="medico" value="<%=idMedico%>" placeholder="Precione espaço para ver a lista" autocomplete="off" required/><small>(Precione espaço para ver a lista)</small>
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
            
            <%
                if (alterar) {
                    out.print("<input type='hidden' name='alterar' value='true'>");
                    out.print("<input type='hidden' name='idConsulta' value='" + idConsulta + "'>");
                }
            %>
            <button type="submit" class="btn">Efetuar Registro</button>
        </form>

        <div class="container">
            <a href="home.jsp" class="botoes" >Home</a>
            <a href="consulta.jsp" class="botoes" >Voltar</a>
        </div>

    </body>
</html>
