import { z } from 'zod';
import { CommunicationStatus } from '../types';

export const prepareOutreachSchema = z.object({
  vehicleId: z.string().uuid('Invalid vehicle ID'),
  requirementIds: z.array(z.string().uuid('Invalid requirement ID')).min(1, 'Select at least one requirement'),
  customNote: z.string().optional().nullable(),
});

export const updateCommunicationStatusSchema = z.object({
  status: z.nativeEnum(CommunicationStatus),
  notes: z.string().optional().nullable(),
});
