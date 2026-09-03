import { Router } from 'express';
import { AuthController } from '../controllers/auth.controller';
import { requireAuth, requireRoles } from '../middleware/auth';
import { Role } from '../types';

const router = Router();

router.post('/login', AuthController.login);
router.get('/me', requireAuth, AuthController.getMe);
router.get('/users', requireAuth, AuthController.listUsers);
router.post('/users', requireAuth, requireRoles(Role.ADMIN), AuthController.createUser);
router.put('/users/:id', requireAuth, requireRoles(Role.ADMIN), AuthController.updateUser);

export default router;
