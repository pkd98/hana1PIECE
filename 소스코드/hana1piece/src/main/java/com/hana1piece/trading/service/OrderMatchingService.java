package com.hana1piece.trading.service;

import com.hana1piece.trading.model.vo.StoOrdersVO;

public interface OrderMatchingService {

    /**
     *  주문 유형 확인
     * @param order
     */
    void processOrder(StoOrdersVO order);


}
