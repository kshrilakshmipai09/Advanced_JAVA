package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DisplayPatientsServlet")  // Make sure this matches
public class DisplayPatientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DisplayPatientsServlet called!"); // Debug line
        
        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = dao.getAllPatients();
        
        System.out.println("Patients found: " + (patients != null ? patients.size() : 0)); // Debug
        
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("patientdisplay.jsp").forward(request, response);
    }
}