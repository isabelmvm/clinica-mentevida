<%@page import="com.mentevida.nucleo.Funcionario"%>
<%@page import="com.mentevida.dao.FuncionarioDAO"%>
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
            int idFuncionario = 0;
            String nome = "";
            String funcao = "";
            String telefone = "";
            String email = "";
            int idUsuario = 0;
            
            boolean alterar = false;
            boolean usuarioExistente = false;
            String disabled = "";

            if (request.getParameter("idFuncionario") != null) {
                idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));

                FuncionarioDAO dao = new FuncionarioDAO();
                Funcionario funcionario = dao.mostrarIdFuncionario(idFuncionario).get(0);

                idFuncionario = funcionario.getIdFuncionario();
                nome = funcionario.getNome();
                funcao = funcionario.getCargo();
                telefone = funcionario.getTelefone();
                email = funcionario.getEmail();
                idUsuario = funcionario.getIdUsuario();
                if (idUsuario > 0) {
                    usuarioExistente = true;
                    disabled = "disabled";
                }
                
                alterar = true;
            }
        %>

        <h2>Cadastrar Funcionários</h2>  

        <form id="form-funcionario" action="ControleFuncionario" method="POST">
            <label for="funcionario">ID:</label>
            <input type="number" value="<%=idFuncionario%>" disabled></input>

            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" value="<%=nome%>" placeholder="Entre com o nome do Médico" required></input>

            <label for="funcao">Função:</label>
            <input type="text" id="funcao" name="funcao" placeholder="Entre com a funcao do médico" value="<%=funcao%>" required>

            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" value="<%=telefone%>" placeholder="Entre com o telefone do médico" required>

            <label for="email">Email:</label>
            <input type="text" id="email" name="email" value="<%=email%>" placeholder="Entre com o email" required>

            <label for="idUsuario">ID de Usuário:</label>
            <input type="number" id="idusuario" name="idUsuario" min="0" placeholder="Se houver" value="<%=idUsuario%>" <%=disabled%>><br><small>0 = não possui usuário ainda</small>

            <%
                if (alterar) {
                    out.print("<input type='hidden' name='alterar' value='true'>");
                    out.print("<input type='hidden' name='idFuncionario' value='" + idFuncionario + "'>");
                }
                if (usuarioExistente) {
                    out.print("<input type='hidden' name='idUsuario' value='" + idUsuario + "'>");
                }
            %>
            <button type="submit" class="btn">Efetuar Registro</button>
        </form>

        <div class="container">
            <a href="home.jsp" class="botoes" >Home</a>
            <a href="funcionario.jsp" class="botoes" >Voltar</a>
        </div>

    </body>
</html>
