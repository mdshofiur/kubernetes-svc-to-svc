// import fs from 'fs';
// import path from 'path';
import axios from 'axios';

// const userFilePath = path.join(__dirname, '../fake-data/users.json');

export const getUsers = async () => {
   try {
      // const rawData = await fs.promises.readFile(userFilePath, 'utf-8');
      // return JSON.parse(rawData);
      const response = await axios.get(
         'https://jsonplaceholder.typicode.com/users',
      );
      return response.data;
   } catch (error) {
      console.error('Error reading user data:', error);
      return [];
   }
};
