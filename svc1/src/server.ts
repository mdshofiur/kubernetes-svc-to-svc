import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import router from './modules/user/user.route';
import os from 'os';
import axios from 'axios';

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 80;

app.use(express.json());
app.use(router);


app.get('/', (req: Request, res: Response) => {
   const headers = req.headers;
   const hostName = os.hostname();
   res.json({ hostName, headers });
});

app.post('/api/hello', (req: Request, res: Response) => {
   const body = req.body;
   console.log("🚀 service-1 body", body)
   res.json(body);
});

app.post('/api/svc', async (req: Request, res: Response) => {
   const body = req.body;
   try {
      const response = await axios.post(
         'http://backend-sv2-svc.devops.svc.cluster.local/api/hello',
         body,
      );
      console.log('response from service-1', response.data);
      res.status(200).json({ success: true, response: response.data });
   } catch (error: any) {
      console.error('Error sending POST request:', error.message);
      res.status(500).json({ success: false, error: error.message });
   }
});


app.listen(port, () => {
   console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
