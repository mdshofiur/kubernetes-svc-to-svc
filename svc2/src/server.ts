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
   console.log('Service-1');
   res.json({ hostName, headers });
});

app.post('/api/hello', (req: Request, res: Response) => {
   const body = req.body;
   let result = Number(body.a) + Number(body.b);
   console.log('service-2 result', result);
   console.log('service-2 body', body);
   res.status(200).json({ success: true, response: body });
});

app.post('/api/svc', async (req: Request, res: Response) => {
   const body = req.body;

   try {
      const response = await axios.post(
         'http://backend-svc1-svc.default.svc.cluster.local/api/hello',
         body,
      );
      console.log('response from service-2', response.data);
      res.status(200).json({ success: true, response: response.data });
   } catch (error: any) {
      console.error('Error sending POST request:', error.message);
      res.status(500).json({ success: false, error: error.message });
   }
});

app.listen(port, () => {
   console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
