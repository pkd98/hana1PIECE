package com.hana1piece;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.jdbc.datasource.DataSourceUtils;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@Configuration
@EnableTransactionManagement
public class DatabaseConfig {
/*
    private final DataSource dataSource;

    @Autowired
    public DatabaseConfig(DataSource dataSource) {
        this.dataSource = dataSource;
        setTransactionIsolationLevel();
    }

    private void setTransactionIsolationLevel() {
        Connection connection = DataSourceUtils.getConnection(dataSource);
        try {
            Statement statement = connection.createStatement();
            statement.execute("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DataSourceUtils.releaseConnection(connection, dataSource);
        }
    }
    */
}
