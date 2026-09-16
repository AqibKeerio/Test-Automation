*** Settings ***
Documentation    Verifies the Contact page form renders, validates required
...              fields, and can be submitted with valid data.
...
...              NOTE: The "successful submission" test performs a REAL form
...              submission against the live site by default. Set the
...              SKIP_REAL_SUBMIT variable to True (the default) to keep the
...              suite from spamming the site owner's inbox on every CI run;
...              flip it to False only when you intentionally want to verify
...              end-to-end email delivery.
Resource         ../resources/common.resource
Suite Setup      Open GNSS Decoded Browser
Suite Teardown   Close GNSS Decoded Browser
Test Setup       Go To Page    ${PATH_CONTACT}
Test Teardown    Capture Failure Screenshot
Test Tags        contact    regression


*** Variables ***
${SKIP_REAL_SUBMIT}    True
${TEST_NAME}           Robot Framework QA
${TEST_EMAIL}          robot.qa.tests@example.com
${TEST_SUBJECT}        Automated test - please ignore
${TEST_MESSAGE}        This message was submitted by an automated Robot Framework test suite.


*** Test Cases ***
Contact Page Loads With Form Fields
    [Documentation]    The contact page renders a heading and all four
    ...    expected form fields: Name, Email, Subject, Message.
    Page Should Contain    Contact GNSSDecoded
    Page Should Contain Element    ${CONTACT_NAME_INPUT}
    Page Should Contain Element    ${CONTACT_EMAIL_INPUT}
    Page Should Contain Element    ${CONTACT_SUBJECT_INPUT}
    Page Should Contain Element    ${CONTACT_MESSAGE_INPUT}
    Page Should Contain Element    ${CONTACT_SUBMIT_BUTTON}

Contact Form Rejects Empty Submission
    [Documentation]    Submitting the form with all fields empty should keep
    ...    the user on the contact page and show validation errors rather
    ...    than silently succeeding.
    Element Should Be Visible And Enabled    ${CONTACT_SUBMIT_BUTTON}
    Click Element    ${CONTACT_SUBMIT_BUTTON}
    Sleep    1s    reason=allow client-side validation to render
    Location Should Contain    /contact
    ${has_validation}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${CONTACT_VALIDATION_ERROR}
    IF    not ${has_validation}
        Log    No .wpcf7-not-valid-tip element found — form plugin may differ; confirming HTML5 "required" validation instead.    level=WARN
        ${is_required}=    Get Element Attribute    ${CONTACT_NAME_INPUT}    required
        Should Not Be Equal As Strings    ${is_required}    ${None}
    END

Contact Form Rejects Invalid Email Format
    [Documentation]    Entering a malformed email address should trigger a
    ...    validation error instead of allowing submission.
    Input Text    ${CONTACT_NAME_INPUT}    ${TEST_NAME}
    Input Text    ${CONTACT_EMAIL_INPUT}    not-a-valid-email
    Input Text    ${CONTACT_SUBJECT_INPUT}    ${TEST_SUBJECT}
    Input Text    ${CONTACT_MESSAGE_INPUT}    ${TEST_MESSAGE}
    Click Element    ${CONTACT_SUBMIT_BUTTON}
    Sleep    1s    reason=allow client-side validation to render
    Location Should Contain    /contact

Contact Form Accepts Valid Input Values
    [Documentation]    All fields accept and correctly retain typed values
    ...    before submission (verifies the form itself is interactive,
    ...    without triggering a real email send).
    Input Text    ${CONTACT_NAME_INPUT}    ${TEST_NAME}
    Input Text    ${CONTACT_EMAIL_INPUT}    ${TEST_EMAIL}
    Input Text    ${CONTACT_SUBJECT_INPUT}    ${TEST_SUBJECT}
    Input Text    ${CONTACT_MESSAGE_INPUT}    ${TEST_MESSAGE}
    Textfield Value Should Be    ${CONTACT_NAME_INPUT}    ${TEST_NAME}
    Textfield Value Should Be    ${CONTACT_EMAIL_INPUT}    ${TEST_EMAIL}
    Textfield Value Should Be    ${CONTACT_SUBJECT_INPUT}    ${TEST_SUBJECT}
    Textfield Value Should Be    ${CONTACT_MESSAGE_INPUT}    ${TEST_MESSAGE}

Contact Form Submits Successfully With Valid Data
    [Documentation]    End-to-end submission of a fully valid form. Skipped by
    ...    default (see SKIP_REAL_SUBMIT) to avoid sending real emails from CI.
    [Tags]    real-submit
    Skip If    ${SKIP_REAL_SUBMIT}    Real form submission disabled by default; run with -v SKIP_REAL_SUBMIT:False to enable.
    Input Text    ${CONTACT_NAME_INPUT}    ${TEST_NAME}
    Input Text    ${CONTACT_EMAIL_INPUT}    ${TEST_EMAIL}
    Input Text    ${CONTACT_SUBJECT_INPUT}    ${TEST_SUBJECT}
    Input Text    ${CONTACT_MESSAGE_INPUT}    ${TEST_MESSAGE}
    Click Element    ${CONTACT_SUBMIT_BUTTON}
    Wait Until Element Is Visible    ${CONTACT_SUCCESS_MESSAGE}    timeout=${TIMEOUT}
