package com.qingge.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qingge.springboot.entity.Book;
import com.qingge.springboot.mapper.BookMapper;
import com.qingge.springboot.service.IBookService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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

    @Resource
    BookMapper bookMapper;

    @Override
    public Book borrowBook(Integer bookId, Integer userId) {
//        BookMapper baseMapper = this.baseMapper;
//        QueryWrapper<Book> wrapper = new QueryWrapper<>();
//        wrapper.eq("id",book.getId());
//        Book book1 = baseMapper.insert(wrapper);

        return null;
    }
}
