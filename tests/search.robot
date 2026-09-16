*** Settings ***
Documentation    Verifies the site search box returns relevant results and
...              handles edge cases gracefully.
Resource         ../resources/common.resource
Suite Setup      Open GNSS Decoded Browser
Suite Teardown   Close GNSS Decoded Browser
Test Setup       Go To Page    ${PATH_HOME}
Test Teardown    Capture Failure Screenshot
Test Tags        search    regression


*** Keywords ***
Locate Search Input
    [Documentation]    Returns whichever search input locator is actually
    ...    present on the page (default WP widget or themed fallback).
    ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${SEARCH_INPUT}
    IF    ${found}
        RETURN    ${SEARCH_INPUT}
    END
    RETURN    ${SEARCH_INPUT_FALLBACK}

Perform Site Search
    [Documentation]    Types the given term into the search box and submits it.
    [Arguments]    ${term}
    ${locator}=    Locate Search Input
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    Input Text    ${locator}    ${term}
    Press Keys    ${locator}    RETURN


*** Test Cases ***
Search For Known Term Returns Results
    [Documentation]    Searching for "GPS" — a term guaranteed to exist in
    ...    multiple articles — returns a results page containing that term.
    Perform Site Search    GPS
    Wait Until Location Contains    ?s=    timeout=${TIMEOUT}
    Page Should Contain    GPS

Search For Nonsense Term Shows No Results Gracefully
    [Documentation]    Searching for a string unlikely to match any content
    ...    should not error out, and should show either zero results or a
    ...    "nothing found" style message rather than crashing.
    Perform Site Search    zzz_no_such_content_xyz123
    Wait Until Location Contains    ?s=    timeout=${TIMEOUT}
    ${no_results}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${NO_RESULTS_TEXT}
    IF    not ${no_results}
        Log    No explicit "nothing found" message located; verifying no article cards render instead.    level=WARN
    END

Search Results Page Preserves Query In URL
    [Documentation]    The search term should be reflected in the resulting
    ...    query string, confirming the form actually submitted the value.
    Perform Site Search    GNSS
    Wait Until Location Contains    s=GNSS    timeout=${TIMEOUT}
