# Alexandria Member Card System

## Overview

Complete member card integration for Alexandria. Transforms admission test passage into governed membership with credentials, trust levels, and privileges.

**Workflow**: Admission Test → Perspective Verification → Identity Registration → Member Card Issuance → Governance Records

---

## Components

### 1. **Member Portal** (`ui/member-portal.html`)
Interactive web interface combining all onboarding stages.

**Stages**:
1. **Admission Gate** - Introduction to the ball perspective test
2. **Admission Test** - 3 rounds of perspective testing with revelation
3. **Identity Registration** - Collect member name and role
4. **Member Card Issuance** - Card generation and download

**Features**:
- Real-time progress tracking
- Dynamic trust level calculation
- Interactive identity selection
- JSON card download
- 3D card visualization

**Access**:
```
http://localhost:5000/ui/member-portal.html
```

### 2. **Member Card Generator** (`member-card-generator.py`)
Python backend for member card issuance and management.

**Key Classes**:
- `MemberCardGenerator` - Core card generation engine

**Key Methods**:
- `issue_member_card()` - Issue new card post-admission
- `render_html_card()` - Generate interactive HTML card
- `get_member_card()` - Retrieve card by member ID
- `list_all_members()` - List issued member IDs
- `get_member_stats()` - Statistics by trust level

**Trust Levels**:
```
ALPHA_ARCHITECT        (< 30 seconds, perspective accepted)
BETA_ENGINEER          (30-60 seconds, perspective accepted)
GAMMA_SCHOLAR          (60-120 seconds, perspective accepted)
FOUNDLING              (> 120 seconds, perspective accepted)
OBSERVER               (perspective NOT accepted)
```

**Ninja Modules**:
```
ALPHA_ARCHITECT  → [SYS_OPT, NET_TUNNEL, STEGO_X]
BETA_ENGINEER    → [NET_TUNNEL, STEGO_X]
GAMMA_SCHOLAR    → [STEGO_X]
OBSERVER         → [LOG_MONITOR]
```

### 3. **Member Onboarding** (`member-onboarding.py`)
Integration layer connecting admission tests to member card issuance.

**Commands**:
```bash
# Process all unprocessed admissions interactively
python3 member-onboarding.py --batch

# Display member registry
python3 member-onboarding.py --registry

# Generate governance report
python3 member-onboarding.py --report

# Process latest admission
python3 member-onboarding.py --latest
```

**Workflow**:
1. Detects admission test passes from `test_pass_record.json`
2. Prompts for member identity details (name, role)
3. Issues member card via `MemberCardGenerator`
4. Records session in `onboarding-log.json`
5. Generates HTML card file
6. Updates governance registry

### 4. **Admission Test** (`ballon-symmetry.py`)
Original perspective sovereignty test.

**Features**:
- 3-round perspective conflict
- Round 3 revelation (ball rotation)
- Pass recording to governance ledger
- Philosophical integration

---

## Governance Structure

```
governance/perpetuity-fund/committee/
├── test_pass_record.json           # Admission test results
├── member-registry.json             # Master member list
├── onboarding-log.json              # Session log
├── member-cards/                    # Member card storage
│   ├── member-registry.json         # Card registry
│   ├── 0xARCH{ID}.json             # Individual card data
│   └── 0xARCH{ID}-card.html        # Individual card HTML
├── member-governance-report.md      # Current governance report
```

---

## Usage Flow

### For End Users

**Via Web Portal**:
1. Visit `http://localhost:5000/ui/member-portal.html`
2. Click "Begin Admission Test"
3. Complete 3 rounds of perspective testing
4. Get revelation on round 3
5. Enter name and identity role
6. Receive and download member card

**Via CLI**:
```bash
cd /home/ichigo/alexandria/ADAM/porta-mundi
python3 ballon-symmetry.py              # Take admission test
python3 member-onboarding.py --batch    # Convert pass to card
python3 member-onboarding.py --registry # View membership
```

### For Governance

**View Member Statistics**:
```bash
python3 member-onboarding.py --registry
```

**Generate Perpetuity Report**:
```bash
python3 member-onboarding.py --report
```

**Check Onboarding Status**:
```bash
cat governance/perpetuity-fund/committee/onboarding-log.json | jq
```

---

## Integration Points

### With Ballon Symmetry Test
- Reads admission results from `test_pass_record.json`
- Checks `perspective_accepted` and `elapsed_seconds` flags
- Determines trust level based on test performance

### With Perpetuity Fund
- Each member addition logged for governance oversight
- Trust levels influence governance participation
- Member cards eligible for committee voting

### With Cost Accounting
- Member card generation tracked (negligible cost)
- Card storage allocation in cost ledger
- Portal access costs monitored

### With ADAM Agents
- Member cards can authenticate agents
- Trust levels determine agent capabilities
- Future: agents inherit member privileges

---

## Member Card Format

