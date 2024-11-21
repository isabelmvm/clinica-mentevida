<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="A Clínica Mente & Vida oferece serviços especializados para o diagnóstico e tratamento de transtornos mentais.">
        <link rel="stylesheet" href="css/home.css">
        <title>Home - Clínica Mente & Vida</title>
    </head>
    <body>
        <%
            int idUser = -1;
            int cargo = -1;
            boolean admin = false;
            if (session.getAttribute("user") == null || session.getAttribute("cargo") == null || session.getAttribute("admin") == null) {
                response.sendRedirect("index.jsp");
            } else {
                idUser = (int) session.getAttribute("user");
                cargo = (int) session.getAttribute("cargo");
                admin = (boolean) session.getAttribute("admin");
            }
        %>
        <header class="topo">
            <img src="img/psc.png" alt="Logo da Clínica" class="clinica-imagem">

            <div> <h1>Clínica Mente & Vida</h1>
                <p>Saúde Mental e Bem-Estar</p> 
            </div>


            <div class="menu">       
                <nav class="navbar">
                    <ul>
                        <li onclick="location = 'home.jsp'">Início</li>
                        <li onclick="redireciona('paciente.jsp')">Pacientes</li>
                        <li onclick="redireciona('medico.jsp')">Médicos</li>
                        <li onclick="redireciona('funcionario.jsp')">Funcionários</li>
                        <li onclick="redireciona('agendamento.jsp')">Agendamentos</li>
                        <li onclick="redireciona('consulta.jsp')">Consultas</li>
                        <li onclick="redireciona('prescricao.jsp')">Prescrições</li>
                        <li onclick="redireciona('relatorio.jsp')">Relatórios</li>
                            <% if (admin) {
                            out.print("<li onclick=\"redireciona('usuario.jsp')\">Usuarios<li>");
                        }%>
                        <li onclick="redireciona('perfil.jsp')">Perfil</li>
                    </ul>
                </nav>
            </div>      
        </header>

        <section>
            <iframe id="frame" src=""></iframe>
        </section>

        <footer class="rodape">
            <p>&copy; 2024 Clínica Mente & Vida - Todos os direitos reservados</p>
        </footer>
        <script>
            const iframe = document.getElementById("frame");
            function redireciona(pagina) {
                iframe.src = pagina;
            }
        </script>
    </body>
</html>
