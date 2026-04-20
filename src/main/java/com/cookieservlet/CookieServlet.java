/*   
   8b.Build a servlet program to  create a cookie to get your name through text box and 
      press submit button( through HTML)  to display the message by greeting Welcome back
      your name ! , you have visited this page n times ( n = number of your visit )along 
      with the list of cookies and its setvalues and demonstrate the expiry of cookie also. 
 */

package com.cookieservlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/CookieServlet")
public class CookieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String userName = request.getParameter("userName");

        // Create cookies if user enters name
        if (userName != null && !userName.isEmpty()) {

            // Name cookie
            Cookie nameCookie = new Cookie("user", userName);
            nameCookie.setMaxAge(60); // expires in 60 seconds

            // Visit count cookie
            Cookie countCookie = new Cookie("count", "1");
            countCookie.setMaxAge(60);

            response.addCookie(nameCookie);
            response.addCookie(countCookie);
        }

        // Read cookies
        Cookie[] cookies = request.getCookies();

        String name = null;
        int count = 0;

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("user")) {
                    name = c.getValue();
                }
                if (c.getName().equals("count")) {
                    count = Integer.parseInt(c.getValue());
                    count++;

                    // update count cookie
                    Cookie updatedCount = new Cookie("count", String.valueOf(count));
                    updatedCount.setMaxAge(60);
                    response.addCookie(updatedCount);
                }
            }
        }

        // HTML Response
        out.println("<html><head><title>Cookie Demo</title></head><body>");

        if (name != null) {
            out.println("<h2 style='color:blue;'>Welcome back " + name + "!</h2>");
            out.println("<h3>You have visited this page " + count + " times.</h3>");
        } else {
            out.println("<h2 style='color:red;'>Enter your name</h2>");
        }

        // Form
        out.println("<form action='CookieServlet' method='get'>");
        out.println("Name: <input type='text' name='userName'>");
        out.println("<input type='submit' value='Submit'>");
        out.println("</form>");

        // Display all cookies
        out.println("<h3>List of Cookies:</h3>");

        if (cookies != null) {
            for (Cookie c : cookies) {
                out.println("Name: " + c.getName() + " | Value: " + c.getValue() + "<br>");
            }
        } else {
            out.println("No cookies found");
        }

       

        out.println("</body></html>");
    }
}
