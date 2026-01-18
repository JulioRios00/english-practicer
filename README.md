# English Pronunciation Practice 🗣️

Aplicação para prática de pronúncia em inglês usando IA.

## 🚀 Tecnologias

- **Frontend**: Next.js 15, TypeScript, Tailwind CSS
- **Backend**: Node.js, Express
- **IA**: Google Gemini Pro API
- **Speech Recognition**: Web Speech API (nativa do navegador)

## 📋 Pré-requisitos

- Node.js 18+ instalado
- Navegador Chrome ou Edge (para Web Speech API)
- Chave de API do Google Gemini Pro

## 🔧 Instalação

### 1. Instalar dependências do Backend

```bash
cd backend
npm install
```

### 2. Instalar dependências do Frontend

```bash
cd frontend
npm install
```

## ⚙️ Configuração

### Backend

O arquivo `.env` já está configurado com sua chave de API. Se precisar alterar:

```env
GEMINI_API_KEY=sua_chave_aqui
PORT=3001
```

### Frontend

O arquivo `.env.local` já está configurado. Padrão:

```env
NEXT_PUBLIC_API_URL=http://localhost:3001
```

## 🎯 Como Executar

### 1. Iniciar o Backend

```bash
cd backend
npm run dev
```

O servidor iniciará em `http://localhost:3001`

### 2. Iniciar o Frontend (em outro terminal)

```bash
cd frontend
npm run dev
```

A aplicação estará disponível em `http://localhost:3000`

## 📱 Como Usar

1. **Escolha um texto** para praticar (iniciante, intermediário ou avançado)
2. **Clique em "Começar a falar"** e permita o acesso ao microfone
3. **Leia o texto em inglês** em voz alta
4. **Clique para parar** a gravação
5. **Clique em "Analisar Pronúncia"** para receber feedback da IA
6. **Veja sua pontuação** e dicas de melhoria

## 🎓 Funcionalidades

- ✅ 5 textos de prática (iniciante a avançado)
- ✅ Reconhecimento de voz em tempo real
- ✅ Análise de pronúncia com IA
- ✅ Pontuação de 0 a 100
- ✅ Identificação de palavras mal pronunciadas
- ✅ Dicas personalizadas de melhoria
- ✅ Feedback motivacional

## 🛠️ Estrutura do Projeto

```
englishPractice/
├── backend/
│   ├── server.js          # Servidor Express + Gemini API
│   ├── package.json
│   └── .env
└── frontend/
    ├── app/
    │   └── page.tsx       # Página principal
    ├── components/
    │   └── PronunciationPractice.tsx  # Componente principal
    └── .env.local
```

## 🔑 API Endpoints

### GET `/api/practice-texts`
Retorna lista de textos para prática

### POST `/api/analyze-pronunciation`
Analisa a pronúncia do usuário

**Body:**
```json
{
  "originalText": "texto original",
  "transcribedText": "texto transcrito"
}
```

**Response:**
```json
{
  "score": 85,
  "incorrectWords": [
    {
      "word": "beautiful",
      "userPronounced": "butiful",
      "tip": "Pronuncie 'beau' como 'biú'"
    }
  ],
  "feedback": "Ótimo trabalho!",
  "suggestions": "Continue praticando..."
}
```

## 🐛 Troubleshooting

**Microfone não funciona:**
- Verifique permissões do navegador
- Use Chrome ou Edge
- Certifique-se que está usando HTTPS ou localhost

**Erro ao conectar com backend:**
- Verifique se o backend está rodando na porta 3001
- Confirme a variável `NEXT_PUBLIC_API_URL` no `.env.local`

**Erro da API Gemini:**
- Verifique se a chave de API está correta
- Confirme que não excedeu o limite de requisições

## 📝 Próximas Melhorias

- [ ] Adicionar mais textos de prática
- [ ] Salvar histórico de práticas
- [ ] Gráficos de evolução
- [ ] Comparação de áudio (usuário vs. nativo)
- [ ] Suporte para outros idiomas
- [ ] Sistema de gamificação

## 📄 Licença

MIT
