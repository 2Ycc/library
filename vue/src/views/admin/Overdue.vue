<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入书名" suffix-icon="el-icon-search" v-model="searchForm.bookName"></el-input>
      <el-input style="width: 200px" placeholder="请输入用户名" suffix-icon="el-icon-search" class="ml-5" v-model="searchForm.username"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">

    </div>
    <el-table :data="tableData" border stripe
              :header-cell-class-name="'headerBg'"
              style="font-size: 14px;"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column type="index" label="序号" width="80"></el-table-column>
      <el-table-column prop="username" label="借阅者"></el-table-column>
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
      <!--      <el-table-column prop="isbn" label="ISBN码"></el-table-column>-->
      <el-table-column prop="author" label="作者"></el-table-column>
      <el-table-column prop="publisher" label="出版社"></el-table-column>
      <el-table-column prop="borrowTime" width="120" label="借阅时间"></el-table-column>
      <el-table-column prop="expireTime" label="到期时间"></el-table-column>
      <el-table-column prop="status" label="借阅状态" align="center">
        <template v-slot="scope">
          <el-tag type="success" v-if="scope.row.status === '未还'">借阅中</el-tag>
          <el-tag type="danger" v-if="scope.row.status === '逾期'">逾期</el-tag>
          <el-tag type="info" v-if="scope.row.status === '已还'">已还</el-tag>
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

  </div>
</template>

<script>
export default {
  name: "Record",
  data() {
    return {
      //查询用
      searchForm: {
        username: '',
        bookName: '',
        status: ''
      },
      tableData: [],
      multipleSelection: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
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
    recordInfo(row) {
      this.$message.success('查看借阅信息')
      let recordId = row.recordId
      let bookName = row.bookName
      // this.$confirm('仅能续借一个月，确认续借《' + bookName +'》吗？', '提示', {
      //   confirmButtonText: '确定',
      //   cancelButtonText: '取消',
      //   type: 'success'
      // }).then(() => {
      //   this.request.get('/record/renewBorrow/' + recordId).then(res => {
      //     if (res.code === '200') {
      //       this.$message.success("续借成功")
      //       this.load()
      //     } else {
      //       this.$message.error(res.msg)
      //       this.load()
      //     }
      //   })
      // }).catch(() => {
      //   this.$message({
      //     type: 'info',
      //     message: '已取消续借'
      //   });
      // });
    },
    load() {
      let url = '/overdue/findAll';
      this.request.post(url, {
        // params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          bookName: this.searchForm.bookName,
          username: this.searchForm.username,
          status: this.searchForm.status,
        // }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    returnBook(bookId) {
      this.$message.success('催还成功')
      // this.request.put("/book/returnBook/" + bookId).then(res => {
      //   if (res.code === '200') {
      //     this.$message.success("还书成功")
      //     this.load()
      //   } else {
      //     this.$message.error(res.msg)
      //   }
      // })
    },
    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },
    delBatch() {
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/book/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },
    reset() {
      this.searchForm.bookName = ""
      this.searchForm.username = ""
      this.searchForm.status = ""
      this.load()
    },
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },
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
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.el-table .warning-row {
  background: #ebd2d2;
}

.el-table .success-row {
  background: #568043;
}
</style>
