package com.qingge.springboot.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Record;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
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
 * @since 2022-03-15
 */
public interface RecordMapper extends BaseMapper<Record> {

    @Select("select \n" +
            "record.id recordId,\n" +
            "record.user_id userId,\n" +
            "record.book_id bookId,\n" +
            "record.renew renew,\n" +
            "record.borrow_time borrowTime,\n" +
            "record.expire_time expireTime,\n" +
            "record.create_time createTime,\n" +
            "IF(DATEDIFF(record.expire_time,CURRENT_TIMESTAMP) < 0,0,DATEDIFF(record.expire_time,CURRENT_TIMESTAMP)) lastDay,\n" +
            "\n" +
            "CASE record.status\n" +
            "\tWHEN '0' THEN\n" +
            "\t\t'未还'\n" +
            "WHEN '2' THEN\n" +
            "\t\t'逾期'\n" +
            "\tELSE\n" +
            "\t\t'已还'\n" +
            "END as status,\n" +
            "book.`name` bookName,\n" +
            "book.isbn isbn,\n" +
            "book.author author,\n" +
            "book.publisher publisher,\n" +
            "book.publish_time publishTime,\n" +
            "book.img img\n" +
            "from t_book as book left join t_record as record\n" +
            "on book.id = record.book_id\n" +
            "where record.user_id = #{userId} " +
            "and book.`name` like concat('%',#{bookName},'%')")
    List<Map<String,Object>> findAllPage(@Param("page") Page<Map<String,Object>> page, @Param("userId") Integer userId, @Param("bookName") String bookName);

    @Update("<script>"+
                "update t_record \n" +
                "set `status` = '2'\n" +
                "where id in " +
                "<foreach collection ='records' item='record' open='(' separator=',' close=')' >" +
                " #{record.id} " +
                "</foreach>"+
            "</script>")
    int changeMode(@Param("records") List<Record> records);

    /**
     * 查询已经逾期并且未归还的书籍
     * @author closer
     * @date
     */
    @Select("select * from t_record where DATEDIFF(expire_time,CURRENT_TIMESTAMP) < 0 and `status` = 0")
    List<Record> getAllShouldChangedRecords();
}
