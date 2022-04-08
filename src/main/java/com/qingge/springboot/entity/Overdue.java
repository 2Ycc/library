package com.qingge.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
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
 * @since 2022-03-21
 */
@Getter
@Setter
  @TableName("t_overdue")
@ApiModel(value = "Overdue对象", description = "")
public class Overdue implements Serializable {

    private static final long serialVersionUID = 1L;

      @ApiModelProperty("违约记录ID")
      @TableId(value = "id", type = IdType.AUTO)
      private Integer id;

      @ApiModelProperty("违约用户ID")
      private Integer userId;

      @ApiModelProperty("违约借阅记录ID")
      private Integer recordId;

      @ApiModelProperty("逾期时间")
      private LocalDateTime overdueTime;


}
