package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

/**
 * <p>
 *
 * </p>
 *
 * @author closer
 * @since 2022-03-15
 */
@Getter
@Setter
@TableName("t_record")
@ApiModel(value = "Record对象", description = "")
@AllArgsConstructor
@NoArgsConstructor
public class Record implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("借阅记录ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("用户ID")
      private Integer userId;

    @ApiModelProperty("图书ID")
      private Integer bookId;

    @ApiModelProperty("借书时间")
    private LocalDate borrowTime;

    @ApiModelProperty("到期时间")
    private LocalDate expireTime;

    @ApiModelProperty("借阅记录状态：1-是 0-否 2-逾期")
    private Integer status;

    @ApiModelProperty("是否续借：0-未续借 1：已续借")
    private Integer renew;

    @ApiModelProperty("还书时间")
    private LocalDateTime returnTime;

    public Record(Integer id,Integer userId, Integer bookId, LocalDate borrowTime, LocalDate expireTime, Integer status, Integer renew) {
        this.id = id;
        this.userId = userId;
        this.bookId = bookId;
        this.borrowTime = borrowTime;
        this.expireTime = expireTime;
        this.status = status;
        this.renew = renew;
    }
    public Record(Integer userId, Integer bookId, LocalDate borrowTime, LocalDate expireTime, Integer status, Integer renew) {
        this.userId = userId;
        this.bookId = bookId;
        this.borrowTime = borrowTime;
        this.expireTime = expireTime;
        this.status = status;
        this.renew = renew;
    }
}
