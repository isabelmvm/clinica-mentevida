<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="com.mentevida.nucleo.Relatorio"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.mentevida.dao.RelatorioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM-dd-yyyy");
            
            int idRelatorio = 0;
            LocalDate dataRelatorio = null;
            String endereco = "";
            int idConsulta = 0;
            
            RelatorioDAO dao = new RelatorioDAO();
            List<Relatorio> listaRelatorio = dao.mostrarTodasRelatorios();
            Relatorio relatorio = null;
        %>

        <main>
            <h2>Relatórios Registrados</h2>

            <table width="100%" border="1">
                <tr>
                    <th>ID</th>
                    <th>Data<br>(mês/dia/ano)</th>
                    <th>Endereço</th>
                    <th>Consulta</th>
                    <th>Ações</th>
                </tr>
                
                <%
                    for (int i = 0; i < listaRelatorio.size(); i++) {
                        relatorio = listaRelatorio.get(i);
                        idRelatorio = relatorio.getIdRelatorio();
                        dataRelatorio = relatorio.getDataRelatorio();
                        endereco = relatorio.getEndereco();
                        idConsulta = relatorio.getConsulta().getIdConsulta();
                %>
                
                <tr>
                    <td>
                        <%=idRelatorio%>
                    </td>
                    <td>
                        <%=dataRelatorio.format(dtf)%>
                    </td>
                    <td>
                        <%=endereco%>
                    </td>
                    <td>
                        <%=idConsulta%>
                    </td>
                    <td>
                        <form action="gerenciaRelatorio.jsp" method="POST">
                            <button class="btn-editar">Editar</button>
                            <input type="hidden" name="idRelatorio" value="<%=idRelatorio%>">
                        </form>
                        <form action="ControleRelatorio" method="POST">
                            <button class="btn-excluir">Excluir</button>
                            <input type="hidden" name="idRelatorio" value="<%=idRelatorio%>">
                            <input type='hidden' name='excluir' value='true'>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>

            </table>
            <!-- Botão para adicionar um novo relatório, agora abaixo da tabela -->
            <p><a href="gerenciaRelatorio.jsp" class="novo-relatorio">Novo Relatório</a></p>
        </main>

    </body>
</html>
