<template>
  <div><h1>reader</h1>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="name"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">

    </div>
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" style="font-size: 14px;"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column  label="序号" width="80" type="index"></el-table-column>
      <el-table-column prop="name" label="书名">
        <template slot-scope="scope">
          <span style="font-size: 15px;">《{{ scope.row.name }}》</span>
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
      <el-table-column prop="publishTime" width="120" label="出版时间"></el-table-column>
      <el-table-column prop="createTime" label="上架时间"></el-table-column>
      <el-table-column prop="nums" width="120" label="剩余馆藏数量" align="center"></el-table-column>
      <el-table-column label="操作" width="250" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="borrowBook(scope.row)">借阅</el-button>
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
  name: "Book",
  data() {
    return {
      tableData: [],
      //查询用
      name: '',
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
    borrowBook(row) {
      if (row.nums <= 0) {
        this.$message.error('库存不足！')
        return
      }
      let bookId = row.id
      let bookName = row.name
      console.log("userId:"+this.user.id,"bookId:"+bookId)
      this.$confirm('确认借阅《' + bookName +'》吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'success'
      }).then(() => {
        this.request.post('/book/borrowBook/' + bookId + "/" + this.user.id).then(res => {
          if (res.code === '200') {
            this.$message.success("借阅成功")
            this.load()
          } else {
            this.$message.error(res.msg)
            this.load()
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消借阅'
        });
      });
    },
    load() {
      let url = '/book/enableBooks';
      if (this.user.role === 'ROLE_ADMIN') {
        url = '/book/page'
      }
      this.request.get(url, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
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
    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },
    reset() {
      this.name = ""
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
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
</style>
