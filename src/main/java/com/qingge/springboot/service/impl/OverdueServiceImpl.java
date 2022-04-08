package com.qingge.springboot.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.qingge.springboot.common.Result;
import com.qingge.springboot.entity.Overdue;
import com.qingge.springboot.entity.User;
import com.qingge.springboot.mapper.OverdueMapper;
import com.qingge.springboot.service.IOverdueService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qingge.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author closer
 * @since 2022-03-21
 */
@Service
public class OverdueServiceImpl extends ServiceImpl<OverdueMapper, Overdue> implements IOverdueService {

    @Resource
    OverdueMapper overdueMapper;

    @Override
    public Result findAll(Map<String, Object> params) {
        int pageNum = (int) params.get("pageNum");
        int pageSize = (int) params.get("pageSize");

        Map<String, Object> param = new HashMap<>();
        param.put("bookName", params.remove("bookName"));
        param.put("username", params.remove("username"));

        Page<Map<String, Object>> page = new Page<>(pageNum,pageSize);
        User currentUser = TokenUtils.getCurrentUser();
        assert currentUser != null;
//        if (!Objects.equals(currentUser.getRole(), "ROLE_ADMIN") || !Objects.equals(currentUser.getRole(), "ROLE_BOOK_MANAGER")) {
//            return new Result("400","无权限查看所有违约记录",null);
//        }
        try {
            List<Map<String, Object>> records = overdueMapper.findAllPage(page,param);
            page.setRecords(records);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result("400","查询失败",null);
        }
        return new Result("200","查询成功",page);
    }
}