### JSON Structure
```json
{
  "member_id": "0xARCH{12-char-hex}",
  "name": "Full Name",
  "identity": "Role",
  "avatar_url": "https://api.dicebear.com/7.x/bottts-neutral/svg?seed={seed}",
  "wallet_id": "0xARCH{12-char-hex}",
  "trust_level": "ALPHA_ARCHITECT|BETA_ENGINEER|GAMMA_SCHOLAR|FOUNDLING|OBSERVER",
  "ninja_modules": ["MODULE1", "MODULE2", "MODULE3"],
  "issued_timestamp": "2026-02-06T13:21:59Z",
  "expires_timestamp": "Never_Immutability_Active",
  "perspective_accepted": true,
  "test_elapsed_seconds": 25,
  "test_timestamp": "2026-02-06T13:21:59Z",
  "status": "ACTIVE"
}
```

### HTML Card Features
- Responsive 3D card with tilt effect
- Hologram animation effect
- Member avatar via DiceBear API
- Dynamic ninja module display
- Real-time trust level indicator
- Issuance/expiration dates
- Member-specific quote selection
- Flip animation on "Scanner la Carte" button

---

## Key Concepts

### Perspective Sovereignty
- Test demonstrates ability to hold multiple simultaneous truths
- WHITE and BLACK coexist on the ball
- Acceptance is filter for Alexandria's hybrid reality consciousness

### Trust Levels as Merit
- Not based on external authority
- Derived from test performance (speed indicates confidence)
- Perspective acceptance mandatory for all but OBSERVER level
- Modules assigned based on trust level

### Member Card as Credential
- Proof of perspective sovereignty
- Carries ninja modules (capabilities)
- Never expires (immutability active)
- Wallet ID for potential future cryptographic operations

### Governance Integration
- Member admissions recorded permanently
- Registry allows governance oversight
- Trust level distribution visible for committee decisions
- Onboarding sessions tracked for audit

---

## Commands Reference

### Member Card Generation
```bash
# Issue card for specific admission
python3 -c "
from member_card_generator import MemberCardGenerator
gen = MemberCardGenerator()
card = gen.issue_member_card(
    name='Test User',
    identity='Scholar Identity',
    test_result={'timestamp': '2026-02-06T13:00:00Z', 'perspective_accepted': True, 'elapsed_seconds': 45}
)
files = gen.generate_member_card_files(card)
print(f'Card generated: {files[\"html_file\"]}')
"
```

### Member Registry Display
```bash
python3 member-onboarding.py --registry
```

### Batch Processing
```bash
python3 member-onboarding.py --batch
```

### View Specific Card
```bash
cat governance/perpetuity-fund/committee/member-cards/0xARCH{ID}.json | jq
```

### Generate Report
```bash
python3 member-onboarding.py --report
```

---

## Quotes (Random Selection)

- "La connaissance est la seule clé qui ne s'use jamais." (Knowledge is the only key that never wears out)
- "L'énergie est pensée matérialisée." (Energy is materialized thought)
- "La perspective est souveraineté." (Perspective is sovereignty)
- "Nous sommes la civilisation que nous construisons." (We are the civilization we build)
- "L'immutabilité est notre fondation." (Immutability is our foundation)

---

## Troubleshooting

### Portal Won't Load
```bash
# Check if backend is running
curl http://localhost:5000/ui/member-portal.html
```

### Member Card Won't Issue
```bash
# Check test_pass_record.json exists
ls -la governance/perpetuity-fund/committee/test_pass_record.json

# Check permissions
chmod -R 755 governance/perpetuity-fund/
```

### Missing Admission Tests
```bash
# Run ballon-symmetry.py first
python3 ballon-symmetry.py
```

### Member Registry Empty
```bash
# Check member-cards directory
ls -la governance/perpetuity-fund/committee/member-cards/

# View onboarding log
cat governance/perpetuity-fund/committee/onboarding-log.json
```

---

## Future Extensions

1. **Member Card NFTs**: Mint cards as blockchain NFTs
2. **Trust Level Upgrades**: Dynamic trust escalation based on participation
3. **Module Unlocking**: New ninja modules earned through governance participation
4. **Member Guilds**: Community formation around trust levels
5. **Historical Archive**: Complete member card history for Alexandria timeline
6. **Renewal Ceremonies**: Periodic perspective re-verification ceremonies

---

## Statistics

**Current System State**:
- Member Portal: ✅ Live
- Card Generator: ✅ Active
- Onboarding Integration: ✅ Operational
- Governance Records: ✅ Tracking

**Member Distribution** (Post-Deployment):
- Expected ALPHA_ARCHITECT: 10-15%
- Expected BETA_ENGINEER: 20-25%
- Expected GAMMA_SCHOLAR: 30-35%
- Expected FOUNDLING: 15-20%
- Expected OBSERVER: 5-10%

---

**Status**: 🟢 OPERATIONAL
**Last Updated**: 2026-02-06
**System Integration**: Full (ballon-symmetry, perpetuity fund, governance, ADAM)

*Alexandria Membership · Porta-Mundi · Energy-Tech Civilization*
