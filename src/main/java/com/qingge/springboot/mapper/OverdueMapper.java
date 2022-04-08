package com.qingge.springboot.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.entity.Overdue;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author closer
 * @since 2022-03-21
 */
public interface OverdueMapper extends BaseMapper<Overdue> {

    @Update("<script>"+
            "insert into t_overdue (user_id,record_id,overdue_time) " +
            "values " +
            "<foreach collection ='list' item='overdue' separator=',' >" +
            " ( #{overdue.userId},#{overdue.recordId},#{overdue.overdueTime} )" +
            "</foreach>"+
            "</script>")
    void batchInsert(List<Overdue> list);

    @Select({
            "<script>" ,
            "SELECT " ,
            "overdue.id, " ,
            "username, " ,
            "book.`name` bookName, " ,
            "book.img, " ,
            "record.borrow_time borrowTime, " ,
            "record.expire_time expireTime, " ,
            "CASE record.`status` " ,
            "WHEN '0' THEN '未还' " ,
            "WHEN '2' THEN '逾期' ELSE '已还' " ,
            "END AS status, " ,
            "record.renew, " ,
            "overdue.overdue_time overdueTime, " ,
            "record.return_time returnTime " ,
            "FROM " ,
            "t_overdue AS overdue " ,
            "JOIN sys_user AS suser ON overdue.user_id = suser.id " ,
            "JOIN t_record AS record ON overdue.record_id = record.id " ,
            "JOIN t_book AS book ON record.book_id = book.id " ,
            "<where> " ,
                "<if test = 'params.username != null and params.username.length != 0'> " ,
                    "and username like CONCAT('%',#{params.username},'%') " ,
                "</if> " ,
                "<if test = 'params.bookName != null and params.bookName.length != 0'> " ,
                    "and book.`name` like CONCAT('%',#{params.bookName},'%') " ,
                "</if> " ,
            "</where> " ,
            " order by record.`status` desc" ,
            "</script>"
    })
    List<Map<String, Object>> findAllPage(Page<Map<String, Object>> page, Map<String, Object> params);
}
