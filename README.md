# শ্রম সহায়ক v4.0 — Multi-Portal Bangladesh Labour Law Platform

Four separate portals, one unified backend. Every stakeholder in Bangladesh's world of work has a tailored experience.

---

## 🌐 The Four Portals

| Portal | Audience | Design | Key Features |
|---|---|---|---|
| 🏢 **Management** | HR Managers, Employers, MNCs | Dark green, professional | BLA compliance, ILO/GRI/ESG, PDF analyzer, MNC parent-country requirements |
| 👷 **Worker / শ্রমিক** | Workers, Job Seekers | Warm orange, Bangla-first | Know your rights, Grievance filing with AI guidance, Complaint tracker |
| ⚖️ **Legal / LexBD** | Advocates, DIFE, Courts | Dark gold, authoritative | Legal research, Draft court documents (6 types), DIFE checklist, Regulatory updates |
| 📚 **Academic / LaborScholar** | Researchers, Universities | Blue editorial | Comparative law research, Research notes, ILO analysis, RMG sector studies |

---

## 🏗 Project Structure

```
shrom-v4/
├── index.html                    ← Master landing page (portal selector)
├── portal-management/
│   └── index.html                ← Management portal (self-contained HTML)
├── portal-worker/
│   └── index.html                ← Worker portal (Bangla-first)
├── portal-legal/
│   └── index.html                ← Legal professional portal
├── portal-academic/
│   └── index.html                ← Academic research portal
├── backend/
│   ├── main.py                   ← Unified FastAPI (all 4 portals' APIs)
│   ├── models.py                 ← DB models (User, Sessions, Grievances, Docs, Notes)
│   ├── database.py
│   ├── auth.py                   ← JWT + role-based access control
│   ├── prompts.py                ← 4 distinct AI system prompts + all reference data
│   ├── requirements.txt
│   └── Dockerfile
├── shared/
│   └── api.js                    ← Shared API client reference
├── setup.sh                      ← Inject API URL into all portals
├── docker-compose.yml
├── render.yaml
└── README.md
```

---

## 🚀 Deploy to Render.com — Step by Step

### Step 1: Push to GitHub
```bash
git init && git add . && git commit -m "শ্রম সহায়ক v4 multi-portal"
git remote add origin https://github.com/YOUR/shrom-v4.git
git push -u origin main
```

### Step 2: Deploy Backend on Render
1. **render.com** → New → **Web Service**
2. Connect repo → Root Dir: `backend`
3. Build: `pip install -r requirements.txt`
4. Start: `uvicorn main:app --host 0.0.0.0 --port $PORT`
5. Add env vars: `ANTHROPIC_API_KEY` (your key) + `SECRET_KEY` (generate)
6. ✅ Deploy → **Copy your backend URL** (e.g. `https://shrom-v4-api.onrender.com`)

### Step 3: Configure Portal URLs
```bash
bash setup.sh https://shrom-v4-api.onrender.com
```
This injects your backend URL into all 4 portal HTML files.

### Step 4: Deploy Portals (4 Static Sites on Render)
For each portal, create a **Static Site** on Render:

| Site Name | Root Dir | Publish Dir |
|---|---|---|
| `shrom-landing` | `.` | `.` (root) — serves index.html |
| `shrom-management` | `portal-management` | `.` |
| `shrom-worker` | `portal-worker` | `.` |
| `shrom-legal` | `portal-legal` | `.` |
| `shrom-academic` | `portal-academic` | `.` |

Build command for all: (none needed — pure HTML)

✅ **Each portal gets its own URL** on Render's free tier!

---

## 🛠 Local Development

```bash
# 1. Configure portals to use local backend
bash setup.sh http://localhost:8000

# 2. Start backend
cd backend
pip install -r requirements.txt
cp .env.example .env  # Add ANTHROPIC_API_KEY
uvicorn main:app --reload --port 8000

# 3. Open portals
# Open index.html in browser — click any portal card

# OR with Docker:
cp .env.example .env
docker compose up --build
# → http://localhost:3000  (all portals)
# → http://localhost:8000  (API)
```

---

## 🔒 Security Architecture

- **JWT tokens per portal** — Management token can't access Worker APIs (role-based)
- **Role-enforced endpoints** — `/worker/grievance` only accepts `role=worker` tokens
- **API key server-side only** — Anthropic key never exposed to browser
- **bcrypt password hashing**
- **CORS** — restrict `allow_origins` to your portal URLs in production

---

## 🤖 AI Personas (One Claude, Four Personalities)

| Portal | AI Name | Tone | Language |
|---|---|---|---|
| Management | শ্রম সহায়ক | Professional, precise, cites sections | English + Bangla |
| Worker | শ্রম বন্ধু | Warm, friendly, plain language | **Bangla-first** |
| Legal | LexBD | Formal legal, drafts court documents | English (legal) |
| Academic | LaborScholar BD | Analytical, comparative, cites sources | English (academic) |

---

## ⚠️ Disclaimer

General legal guidance only. Consult a licensed Bangladesh labor law attorney for specific legal matters. Worker portal recommends free legal aid resources.

---

*🇧🇩 Built for Bangladesh · HR Professionals · Workers · Legal Community · Academia*
*Bangladesh Labour Act 2006 · ILO · GRI · ISO 30414 · Powered by Claude AI*
