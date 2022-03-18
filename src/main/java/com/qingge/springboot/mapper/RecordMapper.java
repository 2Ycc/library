package com.qingge.springboot.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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

    @Select({
            "<script>" ,
            "select " ,
            "record.id recordId," ,
            "record.user_id userId," ,
            "record.book_id bookId," ,
            "record.renew renew," ,
            "record.borrow_time borrowTime," ,
            "record.expire_time expireTime," ,
            "record.create_time createTime," ,
            "IF(DATEDIFF(record.expire_time,CURRENT_TIMESTAMP) &lt; 0,0,DATEDIFF(record.expire_time,CURRENT_TIMESTAMP)) lastDay," ,
            "CASE record.status" ,
            "WHEN '0' THEN '未还'" ,
            "WHEN '2' THEN '逾期'" ,
            "ELSE '已还'" ,
            "END as status," ,
            "book.`name` bookName," ,
            "book.isbn isbn," ,
            "book.author author," ,
            "book.publisher publisher," ,
            "book.publish_time publishTime," ,
            "book.img img" ,
            "from t_book as book left join t_record as record" ,
            "on book.id = record.book_id" ,
            "where record.user_id = #{params.userId} " ,
            "and book.`name` like concat('%',#{params.bookName},'%') " ,
            "<if test='params.status != null and params.status.length != 0'>" ,
            "and record.status = #{params.status}" ,
            "</if>" ,
            "order by record.status desc",
            "</script>"
    })
    List<Map<String,Object>> findAllPage(@Param("page") Page<Map<String,Object>> page, @Param("params") Map<String,Object> params);

    @Update("<script>"+
                "update t_record  " +
                "set `status` = '2' " +
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
