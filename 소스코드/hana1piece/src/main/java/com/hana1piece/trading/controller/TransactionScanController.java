package com.hana1piece.trading.controller;

import com.hana1piece.manager.service.ManagerService;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TransactionScanController {
    @GetMapping("/transaction-scan")
    public String transactionScan() {
        return "/transaction-scan";
    }

}
