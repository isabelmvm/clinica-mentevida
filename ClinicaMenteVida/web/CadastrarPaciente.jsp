<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A Clínica Mente & Vida oferece serviços especializados para o diagnóstico e tratamento de transtornos mentais.">
    <link rel="stylesheet" href="css/cadastraPaciente.css">
    <title>Cadastro de Pacientes - Clínica Mente & Vida</title>
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
        <section class="container">
            <h2>Cadastro de Pacientes</h2>
            <form class="form-paciente">
                <label for="campo_nome">Nome:</label>
                <input type="text" id="campo_nome" placeholder="Nome do Paciente" required>

                <label for="data">Data de Nascimento:</label>
                <input type="date" id="data" name="data" required>

                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone" placeholder="Telefone do paciente" required>

                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email" placeholder="paciente@exemplo.com" required>

                <label for="historico_medico">Histórico Médico:</label>
                <textarea id="historico_medico" name="historico_medico" rows="4" placeholder="Descreva o Histórico Médico do paciente"></textarea>

                <input type="submit" value="Efetuar Cadastro" class="btn cadastrar">
            </form>
            <a href="home.html" class="btn voltar">Voltar para Home</a>
        </section>
    </main>

    <footer class="rodape">
        <p>&copy; 2024 Clínica Mente & Vida - Todos os direitos reservados</p>
    </footer>
</body>
</html>
