package com.qingge.springboot.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qingge.springboot.common.Result;

import com.qingge.springboot.service.IBookService;
import com.qingge.springboot.entity.Book;

import org.springframework.web.bind.annotation.RestController;

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

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(bookService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize) {
        QueryWrapper<Book> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(bookService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @PostMapping("/borrowBook")
    public Result borrowBook(@RequestBody Book book) {
        return Result.success(bookService.borrowBook(book));
    }

}

