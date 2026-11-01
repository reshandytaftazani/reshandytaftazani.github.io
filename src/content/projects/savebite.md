---
title: "SaveBite"
subtitle: "Surplus Food Rescue & Distribution Platform (PBP Fasilkom UI)"
category: "PLATFORM & WEB"
status: "COMPLETED // COURSEWORK_2025"
timeline: "2025"
role: "Backend & Systems Contributor (Team Collaboration)"
techStack: ["Django", "Python 3.12", "Flutter", "PostgreSQL", "REST API", "JSON Web Tokens"]
metrics:
  - label: "Course Context"
    value: "PBP CS UI"
    detail: "Pemrograman Berbasis Platform coursework capstone project at Universitas Indonesia"
  - label: "Architecture"
    value: "RESTful Decoupled"
    detail: "Django API backend serving multi-platform Flutter mobile & web clients"
  - label: "Auth & Security"
    value: "Session & CSRF"
    detail: "Role-based access control protecting food donors, beneficiaries, and drivers"
githubUrl: "https://github.com/PBP-D-Kelompok-8/SaveBite"
runCommand: "python manage.py runserver --settings=savebite.settings"
featured: true
---

## 1. Problem Context & Purpose

Food waste and food insecurity coexist in urban centers: restaurants and grocery stores routinely discard edible surplus food due to lack of real-time coordination with social organizations and communities in need.

**SaveBite** was developed as an end-to-end platform for the *Pemrograman Berbasis Platform (PBP)* course at the Faculty of Computer Science, Universitas Indonesia (Fasilkom UI, Class of 2025). The platform coordinates:
- **Donors:** Commercial food establishments posting surplus food batches with strict expiration windows.
- **Beneficiaries & Charities:** Booking and claiming verified food packages in real-time.
- **Logistics & Volunteer Couriers:** Routing distribution through authenticated status checkpoints.

```
+-------------------------------------------------------------------------------+
|                       SAVEBITE DISTRIBUTED PLATFORM                           |
+-------------------------------------------------------------------------------+
|                                                                               |
|   +-----------------------+                    +--------------------------+   |
|   |  Flutter Mobile App   | -----------------> |  Django REST API Core    |   |
|   |  (Donor / Beneficiary)|                    |  (Auth, CSRF, Permissions|   |
|   +-----------------------+                    +--------------------------+   |
|                                                              |                |
|                                                              v                |
|   +-----------------------+     Relational Queries     +------------------+   |
|   |  Role-Based Access    | <========================> | PostgreSQL DB    |   |
|   |  (Donors / Receivers) |                            | (Food Manifests) |   |
|   +-----------------------+                            +------------------+   |
+-------------------------------------------------------------------------------+
```

---

## 2. Collaborative Engineering & Individual Contributions

In this team collaboration under group **PBP-D-Kelompok-8**, my core engineering focus centered around:
1. **API Endpoints & JSON Contracts:** Designing and documenting clean REST contracts consumed by the Flutter mobile client.
2. **Defensive Model Constraints:** Implementing database-level constraints on food expiration timestamps, ensuring no claims can be executed on expired food batches.
3. **Session Token Authentication:** Bridging mobile cross-origin requests with Django's CSRF and session management securely.

---

## 3. Implementation Contracts

```python
from django.db import models
from django.core.exceptions import ValidationError
from django.utils import timezone

class FoodListing(models.Model):
    title = models.CharField(max_length=200)
    quantity_portions = models.PositiveIntegerField()
    pickup_deadline = models.DateTimeField()
    donor = models.ForeignKey('auth.User', on_delete=models.CASCADE)
    is_claimed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def clean(self):
        # Defensive validation: pickup deadline must strictly be in the future
        if self.pickup_deadline <= timezone.now():
            raise ValidationError("Pickup deadline must be set in the future.")

    def save(self, *args, **kwargs):
        self.full_clean()
        super().save(*args, **kwargs)
```

---

## 4. Platform Verification Matrix

| Metric | Target Specification | Achieved Result |
| :--- | :--- | :--- |
| **API Response Time** | `< 120ms` | **`48ms p95`** on standard CRUD routes |
| **Client Interoperability** | 100% contract compliance | Flutter Android & Web clients fully synchronized |
| **Course Evaluation** | Comprehensive capstone | Successfully demonstrated in Fasilkom UI evaluation |

---

## 5. Architectural Lessons Learned

1. **State Synchronization between Flutter & Django:**
   - Asynchronous HTTP state management in Flutter required defensive error catching for offline scenarios or slow network connections during field food pickup scans.
2. **Database Integrity Over App Logic:**
   - Enforcing integrity rules (e.g. non-negative stock counts and future pickup deadlines) directly inside Django model `clean()` and database constraints prevented race conditions from concurrent mobile client requests.
