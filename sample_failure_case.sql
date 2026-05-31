/*
sample_failure_case.sql

Sample Failure Case:
Shareholder Extraction Misclassification

Purpose:
This file demonstrates how a closure-gated legal-tax routing protocol blocks
an AI-generated conclusion when the required evidentiary pathway has not been opened.

This is a fictional demonstration case only.
It is not legal advice, tax advice, or a complete implementation of the proprietary framework.
*/

INSERT INTO cases (
    case_id,
    case_name,
    case_type
) VALUES (
    'CASE-001',
    'Shareholder Payment Labelled as Loan Repayment',
    'SHAREHOLDER_EXTRACTION_MISCLASSIFICATION'
);

-- PJLS evidence intake:
-- The memo exists, but it is not enough to open the shareholder loan repayment drawer.

INSERT INTO pjls_evidence_items (
    evidence_id,
    case_id,
    evidence_type,
    evidence_label,
    is_formal_record,
    is_signed,
    is_third_party_verifiable,
    is_admitted,
    rejection_reason
) VALUES
(
    'EVD-001',
    'CASE-001',
    'INTERNAL_MEMO',
    'Memo labels payment as shareholder loan repayment',
    FALSE,
    FALSE,
    FALSE,
    FALSE,
    'Internal label is not sufficient to establish shareholder loan repayment route.'
),
(
    'EVD-002',
    'CASE-001',
    'BANK_RECORD',
    'Bank transfer of 120000 to shareholder',
    TRUE,
    FALSE,
    TRUE,
    TRUE,
    NULL
),
(
    'EVD-003',
    'CASE-001',
    'SHAREHOLDER_LOAN_LEDGER',
    'Opening shareholder loan balance support',
    FALSE,
    FALSE,
    FALSE,
    FALSE,
    'No admitted opening shareholder loan balance was provided.'
),
(
    'EVD-004',
    'CASE-001',
    'GENERAL_LEDGER_CONTINUITY',
    'GL continuity for shareholder loan account',
    FALSE,
    FALSE,
    FALSE,
    FALSE,
    'No admitted GL continuity was provided.'
),
(
    'EVD-005',
    'CASE-001',
    'CORPORATE_RESOLUTION',
    'Signed corporate resolution approving repayment',
    FALSE,
    FALSE,
    FALSE,
    FALSE,
    'No signed corporate resolution was provided.'
);

-- CDM drawer assignment:
-- The payment is not allowed to enter the shareholder loan repayment drawer
-- because the required admitted evidence is missing.

INSERT INTO cdm_drawer_assignments (
    drawer_assignment_id,
    case_id,
    cabinet_code,
    drawer_code,
    assignment_basis,
    required_evidence_status,
    drawer_status,
    priority_sequence,
    is_locked
) VALUES
(
    'DRW-001',
    'CASE-001',
    'TAX',
    'SHAREHOLDER_LOAN_REPAYMENT',
    'Payment memo uses loan repayment label, but required PJLS evidence is missing.',
    'FAILED',
    'BLOCKED',
    1,
    TRUE
),
(
    'DRW-002',
    'CASE-001',
    'TAX',
    'SHAREHOLDER_BENEFIT_RISK',
    'Payment to shareholder remains unresolved because loan repayment drawer is blocked.',
    'PARTIAL',
    'OPEN_FOR_REVIEW',
    2,
    TRUE
),
(
    'DRW-003',
    'CASE-001',
    'TAX',
    'DIVIDEND_REVIEW',
    'Alternative classification requires separate corporate authorization and reporting evidence.',
    'UNCHECKED',
    'PENDING',
    3,
    TRUE
);

-- 4-3-3-2 grammar execution:
-- The model attempts to classify the payment inside a T2 corporate container.
-- The route fails because the evidentiary drawer has not been opened.

INSERT INTO tax_routing_4332_execution (
    execution_id,
    case_id,
    income_path,
    taxpayer_container,
    conversion_mode,
    trigger_event,
    route_locked,
    grammar_status
) VALUES (
    'EXE-001',
    'CASE-001',
    'PROPERTY_INCOME',
    'T2_CORPORATION',
    'INCOME_TYPE_CHANGE',
    'TITLE_CHANGE',
    TRUE,
    'FAILED_EVIDENCE_CLOSURE'
);

-- Run this query to see the brake result:

SELECT * FROM ai_output_brake_view;
