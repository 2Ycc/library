package com.qingge.springboot.controller;


import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.entity.Files;
import com.qingge.springboot.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qingge.springboot.common.Result;

import com.qingge.springboot.service.IBookService;
import com.qingge.springboot.entity.Book;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author closer
 * @since 2022-03-12
 */
@RestController
@RequestMapping("/book")
public class BookController {

    @Resource
    FileMapper fileMapper;

    @Resource
    private IBookService bookService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Book book) {
        bookService.saveOrUpdate(book);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        bookService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        bookService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(bookService.list());
    }

    /**
     * 非管理员用户仅能查询状态为上架的图书
     * @author ymy
     * @date 2022/3/15 11:42
     * @param name 图书名
     * @param pageNum 页
     * @param pageSize 每页个数
     * @return com.qingge.springboot.common.Result
     */
    @GetMapping("/enableBooks")
    public Result findAllEnable(@RequestParam String name,
                                @RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<Book> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        queryWrapper.like("name", name);
        queryWrapper.eq("status", "1");
        return Result.success(bookService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(bookService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam String name,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Book> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        queryWrapper.like("name", name);
        return Result.success(bookService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @PostMapping("/borrowBook/{bookId}/{userId}")
    public Result borrowBook(@PathVariable Integer bookId, @PathVariable Integer userId) {
        return Result.success(bookService.borrowBook(bookId, userId));
    }

}

