# Legal-Tax Routing SQL MVP

This repository provides a minimal SQL-based demonstration of a closure-gated legal-tax routing protocol.

The purpose of this demonstration is to show how an AI-generated legal or tax conclusion can be blocked before output when the required evidentiary record, institutional category, and route structure have not been properly opened.

This is not a tax chatbot, legal advice system, or complete commercial implementation. It is a low-fidelity public demonstration layer.

## Core Concept

General-purpose AI systems may generate fluent legal or tax conclusions before the underlying institutional pathway has been validated.

This repository demonstrates a simple alternative:

1. PJLS — Pre-Judgment Logic Shell  
   Checks whether the required evidence can be admitted before reasoning begins.

2. CDM — Cabinet-Drawer Model  
   Assigns the matter to the correct legal-tax drawer before classification occurs.

3. 4-3-3-2 Fiscal Routing Grammar  
   Forces the matter into a structured route grammar before any output is permitted.

4. AI Output Brake  
   Blocks unsupported conclusions when evidence, drawer assignment, or route validation fails.

## Demonstration Case

The sample case involves a Canadian private corporation that pays $120,000 to a shareholder.

The internal memo labels the payment as a “shareholder loan repayment.”

A general-purpose AI system may accept that label and generate a non-taxable repayment conclusion.

The closure-gated SQL protocol blocks that output because the required evidentiary pathway is not opened:

- no admitted opening shareholder loan balance;
- no admitted general ledger continuity;
- no signed corporate resolution supporting the repayment route.

The system does not decide the final tax result.

It prevents an unsupported conclusion from entering the institutional workflow.

## Files

- `schema.sql`  
  Defines the minimal SQL schema for cases, evidence intake, drawer assignment, 4-3-3-2 route execution, and output braking.

- `sample_failure_case.sql`  
  Inserts a fictional shareholder payment case and demonstrates how the proposed AI route is blocked.

## Intended Use

This repository is intended for review, discussion, academic reference, and low-fidelity technical demonstration only.

It is not a commercial product, tax opinion, legal opinion, compliance tool, or production-ready software.

## Intellectual Property Notice and Use Restrictions

This repository provides a limited public demonstration of a legal-tax routing concept. It is not a release of the full commercial framework, rule library, implementation architecture, or enterprise deployment protocol.

All rights are reserved by Jim Y. Huang unless expressly stated otherwise in writing.

### Protected Frameworks and Marks

The following names, marks, and framework identifiers are used to identify proprietary legal-tax routing concepts, methods, and related professional services developed by Jim Y. Huang:

- 4-3-3-2 Fiscal Routing Grammar
- Cabinet-Drawer Model (CDM)
- Pre-Judgment Logic Shell (PJLS)
- Fiscal Geometry
- Institutional Tension Index (ITI)
- Z-Indexed Institutional Tension Index (ZITI)

Trademark applications and related intellectual property filings may exist or be pending for certain names, marks, systems, and methods. No permission is granted to use these names, marks, or confusingly similar terms for commercial software, consulting services, AI governance products, tax technology products, or legal-tax routing systems without prior written authorization.

### Patent-Pending and Proprietary Method Notice

Certain technical methods, diagnostic protocols, routing structures, telemetry concepts, and institutional tension measurement processes referenced in or related to this repository may be subject to pending patent applications, unpublished implementation materials, trade secret protection, copyright protection, and separate commercial licensing terms.

This public repository does not grant any patent licence, trademark licence, commercial implementation licence, or right to reproduce the underlying proprietary framework.

### No Commercial Licence Granted

This repository is made available only as a low-fidelity public demonstration for review and discussion. Unless a separate written agreement is signed by Jim Y. Huang, users are not authorized to:

- deploy this repository or its derivatives in a commercial product;
- incorporate the demonstrated routing structure into enterprise legal, tax, compliance, or AI governance systems;
- use the repository as a basis for commercial consulting, software, workflow automation, or white-label implementation;
- use the repository contents for AI model training, fine-tuning, benchmarking, or enterprise product development;
- represent any derivative work as affiliated with, approved by, licensed by, or based on the proprietary frameworks of Jim Y. Huang.

### Demonstration Boundary

The files in this repository are intentionally limited. They do not include the full rule library, commercial validation logic, production architecture, client implementation protocol, or proprietary framework documentation.

Access to any private implementation layer requires a separate written licensing, advisory, or pilot agreement.

For licensing, advisory pilots, institutional collaboration, or enterprise implementation discussions, please contact Jim Y. Huang through verified professional or institutional channels.
