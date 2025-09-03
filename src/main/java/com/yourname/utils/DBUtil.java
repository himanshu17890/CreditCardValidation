package com.yourname.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
  private static final String DB_URL = "jdbc:mysql://localhost:3306/creditcard_app?useSSL=false&serverTimezone=UTC";
  private static final String USER = "root";
  private static final String PASS = "Himanshu123@";

  public static Connection getConnection() throws Exception {
    Class.forName("com.mysql.cj.jdbc.Driver");
    return DriverManager.getConnection(DB_URL, USER, PASS);
  }
}
