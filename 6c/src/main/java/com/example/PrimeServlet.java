/*
   6c.Build a servlet program to check the given number is prime number or not 
      using HTML with step by step procedure.
*/

package com.example;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/prime")
public class PrimeServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

response.setContentType("text/html");
PrintWriter out = response.getWriter();

try {
int number = Integer.parseInt(request.getParameter("number"));

if (number < 0) {
response.sendError(HttpServletResponse.SC_BAD_REQUEST,
"Number cannot be negative!");
return;
}

boolean isPrime = true;

if (number == 0 || number == 1) {
isPrime = false;
} else {
for (int i = 2; i <= number / 2; i++) {
if (number % i == 0) {
isPrime = false;
break;
}
}
}

out.println("<html><body>");
out.println("<h2>Prime Number Result</h2>");
out.println("<p>Number: " + number + "</p>");

if (isPrime)
out.println("<p style='color:green;'>It is a Prime Number</p>");
else
out.println("<p style='color:red;'>It is Not a Prime Number</p>");

out.println("<a href='index.html'>Check Another Number</a>");
out.println("</body></html>");

} catch (NumberFormatException e) {
response.sendError(HttpServletResponse.SC_BAD_REQUEST,
"Invalid number entered!");
}
}

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
response.sendRedirect("index.html");
}
}
