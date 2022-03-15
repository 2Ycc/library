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

      @ApiModelProperty("用户ID")
        private Integer userId;

      @ApiModelProperty("图书ID")
        private Integer bookId;

      @ApiModelProperty("借书时间")
      private LocalDate borrowTime;

      @ApiModelProperty("到期时间")
      private LocalDate expireTime;

      @ApiModelProperty("是否已归还")
      private Boolean ifReturn;

}
