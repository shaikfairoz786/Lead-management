import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Car, Shield, User, Briefcase, MapPin, AlertCircle, ArrowRight } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { Input } from '../../components/common/Input';
import { Button } from '../../components/common/Button';

export const LoginPage: React.FC = () => {
  const { login, quickLoginAs } = useAuth();
  const navigate = useNavigate();

  const [identifier, setIdentifier] = useState('sales1@autolms.com');
  const [password, setPassword] = useState('password123');
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setIsLoading(true);
    try {
      await login(identifier, password);
      navigate('/dashboard');
    } catch (err: any) {
      setError(err.message || 'Invalid credentials');
    } finally {
      setIsLoading(false);
    }
  };

  const handleQuickLogin = async (role: 'ADMIN' | 'MANAGER' | 'SALES' | 'FIELD') => {
    setError(null);
    setIsLoading(true);
    try {
      await quickLoginAs(role);
      navigate('/dashboard');
    } catch (err: any) {
      setError(err.message || 'Login failed');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <div className="flex justify-center">
          <div className="w-12 h-12 rounded-xl bg-gradient-to-tr from-brand-700 via-brand-600 to-indigo-500 text-white flex items-center justify-center font-bold text-base shadow-md ring-2 ring-brand-500/20">
            <svg className="w-6 h-6 text-white drop-shadow" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
              <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2" />
              <circle cx="7" cy="17" r="2" />
              <path d="M9 17h6" />
              <circle cx="17" cy="17" r="2" />
              <path d="m13 6 3-3h3" />
            </svg>
          </div>
        </div>
        <h2 className="mt-3 text-center text-xl font-bold tracking-tight text-slate-900">
          Drive<span className="text-brand-600">Pulse</span> Enterprise
        </h2>
        <p className="text-center text-xs text-slate-500 mt-0.5">
          Automotive Sales Cloud & Dealership Intelligence
        </p>
      </div>

      <div className="mt-6 sm:mx-auto sm:w-full sm:max-w-md px-4">
        <div className="bg-white border border-slate-200 py-6 px-6 sm:px-8 shadow-subtle rounded-lg">
          {error && (
            <div className="mb-4 p-3 rounded-md bg-rose-50 border border-rose-200 flex items-center gap-2 text-xs text-rose-700">
              <AlertCircle className="w-4 h-4 shrink-0 text-rose-500" />
              <span>{error}</span>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-3.5">
            <Input
              label="Email or Mobile Number"
              type="text"
              required
              value={identifier}
              onChange={(e) => setIdentifier(e.target.value)}
              placeholder="e.g. sales1@autolms.com or 9800000003"
            />

            <Input
              label="Password"
              type="password"
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="••••••••"
            />

            <div className="pt-1">
              <Button type="submit" isLoading={isLoading} className="w-full" size="md" rightIcon={<ArrowRight className="w-4 h-4" />}>
                Sign In
              </Button>
            </div>
          </form>

          {/* Quick Demo Persona Switcher */}
          <div className="mt-6 pt-5 border-t border-slate-200">
            <p className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 text-center mb-2.5">
              1-Click Demo Login Profiles
            </p>
            <div className="grid grid-cols-2 gap-2">
              <button
                type="button"
                onClick={() => handleQuickLogin('ADMIN')}
                className="flex items-center gap-2 p-2 rounded-md bg-slate-50 hover:bg-slate-100 border border-slate-200 text-left transition-colors text-xs text-slate-800 font-medium"
              >
                <Shield className="w-3.5 h-3.5 text-rose-600 shrink-0" />
                <div>
                  <span className="block font-semibold">Admin</span>
                  <span className="text-[10px] text-slate-500">System Admin</span>
                </div>
              </button>

              <button
                type="button"
                onClick={() => handleQuickLogin('MANAGER')}
                className="flex items-center gap-2 p-2 rounded-md bg-slate-50 hover:bg-slate-100 border border-slate-200 text-left transition-colors text-xs text-slate-800 font-medium"
              >
                <Briefcase className="w-3.5 h-3.5 text-amber-600 shrink-0" />
                <div>
                  <span className="block font-semibold">Manager</span>
                  <span className="text-[10px] text-slate-500">Sales Manager</span>
                </div>
              </button>

              <button
                type="button"
                onClick={() => handleQuickLogin('SALES')}
                className="flex items-center gap-2 p-2 rounded-md bg-slate-50 hover:bg-slate-100 border border-slate-200 text-left transition-colors text-xs text-slate-800 font-medium"
              >
                <User className="w-3.5 h-3.5 text-brand-600 shrink-0" />
                <div>
                  <span className="block font-semibold">Sales Exec</span>
                  <span className="text-[10px] text-slate-500">Amit Kumar</span>
                </div>
              </button>

              <button
                type="button"
                onClick={() => handleQuickLogin('FIELD')}
                className="flex items-center gap-2 p-2 rounded-md bg-slate-50 hover:bg-slate-100 border border-slate-200 text-left transition-colors text-xs text-slate-800 font-medium"
              >
                <MapPin className="w-3.5 h-3.5 text-emerald-600 shrink-0" />
                <div>
                  <span className="block font-semibold">Field Agent</span>
                  <span className="text-[10px] text-slate-500">Commercial Fleets</span>
                </div>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
