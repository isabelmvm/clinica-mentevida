<%@page import="com.mentevida.nucleo.Relatorio"%>
<%@page import="com.mentevida.dao.RelatorioDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="A Clínica Mente & Vida oferece serviços especializados para o diagnóstico e tratamento de transtornos mentais.">
        <link rel="stylesheet" href="css/novoRelatorio.css">
        <title>Novo Relatório</title>
    <head>

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
            int idRelatorio = 0;
            LocalDate data = null;
            int idConsulta = 0;
            String endereco = "";
            boolean alterar = false;

            if (request.getParameter("idRelatorio") != null) {
                idRelatorio = Integer.parseInt(request.getParameter("idRelatorio"));

                RelatorioDAO dao = new RelatorioDAO();
                Relatorio relatorio = dao.mostrarIdRelatorio(idRelatorio).get(0);

                data = relatorio.getDataRelatorio();
                idConsulta = relatorio.getConsulta().getIdConsulta();
                endereco = relatorio.getEndereco();
                alterar = true;
            }
        %>

        <h1>Gerenciar Relatórios</h1>


        <!-- Formulário para adicionar novo relatório -->
        <form id="form-relatorio" action="ControleRelatorio" method="POST" enctype="multipart/form-data">
            <label for="idRelatorio">ID:</label>
            <input type="number" value="<%=idRelatorio%>" disabled>
            <input type="hidden" name="idRelatorio" value="<%=idRelatorio%>">

            <label for="data">Data do Relatorio:</label>
            <input type="date" id="data" name="data" value="<%=data%>" required>

            <label for="consulta">Consulta:</label>
            <input type="number" id="consulta" name="consulta" value="<%=idConsulta%>" min="1" placeholder="Insira o ID da consulta" required>

            <label for="arquivo">Arquivo: <small><%=endereco%></small></label>
            <%
                if (alterar) {
            %>
            <button type="button" id='botaoInserir' onclick='mostrarCampoArquivo()'>Inserir novo arquivo</button><br><br>
            <input type='hidden' name='alterar' value='true'>
            <%
            } else {
            %>
            <input type="file" id="relatorio" name="relatorio" accept=".pdf" required><br><br>
            <%
                }
            %>

            <input type="submit" id='submitBtn' value="Efetuar Registro">
        </form>

        <div class="container">
            <a href="home.jsp" class="botoes" >Home</a>
            <a href="relatorio.jsp" class="botoes" >Voltar</a>
        </div>

        <script>
            const formulario = document.getElementsByTagName("form")[0];
            const mostrarHist = document.getElementById("botaoInserir");
            let clicou = false;

            function mostrarCampoArquivo() {
                let relatorio = document.createElement("input");
                if (!clicou) {
                    relatorio.type = "file";
                    relatorio.name = "relatorio";
                    relatorio.accept = ".pdf";
                    relatorio.id = "relatorio";
                    relatorio.style.display = "block";
                    relatorio.style.paddingBottom = "15px";
                    relatorio.required = true;

                    const submitBtn = document.querySelector("input[type='submit']");
                    formulario.insertBefore(relatorio, submitBtn);
                    mostrarHist.textContent = "Não inserir novo arquivo";
                    clicou = true;
                } else {
                    document.getElementById("relatorio").remove();
                    mostrarHist.textContent = "Inserir novo arquivo";
                    clicou = false;
                }
            }
        </script>

    </body>
</html>