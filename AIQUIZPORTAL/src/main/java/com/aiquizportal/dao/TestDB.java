package com.aiquizportal.dao;

import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        try {
            Connection conn = DBUtil.getConnection();
            if (conn != null) {
                System.out.println("✅ Database Connected Successfully!");
                conn.close();
            } else {
                System.out.println("❌ Connection Failed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
