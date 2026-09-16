*** Settings ***
Documentation    Verifies the GNSS Decoded homepage loads correctly and its
...              key structural sections render as expected.
Resource         ../resources/common.resource
Suite Setup      Open GNSS Decoded Browser
Suite Teardown   Close GNSS Decoded Browser
Test Teardown    Capture Failure Screenshot
Test Tags        smoke    regression


*** Test Cases ***
Homepage Loads Successfully
    [Documentation]    The homepage responds and renders the expected <title>.
    Go To Page    ${PATH_HOME}
    Title Should Be    ${EXPECTED_SITE_TITLE}
    Location Should Be    ${BASE_URL}${PATH_HOME}

Homepage Displays Site Branding
    [Documentation]    The header shows the "GNSS Decoded" brand/logo link.
    Go To Page    ${PATH_HOME}
    Page Should Contain Element    ${LOGO_LINK}
    Page Should Contain    Space and Beyond

Homepage Displays Hero Section
    [Documentation]    The hero heading and both call-to-action links render.
    Go To Page    ${PATH_HOME}
    Wait Until Element Is Visible    ${HERO_HEADING}    timeout=${TIMEOUT}
    Element Should Contain    ${HERO_HEADING}    Your Complete GNSS & Satellite Knowledge Hub
    Page Should Contain Element    ${HERO_CTA_WHAT_IS_GNSS}
    Page Should Contain Element    ${HERO_CTA_EXPLORE_TOPICS}

Homepage Displays Latest Articles Section
    [Documentation]    The "Latest Articles" section is present with at least
    ...    one article link.
    Go To Page    ${PATH_HOME}
    Wait Until Element Is Visible    ${LATEST_ARTICLES_HEADING}    timeout=${TIMEOUT}
    Page Should Contain Element    xpath://a[contains(@href,"gnssdecoded.com/") and .//h2]

Homepage Displays Free Tools Section
    [Documentation]    The "Free GNSS Tools & Calculators" section is present
    ...    with links to each tool.
    Go To Page    ${PATH_HOME}
    Wait Until Element Is Visible    ${TOOLS_SECTION_HEADING}    timeout=${TIMEOUT}
    Page Should Contain Element    ${NAV_GPS_TIME_CONVERTER_LINK}
    Page Should Contain Element    ${NAV_ECEF_LLA_LINK}
    Page Should Contain Element    ${NAV_GNSS_CALENDAR_LINK}

Homepage Displays ISS Tracker Call To Action
    [Documentation]    The ISS live tracker teaser section links to the
    ...    dedicated tracker page.
    Go To Page    ${PATH_HOME}
    Wait Until Element Is Visible    ${ISS_TRACKER_CTA}    timeout=${TIMEOUT}
    Element Attribute Value Should Be    ${ISS_TRACKER_CTA}    href    ${BASE_URL}${PATH_ISS_TRACKER}

Homepage Displays Top Guides Section
    [Documentation]    The "Read Top Guides" section renders with article cards.
    Go To Page    ${PATH_HOME}
    Wait Until Element Is Visible    ${TOP_GUIDES_HEADING}    timeout=${TIMEOUT}

Homepage Displays Contribute Call To Action
    [Documentation]    The "Want to Contribute?" section links to the contact page.
    Go To Page    ${PATH_HOME}
    Wait Until Element Is Visible    ${CONTRIBUTE_CTA}    timeout=${TIMEOUT}
    Element Attribute Value Should Be    ${CONTRIBUTE_CTA}    href    ${BASE_URL}${PATH_CONTACT}
