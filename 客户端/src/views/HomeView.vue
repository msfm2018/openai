<template>
  <div id="box">
    <div class="reply-container">
      <div class="container">
        <div class="reply-history">
          <div v-for="(message, index) in history" :key="index" class="reply-box">
            <p class="message-text">{{ message.a }}</p>
            <p class="meta-text">{{ message.b }}</p>
          </div>
        </div>
      </div>
    </div>
    <div class="input-container">
      <div class="input-box">
        <input type="text" v-model="input" placeholder="请输入消息" @keyup.enter="submitOnEnter"  :disabled="disabled">
        <span>&nbsp;</span> 
        <span v-if="loading">&nbsp; 正在等待答案...</span> <!-- Show loading message -->
        <button @click="submit"  :disabled="disabled">发送</button>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref,onMounted } from 'vue'
import OpenAI from 'openai';
const disabled = ref(false)
const loading = ref(false); 
const  openai = new OpenAI({
  apiKey: 'sk-xxxx',
  dangerouslyAllowBrowser: true 
}); 
const history = ref([{a: '这是回复的信息', b: ''}])
const input = ref('')
const submitOnEnter = () => {
  if (input.value.trim() !== '' && !disabled.value) {
    question(input.value)
  }
}
const submit = () => {
  if (input.value.trim() !== '' && !disabled.value) {
    question(input.value)
  }
}

 const   question=async (ask)=> {
  disabled.value = true;
  loading.value = true;
  const completion = await openai.chat.completions.create({
    messages: [{ role: 'user', content: ask }],
    model: 'gpt-3.5-turbo',
  });
let data=completion.choices;
data.forEach((obj) => {
    // 获取对象中的索引
    // const index = obj.index;
    // 获取消息对象
    const message = obj.message;
    // 获取角色和内容
    // const role = message.role;
    const content = message.content;
    // 获取完成原因
    // const finishReason = obj.finish_reason;
    history.value.push({ a: input.value, b: content })
    input.value = ''
    // 打印解析结果
    // console.log(`Index: ${index}`);
    // console.log(`Role: ${role}`);
    // console.log(`Content: ${content}`);
    // console.log(`Finish Reason: ${finishReason}`);
});
  // console.log(completion.choices);
  disabled.value = false;
  loading.value = false;
}
onMounted(() => {

});
</script>

<style scoped>
*{
  margin: 0;
  padding: 0;
 
}
#box {
  margin: 16px;
  display: flex;
  flex-direction: column;
  height: 90vh;
}

.reply-container {
  flex: 90%;
  overflow-y: auto;
}

.input-container {
  flex: 1;
}

.container {
  width: 100%;
  height: 100%;
}

.reply-history {
  height: 100%;
  overflow-y: auto;
}

.reply-box {
  border: 1px solid #ccc;
  padding: 10px;
  margin-bottom: 10px;
}

.message-text {
  margin: 0;
  font-size: 16px;
  color: #333;
}

.meta-text {
  margin: 0;
  font-size: 12px;
  color: #888;
}

.input-box {
  width: 100%;
  display: flex;
  align-items: center;
}

.input-box input[type="text"] {
  flex: 1;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 14px;
}

.input-box button {
  padding: 8px 16px;
  border: none;
  background-color: #007bff;
  color: #fff;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.input-box button:hover {
  background-color: #0056b3;
}
</style>
