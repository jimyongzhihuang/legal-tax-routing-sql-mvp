/*
schema.sql

Copyright (c) 2026 Jim Y. Huang. All rights reserved.

This file is part of a limited public demonstration of a legal-tax routing SQL MVP.
It does not grant any licence for commercial deployment, AI model training,
enterprise implementation, derivative routing systems, or use of the associated
framework names, including 4-3-3-2, CDM, PJLS, FG, ITI, or ZITI.

The full framework, rule library, validation protocol, and implementation
architecture are proprietary and subject to separate written licensing terms.
*/

DROP VIEW IF EXISTS ai_output_brake_view;

DROP TABLE IF EXISTS tax_routing_4332_execution;
DROP TABLE IF EXISTS cdm_drawer_assignments;
DROP TABLE IF EXISTS pjls_evidence_items;
DROP TABLE IF EXISTS cases;

CREATE TABLE cases (
    case_id TEXT PRIMARY KEY,
    case_name TEXT NOT NULL,
    case_type TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pjls_evidence_items (
    evidence_id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL REFERENCES cases(case_id),
    evidence_type TEXT NOT NULL,
    evidence_label TEXT NOT NULL,
    is_formal_record BOOLEAN DEFAULT FALSE,
    is_signed BOOLEAN DEFAULT FALSE,
    is_third_party_verifiable BOOLEAN DEFAULT FALSE,
    is_admitted BOOLEAN DEFAULT FALSE,
    rejection_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cdm_drawer_assignments (
    drawer_assignment_id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL REFERENCES cases(case_id),

    cabinet_code TEXT NOT NULL,
    drawer_code TEXT NOT NULL,

    assignment_basis TEXT,
    required_evidence_status TEXT DEFAULT 'UNCHECKED',
    drawer_status TEXT DEFAULT 'PENDING',

    priority_sequence INTEGER NOT NULL,
    is_locked BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tax_routing_4332_execution (
    execution_id TEXT PRIMARY KEY,
    case_id TEXT NOT NULL REFERENCES cases(case_id),

    income_path TEXT NOT NULL CHECK (
        income_path IN (
            'EMPLOYMENT_INCOME',
            'BUSINESS_INCOME',
            'CAPITAL_GAIN_LOSS',
            'PROPERTY_INCOME'
        )
    ),

    taxpayer_container TEXT NOT NULL CHECK (
        taxpayer_container IN (
            'T1_INDIVIDUAL',
            'T2_CORPORATION',
            'T3_TRUST'
        )
    ),

    conversion_mode TEXT NOT NULL CHECK (
        conversion_mode IN (
            'TAXPAYER_IDENTITY_CHANGE',
            'INCOME_TYPE_CHANGE',
            'TIMING_CHANGE'
        )
    ),

    trigger_event TEXT NOT NULL CHECK (
        trigger_event IN (
            'USE_CHANGE',
            'TITLE_CHANGE'
        )
    ),

    route_locked BOOLEAN DEFAULT TRUE,
    grammar_status TEXT DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE VIEW ai_output_brake_view AS
SELECT
    c.case_id,
    c.case_name,
    c.case_type,

    CASE
        WHEN EXISTS (
            SELECT 1
            FROM cdm_drawer_assignments d
            WHERE d.case_id = c.case_id
              AND d.drawer_status = 'BLOCKED'
        )
        THEN 'AI_OUTPUT_BLOCKED: One or more required institutional drawers are blocked.'

        WHEN EXISTS (
            SELECT 1
            FROM tax_routing_4332_execution e
            WHERE e.case_id = c.case_id
              AND e.grammar_status LIKE 'FAILED%'
        )
        THEN 'AI_OUTPUT_BLOCKED: 4-3-3-2 route grammar failed.'

        WHEN EXISTS (
            SELECT 1
            FROM pjls_evidence_items p
            WHERE p.case_id = c.case_id
              AND p.is_admitted = FALSE
              AND p.evidence_type IN (
                  'SHAREHOLDER_LOAN_LEDGER',
                  'GENERAL_LEDGER_CONTINUITY',
                  'CORPORATE_RESOLUTION'
              )
        )
        THEN 'AI_OUTPUT_BLOCKED: Required PJLS evidence is missing or not admitted.'

        ELSE 'AI_OUTPUT_PERMITTED: Minimum evidentiary and routing conditions satisfied.'
    END AS brake_status

FROM cases c;
