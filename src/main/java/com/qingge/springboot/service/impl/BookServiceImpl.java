package com.qingge.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qingge.springboot.entity.Book;
import com.qingge.springboot.mapper.BookMapper;
import com.qingge.springboot.service.IBookService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author closer
 * @since 2022-03-12
 */
@Service
public class BookServiceImpl extends ServiceImpl<BookMapper, Book> implements IBookService {

    @Override
    public Book borrowBook(Book book) {
//        BookMapper baseMapper = this.baseMapper;
//        QueryWrapper<Book> wrapper = new QueryWrapper<>();
//        wrapper.eq("id",book.getId());
//        Book book1 = baseMapper.selectOne(wrapper);

        return null;
    }
}
