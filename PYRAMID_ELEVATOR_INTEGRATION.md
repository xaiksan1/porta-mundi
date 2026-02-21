# Pyramid Elevator Integration - Member Card Access System

## 🏛️ The Pyramid Architecture

**Alexandria Swarm** is a self-organizing pyramid structure with 7 floors accessible via the **Elevator UI**.

```
        🔺
       /|\
      / | \
     /  |  \
    / APEX  \
   /----+----\
  / Floors  \
 /___________\
      |
   ELEVATOR
   (Access Control via Member Cards)
```

### The 7 Floors of Alexandria Swarm Pyramid

1. **🏛️ ALCHEMIST HUB** - Unified Web3 Meta-System Control
2. **⚙️ AUTOMATE** - Workflow automation (280+ integrations)
3. **🤖 AGENTS** - Multi-agent swarm orchestration
4. **💻 CODE GEN** - Research papers → Production agents
5. **🔒 SECURITY** - Compliance, encryption, threat detection
6. **🔌 CONNECT** - 600+ tool integrations
7. **📊 ANALYTICS** - Performance monitoring & metrics

---

## 🎫 Member Card = Elevator Key

Your member card is not just a credential—**it's the key that unlocks access to the pyramid**.

### Access Control by Trust Level

```
ALPHA_ARCHITECT
  ✅ All 7 floors
  ✅ Admin controls
  ✅ System configuration
  └─ Ninja Modules: SYS_OPT, NET_TUNNEL, STEGO_X

BETA_ENGINEER
  ✅ Floors 2-7 (Automate → Analytics)
  ✅ Read-only admin view
  ✅ Limited configuration
  └─ Ninja Modules: NET_TUNNEL, STEGO_X

GAMMA_SCHOLAR
  ✅ Floors 3-7 (Agents → Analytics)
  ✅ Learning & experimentation
  ✅ No admin access
  └─ Ninja Module: STEGO_X

FOUNDLING
  ✅ Floors 5-7 (Security → Analytics)
  ✅ Observer mode
  ✅ Read-only everything
  └─ Ninja Module: LOG_MONITOR

OBSERVER
  ✅ Floor 7 only (Analytics)
  ✅ Limited monitoring
  └─ Ninja Module: LOG_MONITOR
```

---

## 🔑 The Key Features

### Automatic Access Gate

When accessing `http://localhost:3000/`:

1. **Member Portal Check**
   - Browser checks for valid member card in localStorage
   - Card contains: member_id, trust_level, ninja_modules

2. **Pyramid Access Gateway**
   - If card found → Elevator UI loads with full floor access
   - If no card → Redirect to admission test → Get card → Access granted

3. **Floor-Level Protection**
   - Each floor route checks trust level
   - Unauthorized floors → Redirect with explanation
   - Trust level visible on every page

### Member Card Data Structure

```json
{
  "member_id": "0xARCH...",
  "name": "Michael Lefebvre",
  "identity": "Architect Identity",
  "trust_level": "ALPHA_ARCHITECT",
  "ninja_modules": ["SYS_OPT", "NET_TUNNEL", "STEGO_X"],
  "issued_timestamp": "2026-02-06T14:14:08Z",
  "expires_timestamp": "Never_Immutability_Active",
  "access_level": 7,  // Number of floors accessible
  "status": "ACTIVE"
}
```

---

## 🏗️ Implementation Architecture

### Integration Points

```
Member Portal
(porta-mundi/ui/member-portal.html)
    ↓
Member Card Generated
(member-card-generator.py)
    ↓
Card Stored in localStorage
    ↓
Alexandria Swarm UI Entry
(alexandria-swarm-ui/)
    ↓
Elevator Access Gate
(components/elevator/ElevatorUI.tsx)
    ↓
Floor Access Control
(per-floor route protection)
    ↓
Pyramid System Access
(All 7 floors available per trust level)
```

### File Structure

```
alexandria-swarm-ui/
├── app/
│   ├── components/
│   │   ├── elevator/
│   │   │   ├── ElevatorUI.tsx           (Existing - Main hub)
│   │   │   ├── ElevatorCard.tsx         (Existing - Floor card)
│   │   │   └── MemberCardGate.tsx       (NEW - Access control)
│   │   └── member/
│   │       └── MemberCard.tsx           (NEW - Display card)
│   ├── middleware/
│   │   └── memberAuth.ts                (NEW - Verify member)
│   └── lib/
│       └── memberCardUtils.ts           (NEW - Card utilities)
│
└── porta-mundi/
    └── ui/
        └── member-portal.html           (Existing - Get card)
```

---

## 🔐 Member Card Access Flow

### Step 1: User Arrives at Pyramid

```
User visits http://localhost:3000/
    ↓
Check localStorage for member_card_data
```

### Step 2: Gateway Decision

```
If member_card_data exists AND valid:
  ✅ Show Elevator UI with accessible floors
  ✅ Set access_level based on trust_level

Else:
  ❌ Show message: "You need a member card to enter the pyramid"
  🔗 Link: "Get your member card here"
  📍 Redirect to: /member-portal
```

