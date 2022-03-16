package com.qingge.springboot.service.impl;

import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Book;
import com.qingge.springboot.entity.Record;
import com.qingge.springboot.mapper.BookMapper;
import com.qingge.springboot.mapper.RecordMapper;
import com.qingge.springboot.service.IBookService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDate;

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

    @Resource
    RecordMapper recordMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Result borrowBook(Integer bookId, Integer userId) {
        //查询是否已经借了此书
        QueryWrapper<Record> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("book_id", bookId);
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("status", 0);
        queryWrapper.getSqlSelect();
        Record records = recordMapper.selectOne(queryWrapper);
        if (!ObjectUtil.isNull(records)) {
            return Result.error("10002","您已经借过此书");
        }
        //查询存书量
        Book book = bookMapper.selectById(bookId);
        //当前库存
        int nums = book.getNums();
        if (nums > 0) {
            //封装借书记录实体类
            Record bookRecord = new Record(UUID.randomUUID().toString(),userId,bookId,LocalDate.now(),LocalDate.now().plusMonths(2L),0,0);
            try {
                int res = recordMapper.insert(bookRecord);
                if ( res > 0) {
                    //减少库存
                    book.setNums(nums - 1);
                    //更新库存
                    bookMapper.updateById(book);
                    return new Result("200","借书成功",book);
                }
                else {
                    return Result.error("10001","借书失败");
                }
            } catch (Exception e) {
                e.printStackTrace();
                return new Result("500","借书失败",e.toString());
            }
        } else {
            return new Result("10003","本书已经被借完，暂无库存！","0");
        }


    }
}
