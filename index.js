/**
 * 小肥牛扫码点餐系统的API子系统
 */
const PORT=8090;
const express=require('express');
const categoryRouter=require('./routes/admin/category');
const adminRouter=require('./routes/admin/admin');
const cors=require('cors');
const bodyParser=require('body-parser');
//启动主服务器
var app=express();
app.listen(PORT,()=>{
    console.log('Server Listening'+PORT+'  ...');
})
//使用中间件
app.use(cors({
    origin:['http://127.0.0.1:5500','http://localhost:5500'],cresentials:true
}))
app.use(bodyParser.json());  //把json格式的请求主体数据解析出来放入req.body属性
//挂载路由器
app.use('/admin/category',categoryRouter)
app.use('/admin',adminRouter)
