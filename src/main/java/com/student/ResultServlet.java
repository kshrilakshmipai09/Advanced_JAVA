/*
   10.b Build an Application to get Rollno, Studentname, Sub1, Sub2, Sub3, Sub4 and Sub5 
        through JSP called index.jsp with client sided validation and submit to the servlet 
        called ResultServlet and process all the fields with server sided validation and 
        display all the data along with result ( Pass if all subjects greater than 40%) and 
        Average marks through result.jsp with a link to move to the client side
 */
package com.student;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rollno = request.getParameter("rollno");
        String name = request.getParameter("name");
        String[] marksStr = request.getParameterValues("sub");

        String message = "";
        int total = 0;
        boolean isValid = true;
        int[] marks = new int[5];

        // Server-side validation
        if (rollno == null || rollno.isEmpty() || name == null || name.isEmpty()) {
            message = "Roll No and Name are required!";
            isValid = false;
        }

        if (marksStr == null || marksStr.length != 5) {
            message = "All subject marks are required!";
            isValid = false;
        }

        if (isValid) {
            for (int i = 0; i < 5; i++) {
                try {
                    marks[i] = Integer.parseInt(marksStr[i]);

                    if (marks[i] < 0 || marks[i] > 100) {
                        message = "Marks must be between 0 and 100!";
                        isValid = false;
                        break;
                    }

                    total += marks[i];

                } catch (NumberFormatException e) {
                    message = "Invalid number format!";
                    isValid = false;
                    break;
                }
            }
        }

        double average = total / 5.0;
        String result = "Pass";

        // Check pass condition
        for (int m : marks) {
            if (m < 40) {
                result = "Fail";
                break;
            }
        }

        // Set attributes
        request.setAttribute("rollno", rollno);
        request.setAttribute("name", name);
        request.setAttribute("marks", marks);
        request.setAttribute("average", average);
        request.setAttribute("result", result);
        request.setAttribute("message", message);

        RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
        rd.forward(request, response);
    }
}