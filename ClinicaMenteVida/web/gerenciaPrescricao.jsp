<%@page import="com.mentevida.nucleo.Prescricao"%>
<%@page import="com.mentevida.dao.PrescricaoDAO"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
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
        <%
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM-dd-YYYY");

            int idPrescricao = 0;
            LocalDate data = null;
            String medicamentos = "";
            String dosagem = "";
            String instrucoes = "";
            int idConsulta = 0;

            boolean alterar = false;

            if (request.getParameter("idPrescricao") != null) {
                idPrescricao = Integer.parseInt(request.getParameter("idPrescricao"));

                PrescricaoDAO dao = new PrescricaoDAO();
                Prescricao prescricao = dao.mostrarIdPrescricao(idPrescricao).get(0);

                data = prescricao.getDataPrescricao();
                medicamentos = prescricao.getMedicamentos();
                dosagem = prescricao.getDosagem();
                instrucoes = prescricao.getComentario();
                idConsulta = prescricao.getConsulta().getIdConsulta();
                
                alterar = true;
            }
        %>

        <h2>Cadastrar Prescrições</h2>  

        <form id="form-prescricao" action="ControlePrescricao" method="POST">
            <label for="prescricao">Prescrição:</label>
            <input type="number" value="<%=idPrescricao%>" disabled></input>
            <input type="hidden" id="prescricao" name="idPrescricao" value="<%=idPrescricao%>">

            <label for="consulta">Consulta:</label>
            <input type="number" id="consulta" name="consulta" value="<%=idConsulta%>" min="1" placeholder="Entre com o id da consulta" required></input>

            <label for="data_prescricao">Data da Prescrição:</label>
            <input type="date" id="data_prescricao" name="data_prescricao" value="<%=data%>" required>

            <label for="medicamentos">Medicamento:</label>
            <input type="text" id="medicamentos" name="medicamentos" maxlength="200" value="<%=medicamentos%>" placeholder="Entre com o medicamento" required>

            <label for="dosagem">Dosagem:</label>
            <input type="text" id="dosagem" name="dosagem" maxlength="200" value="<%=dosagem%>" placeholder="Entre com a dosagem" required>

            <label for="comentario">Instruções:</label>
            <textarea id="comentario" name="comentario" maxlength="500" rows="8" placeholder="Comentário"><%=instrucoes%></textarea>

            <%
                if (alterar) {
                    out.print("<input type='hidden' name='alterar' value='true'>");
                }
            %>
            <button type="submit" class="btn">Efetuar Registro</button>
        </form>

        <div class="container">
            <a href="home.jsp" class="botoes" >Home</a>
            <a href="relatorio.jsp" class="botoes" >Voltar</a>
        </div>

    </body>
</html>
