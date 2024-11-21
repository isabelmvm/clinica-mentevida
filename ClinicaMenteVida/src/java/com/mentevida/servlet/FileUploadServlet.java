package com.mentevida.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Part;
import java.io.IOException;

@WebServlet(name = "FileUploadServlet", urlPatterns = {"/fileuploadservlet"})
@MultipartConfig (
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 100
)
public class FileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        
        for (Part part : request.getParts()) {
            part.write("C:\\upload\\" + fileName);
        }
        response.getWriter().print("The file has been uploaded");
    }

}
