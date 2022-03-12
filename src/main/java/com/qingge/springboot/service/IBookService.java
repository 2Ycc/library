package com.qingge.springboot.service;

import com.qingge.springboot.entity.Book;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author closer
 * @since 2022-03-12
 */
public interface IBookService extends IService<Book> {

    Book borrowBook(Book book);
}
