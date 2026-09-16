*** Settings ***
Documentation    Centralised element locators. Keep every selector here so a
...              markup change only needs to be fixed in one place.
...              Text-based / link-based locators are preferred over brittle
...              auto-generated CSS classes wherever the site's HTML wasn't
...              directly inspectable at authoring time — verify against the
...              live DOM and tighten these if needed.


*** Variables ***
# --- Header / branding -------------------------------------------------
${LOGO_LINK}                 css:a[href="https://gnssdecoded.com/"]
${SITE_TITLE_TEXT}           xpath://*[contains(text(),"Space and Beyond")]

# --- Top navigation ------------------------------------------------------
${NAV_TOOLS_MENU}             xpath://a[contains(normalize-space(.),"Tools")]
${NAV_ISS_TRACKER_LINK}       xpath://a[contains(@href,"iss-tracker")]
${NAV_GNSS_CALENDAR_LINK}     xpath://a[contains(@href,"gnss-calendar")]
${NAV_GPS_TIME_CONVERTER_LINK}    xpath://a[contains(@href,"gps-time-converter")]
${NAV_ECEF_LLA_LINK}          xpath://a[contains(@href,"ecef-lla-enu-conversion-tool")]
${NAV_QA_LINK}                xpath://a[contains(@href,"gnss-interview-questions")]
${NAV_GLOSSARY_LINK}          xpath://a[contains(@href,"satellite-gnss-glossary")]
${NAV_CONTACT_LINK}           xpath://a[contains(@href,"/contact")]
${NAV_ALL_ARTICLES_LINK}      xpath://a[contains(@href,"all-articles")]

# --- Category nav bar (second row) --------------------------------------
${NAV_FUNDAMENTALS_LINK}      xpath://a[contains(@href,"gnss-fundamentals")]
${NAV_ERRORS_LINK}            xpath://a[contains(@href,"gnss-errors-and-interference")]
${NAV_POSITIONING_LINK}       xpath://a[contains(@href,"gnss-positioning")]
${NAV_ADVANCEMENT_LINK}       xpath://a[contains(@href,"gnss-advancement")]
${NAV_EDUCATIONAL_LINK}       xpath://a[contains(@href,"/educational")]

# --- Search ---------------------------------------------------------------
# WordPress default search widget commonly uses name="s"; fall back to a
# placeholder-based match if a custom theme search box is used instead.
${SEARCH_INPUT}               css:input[name="s"]
${SEARCH_INPUT_FALLBACK}      xpath://input[contains(@placeholder,"Search")]
${SEARCH_SUBMIT_BUTTON}       css:button[type="submit"]
${SEARCH_RESULTS_HEADING}     xpath://*[contains(text(),"Search Results") or contains(text(),"Search results")]
${NO_RESULTS_TEXT}            xpath://*[contains(text(),"Nothing Found") or contains(text(),"No results")]

# --- Homepage sections ------------------------------------------------
${HERO_HEADING}               xpath://h1[contains(text(),"Your Complete GNSS")]
${HERO_CTA_WHAT_IS_GNSS}      xpath://a[contains(@href,"what-is-gnss") and contains(text(),"What is GNSS")]
${HERO_CTA_EXPLORE_TOPICS}    xpath://a[contains(text(),"Explore All Topics")]
${LATEST_ARTICLES_HEADING}    xpath://*[contains(text(),"Latest Articles")]
${TOOLS_SECTION_HEADING}      xpath://*[contains(text(),"Free GNSS Tools")]
${ISS_TRACKER_CTA}            xpath://a[contains(text(),"View Live Tracking")]
${TOP_GUIDES_HEADING}         xpath://*[contains(text(),"Read Top Guides")]
${CONTRIBUTE_CTA}             xpath://a[contains(text(),"Write to Us")]

# --- Contact form (Contact Form 7 field-name conventions) ----------------
${CONTACT_HEADING}            xpath://*[contains(text(),"Contact GNSSDecoded")]
${CONTACT_NAME_INPUT}         css:input[name="your-name"]
${CONTACT_EMAIL_INPUT}        css:input[name="your-email"]
${CONTACT_SUBJECT_INPUT}      css:input[name="your-subject"]
${CONTACT_MESSAGE_INPUT}      css:textarea[name="your-message"]
${CONTACT_SUBMIT_BUTTON}      css:input[type="submit"]
${CONTACT_FORM}                css:form.wpcf7-form
${CONTACT_SUCCESS_MESSAGE}    css:.wpcf7-mail-sent-ok
${CONTACT_VALIDATION_ERROR}   css:.wpcf7-not-valid-tip

# --- Footer ----------------------------------------------------------------
${FOOTER_COPYRIGHT}           xpath://*[contains(text(),"GNSS Decoded - Built by Muneeb")]
${FOOTER_LOGIN_USERNAME}      css:input#user_login
${FOOTER_LOGIN_PASSWORD}      css:input#user_pass
