package com.qingge.springboot.common;

public interface Constants {

    String CODE_200 = "200"; //成功
    String CODE_401 = "401";  // 权限不足
    String CODE_400 = "400";  // 参数错误
    String CODE_500 = "500"; // 系统错误
    String CODE_600 = "600"; // 其他业务异常
    String CODE_700 = "700"; // 禁止登录

    String DICT_TYPE_ICON = "icon";

    // 借阅记录状态
    Integer RETURNED = 1;
    Integer IN_BORROWING = 0;
    Integer EXPIRED = 2;

    // 续借状态
    Integer NO_RENEW = 0;
    Integer HAVE_RENEWED = 1;
}
