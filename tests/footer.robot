*** Settings ***
Documentation    Verifies footer content and secondary navigation render on
...              the homepage.
Resource         ../resources/common.resource
Suite Setup      Open GNSS Decoded Browser
Suite Teardown   Close GNSS Decoded Browser
Test Setup       Go To Page    ${PATH_HOME}
Test Teardown    Capture Failure Screenshot
Test Tags        footer    regression


*** Test Cases ***
Footer Displays Copyright Notice
    [Documentation]    The footer shows the current copyright line.
    Scroll Element Into View    ${FOOTER_COPYRIGHT}
    Element Should Be Visible    ${FOOTER_COPYRIGHT}
    Element Should Contain    ${FOOTER_COPYRIGHT}    GNSS Decoded - Built by Muneeb

Footer Displays Secondary Category Navigation
    [Documentation]    The repeated category links at the page bottom render
    ...    and point to the correct pages.
    Scroll Element Into View    ${NAV_ALL_ARTICLES_LINK}
    Page Should Contain Element    ${NAV_ALL_ARTICLES_LINK}
    Page Should Contain Element    ${NAV_FUNDAMENTALS_LINK}
    Page Should Contain Element    ${NAV_ERRORS_LINK}
    Page Should Contain Element    ${NAV_POSITIONING_LINK}
    Page Should Contain Element    ${NAV_ADVANCEMENT_LINK}
    Page Should Contain Element    ${NAV_EDUCATIONAL_LINK}
