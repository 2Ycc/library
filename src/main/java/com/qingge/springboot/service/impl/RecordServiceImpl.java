package com.qingge.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qingge.springboot.common.Constants;
import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Record;
import com.qingge.springboot.entity.User;
import com.qingge.springboot.mapper.RecordMapper;
import com.qingge.springboot.service.IRecordService;
import com.qingge.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author closer
 * @since 2022-03-15
 */
@Service
public class RecordServiceImpl extends ServiceImpl<RecordMapper, Record> implements IRecordService {

    @Resource
    RecordMapper recordMapper;

    @Override
    public Result findAllPage(Map<String, Object> params) {
        String bookName = (String) params.get("bookName");
        String status = (String) params.get("status");

        int pageNum = Integer.parseInt((String) params.get("pageNum")) ;
        int pageSize = Integer.parseInt((String) params.get("pageSize")) ;
        Page<Map<String, Object>> page = new Page<>(pageNum,pageSize);
        User currentUser = TokenUtils.getCurrentUser();
        assert currentUser != null;
        Map<String, Object> param = new HashMap<>();
        param.put("bookName", bookName);
        param.put("status", status);
        param.put("userId", currentUser.getId());
        try {
            List<Map<String, Object>> records = recordMapper.findAllPage(page,param);
            page.setRecords(records);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result("400","查询失败",null);
        }
        return new Result("200","查询成功",page);
    }

    @Override
    public Result renewBorrow(String recordId) {
        QueryWrapper<Record> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", recordId);
        Record record = recordMapper.selectOne(queryWrapper);
        LocalDate expireTime = record.getExpireTime();
        //判断如果已经续归还，则不让续借
        if ( Constants.RETURNED.equals(record.getStatus()) ) {
            return new Result("10008","本书已经归还，请重新借书！","");
        }
        //判断如果逾期31天以上，则不让续借，提醒归还
        if ( expireTime.plusDays(31).isBefore(LocalDate.now()) ) {
            return new Result("10006","逾期超过一个月，速请归还图书！","");
        }
        //判断如果已经续借过，则不让续借
        if ( Constants.HAVE_RENEWED.equals(record.getRenew()) ) {
            return new Result("10005","已经续借过一次了，不能再次续借！","");
        }
        record.setExpireTime(expireTime.plusDays(31));
        record.setRenew(1);
        record.setStatus(0);
        try {
            recordMapper.updateById(record);
            return new Result("200","续借成功！","");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result("500","续借失败！","");
        }
    }

    @Override
    public int changeModeTask() {
        List<Record> records = recordMapper.getAllShouldChangedRecords();
        if (records.isEmpty()) {
            return 0;
        } else {
            return recordMapper.changeMode(records);
        }
    }
}
