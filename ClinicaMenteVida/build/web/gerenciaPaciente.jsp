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
        <meta name="description" content="Cadastro de Novo Paciente - Clínica Mente & Vida">
        <title>Gerenciar Paciente</title>
        <link rel="stylesheet" href="css/novoPaciente.css">
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
            int idPaciente = 0;
            String nome = "";
            String dataNascimento = "";
            String telefone = "";
            String email = "";
            String teste = "teste";

            boolean atualizar = false;
            Paciente paciente = null;
            if (request.getParameter("idPaciente") != null) {
                atualizar = true;
                idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                PacienteDAO dao = new PacienteDAO();
                paciente = dao.mostrarIdPacientes(idPaciente).get(0);

                nome = paciente.getNome();
                dataNascimento = paciente.getDataNascimento().toString();
                telefone = paciente.getTelefone();
                email = paciente.getEmail();
            }
        %>

        <main>
            <h2>Novo Paciente</h2>
            <!-- Formulário para Cadastro/Alteração de Paciente -->
            <form id="form-paciente" action="ControlePaciente" method="POST" enctype="multipart/form-data">
                <label for="nome">Nome Completo:</label>
                <input type="text" id="nome" name="nome" value="<%= nome%>" placeholder="Digite o nome do paciente" required><br><br>

                <label for="data_nascimento">Data de Nascimento (mês/dia/ano):</label>
                <input type="date" id="data_nascimento" name="data_nascimento" value="<%= dataNascimento%>" required><br><br>

                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone" value="<%= telefone%>" placeholder="Digite o telefone" required><br><br>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email%>" placeholder="Digite o email" required><br><br>
                
                <%
                    if (!atualizar) {
                %>            
                <label for="historico_medico">Histórico Médico (Arquivo):</label> 
                <input type="file" id="historico_medico" name="historico_medico" accept=".pdf"><br><br>
                <%
                    } else {
                %>
                <button id="mostrarHist" type="button" onclick="mostrarCampoArquivo()">Inserir novo histórico</button><br><br>
                <input type="hidden" id="alterar" name="alterar" value="true">
                <input type="hidden" name="idPaciente" value="<%=idPaciente%>">
                <%
                    }
                %>
                <input type="submit" value="Cadastrar Paciente">
            </form>
            <script>
                const formulario = document.getElementsByTagName("form")[0];
                const mostrarHist = document.getElementById("mostrarHist");
                let clicou = false;
                
                function mostrarCampoArquivo() {
                    let historicoLabel = document.createElement("label");
                    let historicoArquivo = document.createElement("input");
                    if (!clicou) {
                        historicoLabel.for = "historico_medico";
                        historicoLabel.innerText = "Novo Histórico Médico:";
                        historicoLabel.id = "historicoLabel";

                        historicoArquivo.type = "file";
                        historicoArquivo.name = "historico_medico";
                        historicoArquivo.accept = ".pdf";
                        historicoArquivo.id = "historicoArquivo";
                        historicoArquivo.style.display = "block";
                        historicoArquivo.style.paddingBottom = "15px";
                        historicoArquivo.required = true;

                        const submitBtn = document.querySelector("input[type='submit']");
                        formulario.insertBefore(historicoLabel, submitBtn);
                        formulario.insertBefore(historicoArquivo, submitBtn);
                        mostrarHist.textContent = "Não atualizar o histórico";
                        clicou = true;
                    } else {
                        document.getElementById("historicoArquivo").remove();
                        document.getElementById("historicoLabel").remove();
                        mostrarHist.textContent = "Inserir novo histórico";
                        clicou = false;
                    }
                }
            </script>
    </body>
</html>