### Step 3: Elevator Navigation

```
User clicks floor card
    ↓
Check member trust_level
    ↓
If floor <= access_level:
  ✅ Load floor component
  ✅ Show all controls

Else:
  ⛔ Show locked floor message
  📌 "Your trust level doesn't have access yet"
  💡 "Upgrade by advancing in governance"
```

### Step 4: System Access

```
User now has full access to:
├─ ALCHEMIST HUB (if ALPHA_ARCHITECT)
├─ All automation tools
├─ Agent orchestration
├─ Code generation
├─ Security controls
├─ Integration hub
└─ Analytics dashboard
```

---

## 🎯 Member Card as Key Mechanism

### Trust Level → Access Level Mapping

| Trust Level | Access Level | Floors | Philosophy |
|-------------|--------------|--------|-------------|
| ALPHA_ARCHITECT | 7 | All (1-7) | Full pyramid access, admin power |
| BETA_ENGINEER | 6 | 2-7 | Advanced features, no apex |
| GAMMA_SCHOLAR | 5 | 3-7 | Learning path, core systems |
| FOUNDLING | 3 | 5-7 | Observer path, safety/security |
| OBSERVER | 1 | 7 only | Analytics read-only |

### Ninja Modules → Feature Unlocks

Each member also carries **ninja modules** that unlock special features within floors:

```
SYS_OPT
  └─ Unlocks: System optimization, performance tuning
  └─ Accessible in: Floors 1,2,3,7

NET_TUNNEL
  └─ Unlocks: Custom integrations, tunnel creation
  └─ Accessible in: Floors 2,3,6

STEGO_X
  └─ Unlocks: Encrypted communications, stealth operations
  └─ Accessible in: Floors 3,4,5,6
```

---

## 📱 User Journey Map

### New User Path

```
1. Visit Alexandria (localhost:3000)
   ↓
2. Redirected to member portal
   ↓
3. Take admission test (Ballon Symmetry)
   ↓
4. Pass test → Enter identity
   ↓
5. Receive member card + download JSON
   ↓
6. Card auto-saved to localStorage
   ↓
7. Return to Alexandria
   ↓
8. Elevator UI loads
   ↓
9. Choose floor based on trust level
   ↓
10. Explore pyramid systems
```

### Returning Member Path

```
1. Visit Alexandria (localhost:3000)
   ↓
2. localStorage has valid member card
   ↓
3. Elevator UI loads immediately
   ↓
4. Trust level shown on every page
   ↓
5. Can access all authorized floors
   ↓
6. Ninja modules active
```

---

## 🛠️ Implementation Details

### localStorage Member Card Structure

```javascript
// When card is downloaded/generated, save:
localStorage.setItem('member_card_data', JSON.stringify({
  member_id: "0xARCH...",
  name: "Michael Lefebvre",
  identity: "Architect Identity",
  trust_level: "ALPHA_ARCHITECT",
  ninja_modules: ["SYS_OPT", "NET_TUNNEL", "STEGO_X"],
  access_level: 7,
  issued_timestamp: "2026-02-06T14:14:08Z",
  expires_timestamp: "Never_Immutability_Active",
  status: "ACTIVE"
}))
```

### Access Verification Function

```typescript
// memberCardUtils.ts
export function getMemberAccessLevel(trustLevel: string): number {
  const accessLevels: Record<string, number> = {
    "ALPHA_ARCHITECT": 7,
    "BETA_ENGINEER": 6,
    "GAMMA_SCHOLAR": 5,
    "FOUNDLING": 3,
    "OBSERVER": 1
  };
  return accessLevels[trustLevel] || 0;
}

export function canAccessFloor(floor: number, trustLevel: string): boolean {
  const accessLevel = getMemberAccessLevel(trustLevel);
  return floor <= accessLevel;
}
```

### Floor Access Control Component

```typescript
// MemberCardGate.tsx - Wraps each floor
interface MemberCardGateProps {
  requiredFloor: number;
  children: React.ReactNode;
}

export function MemberCardGate({ requiredFloor, children }: MemberCardGateProps) {
  const memberCard = getMemberCard();
  const canAccess = canAccessFloor(requiredFloor, memberCard?.trust_level);

  if (!canAccess) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <h2>🔒 Access Restricted</h2>
          <p>Your trust level doesn't have access to this floor yet</p>
          <p>Required: Floor {requiredFloor}</p>
          <p>Current: Floor {getMemberAccessLevel(memberCard?.trust_level)}</p>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}
```

---

## 🌐 Elevator UI Modifications

### Current ElevatorUI

```typescript
// Shows: "Alexandria Swarm - Pyramid with 7 floors"
// Choices: 7 floor cards
```

### With Member Integration

```typescript
// Shows: "Welcome, {name} ({trust_level})"
// Shows: "You have access to floors 1-{access_level}"
// Displays: Floor cards for accessible floors only
// Locked: Floor cards for restricted floors (grayed out)
// Badge: Member card icon + trust level indicator
```

