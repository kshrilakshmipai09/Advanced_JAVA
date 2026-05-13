package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DisplayPatientsServlet")
public class DisplayPatientServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HospitalDAO dao = new HospitalDAO();
        List<Patient> patients = dao.getAllPatients();

        request.setAttribute("patients", patients);
        RequestDispatcher rd = request.getRequestDispatcher("patientdisplay.jsp");
        rd.forward(request, response);
    }
}