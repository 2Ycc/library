package com.qingge.springboot.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Book;
import com.qingge.springboot.entity.Record;
import com.qingge.springboot.mapper.BookMapper;
import com.qingge.springboot.mapper.RecordMapper;
import com.qingge.springboot.service.IBookService;
import com.qingge.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
    public Result borrowBook(Integer bookId) {
        Integer userId = TokenUtils.getCurrentUser().getId();
        //查询是否已经借了此书
        QueryWrapper<Record> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("book_id", bookId);
        queryWrapper.eq("user_id", userId);
//        queryWrapper.eq("status", 0);
        //状态不等于1，即仅筛选未还书籍记录
        queryWrapper.ne("status", 1);
        queryWrapper.getSqlSelect();
        Record records = recordMapper.selectOne(queryWrapper);
        if (!ObjectUtil.isNull(records)) {
            return Result.error("10002","此书已经在您的借阅期内！");
        }
        //查询存书量
        Book book = bookMapper.selectById(bookId);
        //当前库存
        int nums = book.getNums();
        if (nums > 0) {
            //封装借书记录实体类
            Record bookRecord = new Record(null,userId,bookId,LocalDate.now(),LocalDate.now().plusMonths(2L),0,0);
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

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Result returnBook(Integer bookId) {
        //获取当前登录的用户id
        Integer userId = TokenUtils.getCurrentUser().getId();
        //查询是否已经借了此书
        QueryWrapper<Record> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("book_id", bookId);
        queryWrapper.eq("user_id", userId);
        //状态不等于1，即仅筛选未还书籍记录
        queryWrapper.ne("status", 1);
        queryWrapper.getSqlSelect();
        Record records = recordMapper.selectOne(queryWrapper);
        if (ObjectUtil.isNull(records)) {
            return Result.error("10007","此书不在您的借阅清单内，或已归还！");
        }
        //查询存书量与书籍信息
        Book book = bookMapper.selectById(bookId);
        //当前库存
        int nums = book.getNums();
        //更改借阅记录状态为“已归还”
        records.setStatus(1);
        //更新还书时间
        records.setReturnTime(LocalDateTime.now());
        try {
            int res = recordMapper.updateById(records);
            if ( res > 0) {
                //库存+1
                book.setNums(nums + 1);
                //更新库存
                bookMapper.updateById(book);
                return new Result("200","还书成功",book);
            }
            else {
                return Result.error("10001","还书失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Result("500","还书失败",e.toString());
        }
    }
}
