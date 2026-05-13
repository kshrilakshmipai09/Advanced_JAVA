package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            HospitalDAO dao = new HospitalDAO();
            
            Patient patient = dao.getPatientById(id);
            
            boolean success = false;
            
            if (patient != null) {
                // Save to deleted records before deleting
                success = dao.saveToDeletedPatients(patient);
                
                if (success) {
                    success = dao.deletePatient(id);
                }
            }
            
            if (success && patient != null) {
                String patientName = patient.getPatientName();
                String encodedName = URLEncoder.encode(patientName, "UTF-8");
                response.sendRedirect("patientdisplay.jsp?deletedId=" + id + "&deletedName=" + encodedName);
            } else {
                response.sendRedirect("patientdisplay.jsp?status=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("patientdisplay.jsp?status=failed");
        }
    }
}