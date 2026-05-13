package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String admissionDate = request.getParameter("admissionDate");
            String ailment = request.getParameter("ailment");
            String doctor = request.getParameter("assignedDoctor");

            Patient patient = new Patient(name, age, gender, admissionDate, ailment, doctor);
            
            HospitalDAO dao = new HospitalDAO();
            boolean success = dao.addPatient(patient);

            if (success) {
                response.sendRedirect("patientdisplay.jsp");
            } else {
                response.sendRedirect("patientadd.jsp?status=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("patientadd.jsp?status=failed");
        }
    }
}