<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.mentevida.nucleo.Prescricao"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.dao.PrescricaoDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Gerenciamento de Relatórios da Clínica Mente & Vida.">
        <title>Prescrições - Clínica Mente & Vida</title>
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
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM-dd-YYYY");

            int idPrescricao = 0;
            LocalDate data = null;
            String medicamentos = "";
            String dosagem = "";
            String instrucoes = "";
            int idConsulta = 0;
        %>

        <main>
            <h2>Prescrições Registradas</h2>


            <table width="100%" border="1">
                <tr>
                    <th>ID</th>
                    <th>Data<br>(mês/dia/ano)</th>
                    <th>Medicamentos</th>
                    <th>Dosagem</th>
                    <th>Instruções</th>
                    <th>ID Consulta</th>
                    <th>Ações</th>
                </tr>
                <%
                    PrescricaoDAO dao = new PrescricaoDAO();
                    List<Prescricao> prescricoes = dao.mostrarTodasPrescricoes();
                    Prescricao prescricao = null;
                    int i = 0;
                    while (i < prescricoes.size()) {
                        prescricao = prescricoes.get(i);

                        idPrescricao = prescricao.getIdPrescricao();
                        data = prescricao.getDataPrescricao();
                        medicamentos = prescricao.getMedicamentos();
                        dosagem = prescricao.getDosagem();
                        instrucoes = prescricao.getComentario();
                        idConsulta = prescricao.getConsulta().getIdConsulta();
                %>
                <tr>
                    <td>
                        <%=idPrescricao%>
                    </td>
                    <td>
                        <%=data.format(dtf)%>
                    </td>
                    <td>
                        <%=medicamentos%>
                    </td>
                    <td>
                        <%=dosagem%>
                    </td>
                    <td>
                        <%=instrucoes%>
                    </td>
                    <td>
                        <%=idConsulta%>
                    </td>
                    <td>
                        <form class="botoesAcao" action="gerenciaPrescricao.jsp" method="POST">
                            <button class="btn-editar">
                                Editar
                            </button>
                            <input type="hidden" name="idPrescricao" value="<%=idPrescricao%>">
                        </form>

                        <form class="botoesAcao" action="ControlePrescricao" method="POST" onsubmit="return confirm('Você tem certeza de que quer excluir a prescrição <%=idPrescricao%>?');">
                            <input type="hidden" name="idPrescricao" value="<%=idPrescricao%>">
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
            <!-- Botão para adicionar um novo relatório, agora abaixo da tabela -->
            <p><a href="gerenciaPrescricao.jsp" class="novo-relatorio">Nova Prescrição</a></p>
        </main>

    </body>
</html>
