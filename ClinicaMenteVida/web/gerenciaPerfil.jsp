<%@page import="com.mentevida.nucleo.Funcionario"%>
<%@page import="com.mentevida.dao.FuncionarioDAO"%>
<%@page import="com.mentevida.nucleo.Medico"%>
<%@page import="com.mentevida.dao.MedicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Perfil - ClÃ­nica Mente & Vida">

        <link rel="stylesheet" href="css/perfil.css"> <!-- Link para o arquivo CSS -->
    </head>
    <body>
           <header class="topo">
        <img src="img/psc.png" alt="Logo da Clínica Mente & Vida" class="clinica-imagem">
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
            if (session.getAttribute("user") == null || session.getAttribute("cargo") == null || session.getAttribute("admin") == null) {
                response.sendRedirect("index.jsp");
            }
            int idUser = (int) session.getAttribute("user");
            int idCargo = (int) session.getAttribute("cargo"); // 0 = medico, 1 = funcionario

            String nome;
            String email;
            String cargo;
            String telefone;
            String funcao;

            if (idCargo == 0) {
                MedicoDAO dao = new MedicoDAO();
                Medico med = dao.mostrarUserIdMedicos(idUser).get(0);
                nome = med.getNome();
                email = med.getEmail();
                telefone = med.getTelefone();
                funcao = med.getEspecialidade();
                cargo = "Médico";
            } else {
                FuncionarioDAO dao = new FuncionarioDAO();
                Funcionario fun = dao.mostrarUserIdFuncionario(idUser).get(0);
                nome = fun.getNome();
                email = fun.getEmail();
                telefone = fun.getTelefone();
                funcao = fun.getCargo();
                cargo = "Funcionario";
            }
        %>

        <main>
            <h2>Alterar Perfil</h2>

            <div class="container">

                <form action="ControlePerfil" method="POST" onsubmit="return checaSenha()">
                    <label for="name">Nome:</label>
                    <input type="text" id="name" name="nome" value="<%=nome%>" >
                    <input type="hidden" name="idUsuario" value="<%=idUser%>">
                    <input type="hidden" name="idCargo" value="<%=idCargo%>">

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%=email%>" >

                    <label for="telefone">Telefone:</label>
                    <input type="telefone" id="telefone" name="telefone" value="<%=telefone%>" >

                    <label for="funcao">Função:</label>
                    <input type="funcao" id="funcao" value="<%=funcao%>" disabled>

                    <label for="position">Cargo:</label>
                    <input type="text" id="position" value="<%=cargo%>" disabled>

                    <label for="senha" id="senhaLabel">Senha: <button id="mudar-senha" type="button" onclick="mudarSenha()">Alterar Senha</button></label>
                    <input type="password" id="senha" name="senha" placeholder="Confirme sua senha ou clique em alterar" required>

                    <button type="submit" id="submitBtn">Efetuar Registro</button>
                </form>
            </div>

            <script>
                let clicou = false;
                const form = document.getElementsByTagName("form")[0];
                const alteraBtn = document.getElementById("mudar-senha");
                const submitBtn = document.getElementById("submitBtn");

                function mudarSenha() {
                    if (!clicou) {
                        const novaSenhaLabel = document.createElement("label");
                        novaSenhaLabel.for = "novaSenha";
                        novaSenhaLabel.id = "novaSenhaLabel";
                        novaSenhaLabel.textContent = "Nova Senha";
                        const novaSenha = document.createElement("input");
                        novaSenha.type = "password";
                        novaSenha.name = "novaSenha";
                        novaSenha.id = "novaSenha";
                        novaSenha.required = true;

                        const confirmaNovaSenhaLabel = document.createElement("label");
                        confirmaNovaSenhaLabel.for = "confirma";
                        confirmaNovaSenhaLabel.id = "confirmaLabel";
                        confirmaNovaSenhaLabel.textContent = "Confirmar Senha";
                        const confirmaSenha = document.createElement("input");
                        confirmaSenha.type = "password";
                        confirmaSenha.name = "confirma";
                        confirmaSenha.id = "confirma";
                        confirmaSenha.required = true;

                        form.insertBefore(novaSenhaLabel, submitBtn);
                        form.insertBefore(novaSenha, submitBtn);
                        form.insertBefore(confirmaNovaSenhaLabel, submitBtn);
                        form.insertBefore(confirmaSenha, submitBtn);
                        alteraBtn.textContent = "Não alterar senha";
                        clicou = true;
                    } else {
                        document.getElementById("novaSenhaLabel").remove();
                        document.getElementById("novaSenha").remove();
                        document.getElementById("confirmaLabel").remove();
                        document.getElementById("confirma").remove();
                        clicou = false;
                    }
                }

                function checaSenha() {
                    const password = document.querySelector('input[name=novaSenha]');
                    const confirma = document.querySelector('input[name=confirma]');
                    if (confirma.value === password.value) {
                        return true;
                    } else {
                        alert("Senhas não batem");
                        return false;
                    }
                }
            </script>

    </body>
</html>