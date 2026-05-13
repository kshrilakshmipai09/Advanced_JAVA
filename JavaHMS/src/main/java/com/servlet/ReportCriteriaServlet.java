package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String reportType = request.getParameter("reportType");

        request.setAttribute("reportType", reportType);
        
        if ("dateRange".equals(reportType)) {
            request.setAttribute("fromDate", request.getParameter("fromDate"));
            request.setAttribute("toDate", request.getParameter("toDate"));
        } else if ("ailment".equals(reportType)) {
            request.setAttribute("ailment", request.getParameter("ailment"));
        } else if ("doctor".equals(reportType)) {
            request.setAttribute("doctor", request.getParameter("doctor"));
        }

        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
}