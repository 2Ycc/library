package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;

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
    private String id;

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
}
