/**
 * 小肥牛扫码点餐系统的API子系统
 */
const express=require('express');
const cors=require('cors');
const PORT=8090;
const bodyParser=require('body-parser');
//加载路由器模块
const categoryRouter=require('./routes/admin/category');
const adminRouter=require('./routes/admin/admin');
const dishRouter=require('./routes/admin/dish');
const settingsRouter=require('./routes/admin/settings');
const tableRouter=require('./routes/admin/table');
//启动主服务器
var app=express();
app.listen(PORT,()=>{
    console.log('Server Listening'+PORT+'  ...');
})
//使用中间件
app.use(cors({
    origin:['http://127.0.0.1:5500','http://127.0.0.1:8091','http://localhost:5500'],cresentials:true
}))
app.use(bodyParser.json());  //把json格式的请求主体数据解析出来放入req.body属性
//挂载路由器
app.use('/admin/category',categoryRouter);
app.use('/admin',adminRouter);
app.use('/admin/dish',dishRouter);
app.use('/admin/settings',settingsRouter);
app.use('/admin/table',tableRouter);
