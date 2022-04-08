package com.qingge.springboot.service;

import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Overdue;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author closer
 * @since 2022-03-21
 */
public interface IOverdueService extends IService<Overdue> {

    Result findAll(Map<String, Object> params);
}
