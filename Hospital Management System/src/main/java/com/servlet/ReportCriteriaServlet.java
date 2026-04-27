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

@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = null;
        String reportTitle = "";
        String reportType = "";
        
        try {
            if ("dateRange".equals(action)) {
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                patients = dao.getPatientsByDateRange(startDate, endDate);
                reportTitle = "📅 Patients Admitted from " + startDate + " to " + endDate;
                reportType = "dateRange";
                
            } else if ("ailment".equals(action)) {
                String ailment = request.getParameter("ailment");
                patients = dao.getPatientsByAilment(ailment);
                reportTitle = "🏥 Patients with Ailment: " + ailment;
                reportType = "ailment";
                
            } else if ("doctor".equals(action)) {
                String doctor = request.getParameter("doctor");
                patients = dao.getPatientsByDoctor(doctor);
                reportTitle = "👨‍⚕️ Patients assigned to: " + doctor;
                reportType = "doctor";
            }
            
            request.setAttribute("patients", patients);
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("reportType", reportType);
            request.setAttribute("patientCount", patients != null ? patients.size() : 0);
            
            if (patients == null || patients.isEmpty()) {
                request.setAttribute("message", "No records found matching your criteria.");
                request.setAttribute("messageType", "warning");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}