*** Settings ***
Documentation    Smoke-checks each of the free GNSS tool pages loads without
...              error and renders its expected page title/heading.
Resource         ../resources/common.resource
Suite Setup      Open GNSS Decoded Browser
Suite Teardown   Close GNSS Decoded Browser
Test Teardown    Capture Failure Screenshot
Test Tags        tools    regression


*** Test Cases ***
ISS Tracker Page Loads
    [Documentation]    The ISS Live Tracker page loads and mentions the ISS.
    Go To Page    ${PATH_ISS_TRACKER}
    Location Should Contain    iss-tracker
    Page Should Contain    ISS

GNSS Calendar Page Loads
    [Documentation]    The GNSS Calendar 2026 page loads correctly.
    Go To Page    ${PATH_GNSS_CALENDAR}
    Location Should Contain    gnss-calendar
    Page Should Contain    Calendar

GPS Time Converter Page Loads
    [Documentation]    The GPS Time Converter tool page loads correctly.
    Go To Page    ${PATH_GPS_TIME_CONVERTER}
    Location Should Contain    gps-time-converter
    Page Should Contain    GPS Time Converter

LLA To ECEF Conversion Tool Page Loads
    [Documentation]    The LLA/ECEF/ENU conversion tool page loads correctly.
    Go To Page    ${PATH_ECEF_LLA_TOOL}
    Location Should Contain    ecef-lla-enu-conversion-tool
    Page Should Contain    Conversion

GNSS Questions And Answers Page Loads
    [Documentation]    The GNSS Q&A hub page loads correctly.
    Go To Page    ${PATH_QA}
    Location Should Contain    gnss-interview-questions
    Page Should Contain    GNSS

GNSS Glossary Page Loads
    [Documentation]    The GNSS glossary page loads correctly.
    Go To Page    ${PATH_GLOSSARY}
    Location Should Contain    satellite-gnss-glossary
    Page Should Contain    Glossary

All Tool Pages Return A Successful Page Load
    [Documentation]    Data-driven check that iterates every tool path and
    ...    confirms the page body renders (basic HTTP/rendering smoke test).
    FOR    ${path}    IN
    ...    ${PATH_ISS_TRACKER}
    ...    ${PATH_GNSS_CALENDAR}
    ...    ${PATH_GPS_TIME_CONVERTER}
    ...    ${PATH_ECEF_LLA_TOOL}
        Go To Page    ${path}
        Wait Until Page Contains Element    tag:body    timeout=${TIMEOUT}
        ${current_url}=    Get Location
        Should Not Contain    ${current_url}    404
    END
