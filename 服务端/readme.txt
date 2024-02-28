安装 node 
安装 20.11.1lts
npm init -y 
npm install openai
npm install express
npm install nodemon -D


npx nodemon index.js



yarn add esbuild 

打包
esbuild index.js --bundle --minify --outfile=dist.js --platform=node

执行
npx nodemon index.js