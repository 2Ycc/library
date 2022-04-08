<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="searchForm.name"></el-input>
      <el-select style="width: 200px" v-model="searchForm.status" class="ml-5" placeholder="请选择借阅状态">
        <el-option label="借阅中" value="0"></el-option>
        <el-option label="已还" value="1"></el-option>
        <el-option label="逾期" value="2"></el-option>
      </el-select>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量归还这些图书吗？"
          @confirm="returnBatch"
      >
        <el-button type="danger" slot="reference">批量归还 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>

    </div>
    <el-table :data="tableData" border stripe
              :header-cell-class-name="'headerBg'"
              style="font-size: 14px;"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column type="index" label="序号" width="80"></el-table-column>
      <el-table-column prop="bookName" label="书名">
        <template slot-scope="scope">
          <span style="font-size: 15px;">《{{ scope.row.bookName }}》</span>
        </template>
      </el-table-column>
      <el-table-column prop="img" label="封面">
        <template v-slot="scope">
          <el-image :src="scope.row.img" :preview-src-list="toImgArray(scope.row.img)" alt="书籍封面" width="50" height="50"/>
        </template>
      </el-table-column>
      <el-table-column prop="isbn" label="ISBN码"></el-table-column>
      <el-table-column prop="author" label="作者"></el-table-column>
      <el-table-column prop="publisher" label="出版社"></el-table-column>
      <el-table-column prop="borrowTime" width="120" label="借阅时间"></el-table-column>
      <el-table-column prop="expireTime" label="到期时间"></el-table-column>
      <el-table-column prop="status" label="借阅状态" align="center">
        <template v-slot="scope">
          <el-tag type="success" size="large" v-if="scope.row.status === '未还'">借阅中</el-tag>
          <el-tag type="danger" size="large" v-if="scope.row.status === '逾期'">逾期</el-tag>
          <el-tag type="info" size="large" v-if="scope.row.status === '已还'">已还</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="lastDay" label="剩余天数" align="center">
          <template v-slot="scope">
            <span v-if="scope.row.status === '已还'">0</span>
            <span v-else>{{ scope.row.lastDay }}</span>
          </template>
      </el-table-column>
      <el-table-column label="操作" width="250" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="renewBook(scope.row)">续借 <i class="el-icon-info"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="red"
              title="您确定归还吗？"
              @confirm="returnBook(scope.row.recordId)"
          >
            <el-button type="danger" slot="reference">还书 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>

<!--    <el-dialog title="图书信息" :visible.sync="dialogFormVisible" width="30%" destroy-on-close>-->
<!--      <el-form label-width="80px" size="small" :rules="rules" :model="form" ref="form">-->
<!--        <el-form-item label="书名" prop="name">-->
<!--          <el-input v-model.trim="form.name"-->
<!--                    autocomplete="off"-->
<!--                    maxlength="30"-->
<!--                    show-word-limit>-->
<!--          </el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="封面" prop="img">-->
<!--            <img :src="form.img" class="avatar">-->
<!--            <i class="el-icon-plus avatar-uploader-icon"></i>-->
<!--        </el-form-item>-->

<!--        <el-form-item label="ISBN码" prop="isbn">-->
<!--          <el-input v-model.trim="form.isbn"-->
<!--                    autocomplete="off"-->
<!--                    maxlength="13"-->
<!--                    show-word-limit>-->
<!--          </el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="作者" prop="author">-->
<!--          <el-input v-model.trim="form.author" autocomplete="off" required="required"></el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="出版社" prop="publisher">-->
<!--          <el-input v-model.trim="form.publisher" autocomplete="off"></el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="出版时间" style="width: 100%">-->
<!--          <el-date-picker-->
<!--              v-model="form.publishTime"-->
<!--              type="date"-->
<!--              placeholder="选择日期"-->
<!--              format="yyyy 年 MM 月 dd 日"-->
<!--              value-format="yyyy-MM-dd">-->
<!--          </el-date-picker>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="馆藏数量">-->
<!--          <el-input-number v-model="form.nums" :min="0" :max="9999" label="馆藏数量"></el-input-number>-->
<!--        </el-form-item>-->
<!--      </el-form>-->
<!--      <div slot="footer" class="dialog-footer">-->
<!--        <el-button @click="closePanel">取 消</el-button>-->
<!--        <el-button type="primary" @click="save">确 定</el-button>-->
<!--      </div>-->
<!--    </el-dialog>-->

  </div>
</template>

<script>
export default {
  name: "Record",
  data() {
    return {
      form: {
        name: '',
        isbn: '',
        author: '',
        status: '',
        img: '',
        publisher: '',
        publishTime: '',
        nums: '',
      },
      tableData: [],
      //查询用
      searchForm: {
        name: '',
        status: '',
      },
      multipleSelection: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dialogFormVisible: false,
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    toImgArray(img) {
      let arr = []
      arr.push(img)
      return arr
    },
    //续借图书
    renewBook(row) {
      let recordId = row.recordId
      let bookName = row.bookName
      this.$confirm('仅能续借一个月，确认续借《' + bookName +'》吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'success'
      }).then(() => {
        this.request.get('/record/renewBorrow/' + recordId).then(res => {
          if (res.code === '200') {
            this.$message.success("续借成功")
            this.load()
          } else {
            this.$message.error(res.msg)
            this.load()
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消续借'
        });
      });
    },
    load() {
      let url = '/record/page';
      this.request.get(url, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          bookName: this.searchForm.name,
          status: this.searchForm.status,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    clearForm() {
      this.form = {
        name: '',
        isbn: '',
        author: '',
        status: '',
        img: '',
        publisher: '',
        publishTime: '',
        nums: 0,
      }
    },
    returnBook(recordId) {
      this.request.put("/book/returnBook/" + recordId).then(res => {
        if (res.code === '200') {
          this.$message.success("还书成功")
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleSelectionChange(val) {
      // console.log(val)
      this.multipleSelection = val
    },
    //批量归还
    returnBatch() {
      let ids = []  // [{}, {}, {}] => [1,2,3]
      let rows = this.multipleSelection
      if(rows.length === 0) {
        this.$message.error('请选择要归还的书籍！')
        return;
      }
      for (let row of rows) {
        if (row.status === '已还') {
          this.$message.error('不能归还已经归还的书籍！')
          return;
        } else {
          ids.push(row.recordId)
        }
      }
      console.log(ids)
      this.request.post("/book/returnBook/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success(res.msg)
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    closePanel() {
      this.dialogFormVisible = false
    },
    reset() {
      this.searchForm.name = ""
      this.searchForm.status = ""
      this.load()
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.load()
    }
  }
}
</script>

<style scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.el-table .warning-row {
  background: #ebd2d2;
}

.el-table .success-row {
  background: #568043;
}
</style>
