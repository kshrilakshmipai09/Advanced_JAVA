package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdatePatientServlet")
public class UpdatePatientServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("patientID"));
            String name = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String admissionDate = request.getParameter("admissionDate");
            String ailment = request.getParameter("ailment");
            String doctor = request.getParameter("assignedDoctor");

            Patient patient = new Patient();
            patient.setPatientID(id);
            patient.setPatientName(name);
            patient.setAge(age);
            patient.setGender(gender);
            patient.setAdmissionDate(admissionDate);
            patient.setAilment(ailment);
            patient.setAssignedDoctor(doctor);

            HospitalDAO dao = new HospitalDAO();
            boolean success = dao.updatePatient(patient);

            if (success) {
                response.sendRedirect("patientdisplay.jsp?status=updated");
            } else {
                response.sendRedirect("patientdisplay.jsp?status=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("patientdisplay.jsp?status=failed");
        }
    }
}