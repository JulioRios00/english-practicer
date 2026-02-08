-- =============================================
-- Supabase Schema for English Practice App
-- Run this in the Supabase SQL Editor
-- =============================================

-- 1. Profiles table (extends Supabase auth.users)
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Practice sessions table
CREATE TABLE practice_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  practice_type TEXT NOT NULL CHECK (practice_type IN ('sentence', 'word')),
  -- Sentence fields
  text_id INT,
  text_level TEXT,
  original_text TEXT,
  transcribed_text TEXT,
  score INT CHECK (score >= 0 AND score <= 100),
  incorrect_words JSONB,
  feedback TEXT,
  suggestions TEXT,
  -- Word fields
  word TEXT,
  word_category TEXT,
  is_correct BOOLEAN,
  confidence INT CHECK (confidence >= 0 AND confidence <= 100),
  word_feedback TEXT,
  -- Common
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Indexes
CREATE INDEX idx_practice_sessions_user_id ON practice_sessions(user_id);
CREATE INDEX idx_practice_sessions_created_at ON practice_sessions(created_at DESC);
CREATE INDEX idx_practice_sessions_user_created ON practice_sessions(user_id, created_at DESC);

-- 4. Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE practice_sessions ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Practice sessions policies
CREATE POLICY "Users can view own sessions" ON practice_sessions
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own sessions" ON practice_sessions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 5. Auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, display_name)
  VALUES (NEW.id, NEW.raw_user_meta_data->>'display_name');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
