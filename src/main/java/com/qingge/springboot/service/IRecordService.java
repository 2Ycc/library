package com.qingge.springboot.service;

import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Record;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author closer
 * @since 2022-03-15
 */
public interface IRecordService extends IService<Record> {

    Result findAllPage(Map<String, Object> params);

    Result renewBorrow(String recordId);

    int changeModeTask();

    Result findAllPageAdmin(Map<String, Object> params);
}
