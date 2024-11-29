<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Cl�nica Mente & Vida</title>   
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <header class="topo">
        <img src="img/psc.png" alt="Descri��o da imagem" class="logo">
        <h1>Cl�nica Mente & Vida</h1>
        <p>Sa�de Mental e Bem-Estar</p>       
    </header>

    <div class="container">
        <div class="boas-vindas">
            <h2>Bem-vindo(a) ao Sistema da Cl�nica Mente & Vida.</h2>
            <p>Utilize as ferramentas abaixo para otimizar o atendimento aos nossos pacientes.</p>
        </div> 

        <div class="login-container">
            <h2>Login</h2>
            <form id="login-form" action="loginAuth.jsp" method="POST">
                <div class="input-group">
                    <label for="cargo">Entrar como:</label>
                    <select id="cargo" name="cargo" required>
                        <option value="func" selected>Funcion�rio</option>
                        <option value="medic">Medico</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="admin">Privil�gios de administrador:</label>
                    <input type="radio" name="admin" value="false" checked> N�o
                    <input type="radio" name="admin" value="true"> Sim
                </div>
                <div class="input-group">
                    <label for="campo_nome">Usu�rio:</label>
                    <input id="campo_nome" type="text" name="username" placeholder="Entre com o seu usu�rio" required>
                </div>
                <div class="input-group">
                    <label for="campo_senha">Senha:</label>
                    <input id="campo_senha" type="password" name="password" placeholder="Entre com a sua senha" required>
                </div>
                <input type="submit" value="Entrar" class="submit-btn">
                <div id="mensagem" class="error-message"></div>
            </form>
        </div>
    </div>

    <footer class="rodape">
        <p>&copy; 2024 Cl�nica Mente & Vida - Todos os direitos reservados</p>
    </footer>
</body>
</html>
