package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() {
		
		Connection conn = null;
		String DriverName = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/PMT";
		String userName = "root";
		String password = "";
		
		try {
			
			//load driver
			//loads a class dynamically (not at compile time, but when your program runs)
			Class.forName(DriverName);
			
			//open
			//It hands you a Connection object, which you’ll use for creating tables, inserting data, running queries, deleting records, etc.
			try {
				conn = DriverManager.getConnection(url,userName,password);
				System.out.print(conn);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
		
	}
	public static void main(String[] args) {
		getConnection();
	}
}
