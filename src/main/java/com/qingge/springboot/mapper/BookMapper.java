package com.qingge.springboot.mapper;

import com.qingge.springboot.entity.Book;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author closer
 * @since 2022-03-12
 */
public interface BookMapper extends BaseMapper<Book> {

}
