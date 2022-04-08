package com.qingge.springboot.task;

import com.qingge.springboot.service.IRecordService;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.time.LocalDateTime;

/**
 * @author closer
 */
@Component
@Configuration      //1.主要用于标记配置类，兼备Component的效果。
@EnableScheduling   // 2.开启定时任务
public class SaticScheduleTask {

    @Resource
    IRecordService iRecordService;

    //3.添加定时任务
//    @Scheduled(cron = "*/30 * * * * ? ")
    @Scheduled(cron = "0 0 0/1 * * ? ")
    //或直接指定时间间隔，例如：每小时
    //@Scheduled(fixedRate=5000)
    private void configureTasks() {
        System.out.println("执行静态定时任务时间: " + LocalDateTime.now());
        //执行定时任务，将逾期的借书记录状态更改为”逾期“,并且插入记录到逾期表中
        iRecordService.changeModeTask();
    }
}
