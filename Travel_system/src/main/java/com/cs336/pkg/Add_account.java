package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Add_account{

    public Add_account(){

    }

    public account addAccount(username,password,userType){
        String query = "INSERT INTO account (username, password, userType) VALUES ('" + username + "','" + password + "','" + userType + "')";
        try {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
	

