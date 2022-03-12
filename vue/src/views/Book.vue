<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="name"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd" v-if="user.role === 'ROLE_ADMIN'">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量删除这些图书吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference" v-if="user.role === 'ROLE_ADMIN'">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>

    </div>
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="图书ID" width="80"></el-table-column>
      <el-table-column prop="name" label="书名"></el-table-column>
      <el-table-column prop="isbn" label="ISBN码"></el-table-column>
      <el-table-column prop="author" label="作者"></el-table-column>
      <el-table-column prop="publisher" label="出版社"></el-table-column>
      <el-table-column prop="publishTime" label="出版时间"></el-table-column>
      <el-table-column prop="createTime" label="上架时间"></el-table-column>
      <el-table-column prop="nums" label="馆藏数量"></el-table-column>
      <el-table-column label="启用">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.status === '1'" active-color="#13ce66" inactive-color="#ccc"
                     @change="changeEnable(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="280" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="borrowBook(scope.row.id)">借阅</el-button>
          <el-button type="success" @click="handleEdit(scope.row)" v-if="user.role === 'ROLE_ADMIN'">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="red"
              title="您确定删除吗？"
              @confirm="del(scope.row.id)"
          >
            <el-button type="danger" slot="reference" v-if="user.role === 'ROLE_ADMIN'">删除 <i class="el-icon-remove-outline"></i></el-button>
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

    <el-dialog title="课程信息" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="书名">
          <el-input v-model.trim="form.name"
                    autocomplete="off"
                    maxlength="30"
                    show-word-limit>
          </el-input>
        </el-form-item>
        <el-form-item label="ISBN码">
          <el-input v-model.number.trim="form.isbn"
                    autocomplete="off"
                    maxlength="13"
                    show-word-limit>
          </el-input>
        </el-form-item>
        <el-form-item label="作者">
          <el-input v-model.trim="form.author" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="出版社">
          <el-input v-model.trim="form.publisher" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="出版时间">
<!--          <el-input v-model="form.publishTime" autocomplete="off"></el-input>-->
          <el-date-picker
              v-model="form.publishTime"
              type="date"
              placeholder="选择日期"
              format="yyyy 年 MM 月 dd 日"
              value-format="yyyy-MM-dd">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="馆藏数量">
<!--          <el-input v-model="form.nums" autocomplete="off" type="number"></el-input>-->
          <el-input-number v-model="form.nums" :min="1" :max="99" label="馆藏数量"></el-input-number>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>

export default {
  name: "Book",
  data() {
    return {
      form: {
        name: '',
        isbn: '',
        author: '',
        status: '',
        publisher: '',
        publishTime: '',
        nums: 1,
      },
      tableData: [],
      name: '',
      multipleSelection: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dialogFormVisible: false,
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.load()
  },
  methods: {
    borrowBook(bookId) {
      this.request.post('/book/borrowBook/' + bookId + "/" + this.user.id).then(res => {
        if (res.code === '200') {
          this.$message.success("选课成功")
        } else {
          this.$message.success(res.msg)
        }
      })
    },
    load() {
      this.request.get("/book/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {

        this.tableData = res.data.records
        this.total = res.data.total

      })

      // this.request.get("/user/role/ROLE_TEACHER").then(res => {
      //   this.teachers = res.data
      // })
    },
    changeEnable(row) {

      console.log(row)
      row.status = -row.status
      // this.request.post("/book/update", row).then(res => {
      //   if (res.code === '200') {
      //     this.$message.success("操作成功")
      //   }
      // })
    },
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
      this.form.nums = 1
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
    },
    del(id) {
      this.request.delete("/book/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
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
    save() {
      console.log(this.form)
      this.request.post("/book", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
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
    },
    download(url) {
      window.open(url)
    },
  }
}
</script>

<style scoped>

</style>
