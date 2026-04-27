package com.servlet;

import com.dao.HospitalDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("patientId"));
            HospitalDAO dao = new HospitalDAO();
            
            if (dao.deletePatient(id)) {
                request.setAttribute("message", "✓ Patient deleted successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "✗ Patient ID not found!");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "✗ Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("patientdelete.jsp").forward(request, response);
    }
}