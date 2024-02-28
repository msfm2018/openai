const express = require('express');
const OpenAI = require('openai');
// 创建服务器
const app = express();
const  openai = new OpenAI({
    apiKey: 'sk-xxxx',
    // dangerouslyAllowBrowser: true 
  });  
// /home的get请求处理
app.get("/data",async (req, res) => {
try {
   const key = req.query.key;
   console.log(key);
    const completion = await openai.chat.completions.create({
        messages: [{ role: 'user', content: key }],
        model: 'gpt-3.5-turbo',
      });
    let data=completion.choices;
    console.log(data);
    data.forEach((obj) => {
      // console.log(obj);
        // 获取对象中的索引
        // const index = obj.index;
        // 获取消息对象
        const message = obj.message;
        // 获取角色和内容
        // const role = message.role;
        const content = message.content;
        res.writeHead(200, {'Content-Type': 'text/plain; charset=utf-8'});
        res.end(content);
        // 获取完成原因
        // const finishReason = obj.finish_reason;
        // history.value.push({ a: input.value, b: content })
        // input.value = ''
        // 打印解析结果
        // console.log(`Index: ${index}`);
        // console.log(`Role: ${role}`);
        // console.log(`Content: ${content}`);
        // console.log(`Finish Reason: ${finishReason}`);
    }); 
} catch (error) {
    res.end("Hello Home");
}



//   res.end("Hello Home");
});
 
// /login的post请求处理
app.post("/login", (req, res) => {
  res.end("Hello Login");
});
 
// 开启监听
app.listen(3000, () => {
  console.log("服务器启动成功~");
})