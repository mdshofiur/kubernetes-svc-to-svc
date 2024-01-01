import express from 'express';
import { getUsersController } from './user.controller';


 const router = express.Router();

router.get('/users', getUsersController);

export default router;