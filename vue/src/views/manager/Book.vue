<template>
  <div><h1>manager</h1>
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
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" style="font-size: 14px;"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" v-if="user.role === 'ROLE_ADMIN'"></el-table-column>
      <el-table-column prop="id" label="图书ID" width="80" v-if="user.role === 'ROLE_ADMIN'"></el-table-column>
      <el-table-column prop="name" label="书名">
        <template slot-scope="scope">
          <span style="font-size: 15px;">《{{ scope.row.name }}》</span>
        </template>
      </el-table-column>
      <el-table-column prop="img" label="封面">
        <template v-slot="scope">
          <el-image :src="scope.row.img" :preview-src-list="toImgArray(scope.row.img)" alt="书籍封面" width="90" height="90"/>

        </template>
      </el-table-column>
      <el-table-column prop="isbn" label="ISBN码"></el-table-column>
      <el-table-column prop="author" label="作者"></el-table-column>
      <el-table-column prop="publisher" label="出版社"></el-table-column>
      <el-table-column prop="publishTime" width="120" label="出版时间"></el-table-column>
      <el-table-column prop="createTime" label="上架时间"></el-table-column>
      <el-table-column prop="nums" width="120" label="剩余馆藏数量" align="center"></el-table-column>
      <el-table-column label="启用" width="70" v-if="user.role === 'ROLE_ADMIN'">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.status" active-color="#13ce66" inactive-color="#ccc"
                     @change="changeEnable(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="250" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="borrowBook(scope.row)">借阅</el-button>
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

    <el-dialog title="图书信息" :visible.sync="dialogFormVisible" width="30%" destroy-on-close>
      <el-form label-width="80px" size="small" :rules="rules" :model="form" ref="form">
        <el-form-item label="书名" prop="name">
          <el-input v-model.trim="form.name"
                    autocomplete="off"
                    maxlength="30"
                    show-word-limit>
          </el-input>
        </el-form-item>
        <el-form-item label="封面" prop="img">
          <el-upload
              class="avatar-uploader"
              :action="'http://' + serverIp +':9090/file/upload'"
              :show-file-list="false"
              :before-upload="beforeAvatarUpload"
              :on-success="handleAvatarSuccess"
          >
            <img v-if="form.img" :src="form.img" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>

        <el-form-item label="ISBN码" prop="isbn">
          <el-input v-model.trim="form.isbn"
                    autocomplete="off"
                    maxlength="13"
                    show-word-limit>
          </el-input>
        </el-form-item>
        <el-form-item label="作者" prop="author">
          <el-input v-model.trim="form.author" autocomplete="off" required="required"></el-input>
        </el-form-item>
        <el-form-item label="出版社" prop="publisher">
          <el-input v-model.trim="form.publisher" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="出版时间" style="width: 100%">
          <el-date-picker
              v-model="form.publishTime"
              type="date"
              placeholder="选择日期"
              format="yyyy 年 MM 月 dd 日"
              value-format="yyyy-MM-dd">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="馆藏数量">
          <el-input-number v-model="form.nums" :min="0" :max="9999" label="馆藏数量"></el-input-number>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="closePanel">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import {serverIp} from "../../../public/config";
export default {
  name: "Book",
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
      serverIp: serverIp,
      tableData: [],
      //查询用
      name: '',
      multipleSelection: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dialogFormVisible: false,
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      rules: {
        name: [
          { required: true, message: '请输入活动名称', trigger: 'blur' },
          { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
        ],
        isbn: [
          { required: true, message: '请填写图书的ISBN码', trigger: 'blur' },
          { min: 13, message: '长度为13个字符', trigger: 'blur' }
        ],
        author: [
          { required: true, message: '请填写图书的作者', trigger: 'blur' }
        ],
        publisher: [
          { required: true, message: '请填写出版社', trigger: 'blur' }
        ],
        nums: [
          { required: true, message: '请填写数量', trigger: 'blur' }
        ]
      }
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
    changeEnable(row) {
      console.log(row)
      this.request.post("/book", row).then(res => {
        if (res.code === '200') {
          this.$message.success("操作成功")
        }
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
    handleAdd() {
      this.dialogFormVisible = true
      this.clearForm()
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
      this.$refs['form'].validate((valid) => {
        if (valid) {
          // alert('submit!');
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
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    closePanel() {
      this.dialogFormVisible = false
      this.resetForm('form')
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
    handleAvatarSuccess(res) {
      this.form.img = res
      console.log(this.form.img)
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
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
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
