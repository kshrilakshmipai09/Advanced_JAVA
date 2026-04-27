package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/UpdatePatientServlet")
public class UpdatePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("patientId"));
            String name = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String dateStr = request.getParameter("admissionDate");
            String ailment = request.getParameter("ailment");
            String doctor = request.getParameter("assignedDoctor");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date admissionDate = sdf.parse(dateStr);
            
            Patient patient = new Patient(id, name, age, gender, admissionDate, ailment, doctor);
            HospitalDAO dao = new HospitalDAO();
            
            if (dao.updatePatient(patient)) {
                request.setAttribute("message", "✓ Patient updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "✗ Patient ID not found!");
                request.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "✗ Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            HospitalDAO dao = new HospitalDAO();
            Patient patient = dao.getPatientById(Integer.parseInt(id));
            request.setAttribute("patient", patient);
        }
        request.getRequestDispatcher("patientupdate.jsp").forward(request, response);
    }
}