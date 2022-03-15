package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.Version;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 *
 * </p>
 *
 * @author closer
 * @since 2022-03-12
 */
@Getter
@Setter
  @TableName("t_book")
@ApiModel(value = "Book对象", description = "")
public class Book implements Serializable {

    private static final long serialVersionUID = 1L;

      @ApiModelProperty("图书ID")
        @TableId(value = "id", type = IdType.AUTO)
      private Integer id;

      @ApiModelProperty("书名")
      private String name;

      @ApiModelProperty("ISBN码")
      private String isbn;

      @ApiModelProperty("作者")
      private String author;

      @ApiModelProperty("出版社")
      private String publisher;

      @ApiModelProperty("出版时间")
      private LocalDate publishTime;

      @ApiModelProperty("上架时间")
      private LocalDateTime createTime;

      @ApiModelProperty("馆藏数量")
      private Integer nums;

      @ApiModelProperty("图书状态：1-上架 0-下架")
      private Boolean status;

      @ApiModelProperty("图书封面")
      private String img;

      @JsonIgnore
      @Version
      private Integer version;

}
