---
title: "Email"
description: >
    A place to document my learnings about email
---

## Top-Notch Resources
* [Demystifying DMARC - Sean Whalen](https://seanthegeek.net/459/demystifying-dmarc/)

## Email Authentication

- **SPF** (Sender Policy Framework) - List of authorized mail sources
- **DKIM** (DomainKeys Identified Mail ) - Mail signature
  - Email sending server signs message with private key
  - Email domain publishes public key in DNS
  - Mail recipient server checks signature of mail against published DKIM values
- **DMARC** (Domain-based Message Authentication, Reporting and Conformance)
  - RUA (Aggregate)
  - RUF (Forensic)
  - p= (Policy to Apply)
  - max 2 recipients

