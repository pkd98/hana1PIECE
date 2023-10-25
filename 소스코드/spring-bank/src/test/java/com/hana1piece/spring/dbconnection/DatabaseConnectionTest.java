package com.hana1piece.spring.dbconnection;

import com.hana1piece.AutoAppConfig;
import com.hana1piece.bank.service.BankService;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

@MybatisTest
@Import(AutoAppConfig.class)
public class DatabaseConnectionTest {

    @Autowired
    private BankService bankService;

    @Test
    public void testConnection() {
    }
}
