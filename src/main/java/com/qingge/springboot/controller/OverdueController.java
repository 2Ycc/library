package com.qingge.springboot.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qingge.springboot.common.Result;

import com.qingge.springboot.service.IOverdueService;
import com.qingge.springboot.entity.Overdue;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author closer
 * @since 2022-03-21
 */
@RestController
@RequestMapping("/overdue")
public class OverdueController {

    @Resource
    private IOverdueService overdueService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Overdue overdue) {
        overdueService.saveOrUpdate(overdue);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        overdueService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        overdueService.removeByIds(ids);
        return Result.success();
    }

    @PostMapping("/findAll")
    public Result findAll(@RequestBody Map<String, Object> params) {
        return overdueService.findAll(params);
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(overdueService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Overdue> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(overdueService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

