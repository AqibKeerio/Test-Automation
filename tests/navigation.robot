*** Settings ***
Documentation    Verifies primary navigation links take the user to the
...              correct destination pages.
Resource         ../resources/common.resource
Suite Setup      Open GNSS Decoded Browser
Suite Teardown   Close GNSS Decoded Browser
Test Setup       Go To Page    ${PATH_HOME}
Test Teardown    Capture Failure Screenshot
Test Tags        navigation    regression


*** Test Cases ***
Navigate To ISS Tracker Via Tools Menu
    [Documentation]    "Tools > ISS Tracker" navigates to the ISS tracker page.
    Click Link And Verify Url Contains    ${NAV_ISS_TRACKER_LINK}    iss-tracker

Navigate To GNSS Calendar Via Tools Menu
    [Documentation]    "Tools > GNSS Calendar 2026" navigates to the calendar page.
    Click Link And Verify Url Contains    ${NAV_GNSS_CALENDAR_LINK}    gnss-calendar

Navigate To GPS Time Converter Via Tools Menu
    [Documentation]    "Tools > GPS Time Converter" navigates to the converter page.
    Click Link And Verify Url Contains    ${NAV_GPS_TIME_CONVERTER_LINK}    gps-time-converter

Navigate To LLA To ECEF Tool Via Tools Menu
    [Documentation]    "Tools > LLA to ECEF Conversion Tool" navigates correctly.
    Click Link And Verify Url Contains    ${NAV_ECEF_LLA_LINK}    ecef-lla-enu-conversion-tool

Navigate To GNSS Questions And Answers
    [Documentation]    Top-level "GNSS Questions and Answers" link works.
    Click Link And Verify Url Contains    ${NAV_QA_LINK}    gnss-interview-questions

Navigate To GNSS Glossary
    [Documentation]    Top-level "GNSS Glossary" link works.
    Click Link And Verify Url Contains    ${NAV_GLOSSARY_LINK}    satellite-gnss-glossary

Navigate To Contact Page
    [Documentation]    Top-level "Contact" link works.
    Click Link And Verify Url Contains    ${NAV_CONTACT_LINK}    /contact

Navigate To All Articles
    [Documentation]    "All Articles" link in the category bar works.
    Click Link And Verify Url Contains    ${NAV_ALL_ARTICLES_LINK}    all-articles

Navigate To GNSS Fundamentals Category
    [Documentation]    "GNSS Fundamentals" category link works.
    Click Link And Verify Url Contains    ${NAV_FUNDAMENTALS_LINK}    gnss-fundamentals

Navigate To Errors And Interference Category
    [Documentation]    "Errors & Interference" category link works.
    Click Link And Verify Url Contains    ${NAV_ERRORS_LINK}    gnss-errors-and-interference

Navigate To Positioning Category
    [Documentation]    "Positioning" category link works.
    Click Link And Verify Url Contains    ${NAV_POSITIONING_LINK}    gnss-positioning

Navigate To GNSS Advancement Category
    [Documentation]    "GNSS Advancement" category link works.
    Click Link And Verify Url Contains    ${NAV_ADVANCEMENT_LINK}    gnss-advancement

Navigate To Educational Category
    [Documentation]    "Educational" category link works.
    Click Link And Verify Url Contains    ${NAV_EDUCATIONAL_LINK}    educational

Logo Navigates Back To Homepage
    [Documentation]    Clicking the site logo/title from a sub-page returns
    ...    the user to the homepage.
    Go To Page    ${PATH_CONTACT}
    Click Element    ${LOGO_LINK}
    Wait Until Location Is    ${BASE_URL}${PATH_HOME}    timeout=${TIMEOUT}
