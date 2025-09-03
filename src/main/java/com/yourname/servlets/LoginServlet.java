package com.yourname.servlets;

import com.yourname.utils.DBUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    //debugging print statements
    System.out.println("Username received: (" + username + ")");
    System.out.println("Password received: (" + password + ")");
    
    // Trim to remove leading/trailing whitespace
    if (username != null) username = username.trim();
    if (password != null) password = password.trim();
    

    try (Connection conn = DBUtil.getConnection()) {
      System.out.println("Attempting login for user: " + username);

      String sql = "SELECT password_hash FROM users WHERE username = ?";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setString(1, username);
      ResultSet rs = ps.executeQuery();

      if (rs.next()) {
        String storedHash = rs.getString("password_hash");
        System.out.println("Stored hash: " + storedHash);
        System.out.println("Password provided: " + password);

        if (BCrypt.checkpw(password, storedHash)) {
          System.out.println("Password verification successful");
          HttpSession session = request.getSession();
          session.setAttribute("username", username);
          response.sendRedirect("index.jsp");
          return;
        }
        System.out.println("Password verification failed");
      } else {
        System.out.println("User not found");
      }
      request.setAttribute("errorMessage", "Invalid username or password");
      request.getRequestDispatcher("dashBoard.jsp").forward(request, response);
    } catch (Exception e) {
      e.printStackTrace();
      throw new ServletException("Database error during login", e);
    }
  }
}