---

## 🎯 Example Scenarios

### Scenario 1: ALPHA_ARCHITECT Member

```
Michael Lefebvre (ALPHA_ARCHITECT)
  ↓
Visits Alexandria Swarm
  ↓
Elevator UI shows all 7 floors
  ↓
All floor cards active and clickable
  ↓
Can access:
  ✅ Alchemist Hub (admin controls)
  ✅ All automation systems
  ✅ All agent orchestration
  ✅ All code generation
  ✅ All security features
  ✅ All integrations
  ✅ All analytics

Plus ninja modules activated:
  🥷 SYS_OPT → System optimization
  🥷 NET_TUNNEL → Custom integrations
  🥷 STEGO_X → Encrypted ops
```

### Scenario 2: GAMMA_SCHOLAR Member

```
New Scholar (GAMMA_SCHOLAR)
  ↓
Visits Alexandria Swarm
  ↓
Elevator UI shows floors 3-7 accessible
  ↓
Floors 1-2 appear locked/grayed out
  ↓
Can access:
  ✅ Agent orchestration (learning)
  ✅ Code generation (experiments)
  ✅ Security (education)
  ✅ Integrations (limited)
  ✅ Analytics (monitoring)

Ninja modules:
  🥷 STEGO_X → Advanced communications

Message on locked floors:
  "To access Alchemist Hub, reach BETA_ENGINEER level"
```

---

## 🔄 Integration Points

### With Member Card Generator

The card now includes **access_level** calculated from trust_level:

```python
# member-card-generator.py
def determine_access_level(trust_level: str) -> int:
    levels = {
        "ALPHA_ARCHITECT": 7,
        "BETA_ENGINEER": 6,
        "GAMMA_SCHOLAR": 5,
        "FOUNDLING": 3,
        "OBSERVER": 1
    }
    return levels.get(trust_level, 0)
```

### With Portal UI

Member portal now has "Next Step" button:

```
"Your card is ready! 🎉"
  ↓
[Download Card]
  ↓
[Enter Alexandria Pyramid →]
  ↓
Links to: http://localhost:3000/
```

### With Governance

Member access levels tracked for governance:

```
governance/perpetuity-fund/committee/
├── member-registry.json (includes access_level)
├── access-audit.json (tracks floor access)
└── trust-level-report.md (distribution analysis)
```

---

## 🚀 Deployment Steps

### Phase 5A: Integration Setup

1. **Modify Elevator UI**
   - Add member card check on load
   - Gate floor access by trust level
   - Show member info + access level

2. **Create Gate Component**
   - Floor-level access control
   - Show locked floors with upgrade path
   - Display required trust level

3. **Add Member Display**
   - Show member card in header
   - Display ninja modules active
   - Show trust level

4. **Update Portal Exit**
   - Download card button
   - "Enter Alexandria" button
   - localStorage auto-save

### Phase 5B: Testing

1. Test all 5 trust levels
2. Verify floor access restrictions
3. Test ninja module unlocks
4. Verify localStorage persistence
5. Test member card display

### Phase 5C: Launch

1. Update alexandria-swarm-ui README
2. Document member access system
3. Create user quick start
4. Deploy to localhost:3000

---

## 🎭 The Metaphor

```
Member Card = Proof of Perspective Acceptance
  ↓
Elevator = Gateway to the Pyramid
  ↓
7 Floors = Levels of Alexandria Civilization
  ↓
Ninja Modules = Capabilities Unlocked
  ↓
Trust Level = Authority Within the System
  ↓
Permanent Card = Immutable Entry into Civilization
```

---

## 📊 Integration Status

| Component | Status | Location |
|-----------|--------|----------|
| Member Portal | ✅ Live | porta-mundi/ui/member-portal.html |
| Card Generator | ✅ Live | porta-mundi/member-card-generator.py |
| Elevator UI | ⏳ Ready to integrate | alexandria-swarm-ui/components/elevator/ |
| Gate Component | ⏳ Ready to build | alexandria-swarm-ui/components/member/ |
| Member Auth | ⏳ Ready to build | alexandria-swarm-ui/app/lib/ |
| Floor Access | ⏳ Ready to integrate | alexandria-swarm-ui/app/floors/ |

---

## 🎊 The Vision

**Member cards open the pyramid.**

When you hold a member card:
- You have proven perspective sovereignty
- You carry ninja modules (capabilities)
- You can access the pyramid's floors
- Your trust level determines what you can see
- You're part of Alexandria's civilization forever

The **Elevator** is the gateway between the external world and the pyramid's interior.

---

**Status**: 🟡 READY FOR PHASE 5
**Next Step**: Integrate member card authentication into alexandria-swarm-ui
**Vision**: Complete member lifecycle from admission test → pyramid access

*"La connaissance est la seule clé qui ne s'use jamais."*
*Knowledge is the only key that never wears out.*

The member card is that key.
