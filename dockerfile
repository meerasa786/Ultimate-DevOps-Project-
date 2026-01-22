FROM node:18-alpine

WORKDIR /tools

# copy package files
COPY package*.json ./

# install dev tools
RUN npm install

# copy repo
COPY . .

# default command
CMD ["npm", "list"]
