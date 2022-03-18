package com.qingge.springboot.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qingge.springboot.common.Result;

import com.qingge.springboot.service.IRecordService;
import com.qingge.springboot.entity.Record;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author closer
 * @since 2022-03-15
 */
@RestController
@RequestMapping("/record")
public class RecordController {

    @Resource
    private IRecordService recordService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Record record) {
        recordService.saveOrUpdate(record);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        recordService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        recordService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(recordService.list());
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(recordService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Map<String, Object> params) {
        return recordService.findAllPage(params);
    }

    @GetMapping("/renewBorrow/{recordId}")
    public Result renewBorrow( @PathVariable String recordId) {
        return recordService.renewBorrow(recordId);
    }


}

