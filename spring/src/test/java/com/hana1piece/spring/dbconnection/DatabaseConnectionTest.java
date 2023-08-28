package com.hana1piece.spring.dbconnection;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;

@SpringBootTest
public class DatabaseConnectionTest {

    @Autowired
    private DataSource dataSource;

    @Test
    public void testConnection() {

        try {
            Connection con = dataSource.getConnection();
            System.out.println(con.getMetaData());
            System.out.println(con.getMetaData().getDriverName());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
