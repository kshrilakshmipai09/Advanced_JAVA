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

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = null;
        String reportTitle = "";
        
        try {
            switch (reportType) {
                case "dateRange":
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    patients = dao.getPatientsByDateRange(startDate, endDate);
                    reportTitle = "📅 Patients Admitted from " + startDate + " to " + endDate;
                    break;
                    
                case "ailment":
                    String ailment = request.getParameter("ailment");
                    patients = dao.getPatientsByAilment(ailment);
                    reportTitle = "🏥 Patients with Ailment: " + ailment;
                    break;
                    
                case "doctor":
                    String doctor = request.getParameter("doctor");
                    patients = dao.getPatientsByDoctor(doctor);
                    reportTitle = "👨‍⚕️ Patients assigned to: " + doctor;
                    break;
            }
            
            request.setAttribute("patients", patients);
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("reportType", reportType);
            request.setAttribute("patientCount", patients != null ? patients.size() : 0);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error generating report: " + e.getMessage());
        }
        
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
}