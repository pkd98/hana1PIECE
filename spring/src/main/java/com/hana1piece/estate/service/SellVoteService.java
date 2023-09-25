package com.hana1piece.estate.service;

import com.hana1piece.estate.model.dto.RequestSellVoteDTO;
import com.hana1piece.estate.model.vo.SellVoteVO;

public interface SellVoteService {

    void voting(SellVoteVO sellVoteVO);

}
