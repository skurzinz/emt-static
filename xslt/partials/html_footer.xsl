<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl xs"
    version="2.0">
    <xsl:template match="/" name="html_footer">
        
        <div class="wrapper fundament-default-footer" id="wrapper-footer-full" style="margin-top: 4em;">
            <div class="container" id="footer-full-content" tabindex="-1">
                <div class="footer-separator">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-message-circle">
                        <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/>
                    </svg> KONTAKT
                </div>
                <div class="row justify-content-md-center" style="text-align:center; padding:2em;">
                    <div class="col" style="text-align:left;">
                        <p>
                            Austrian Acadamy of Sciences<br/>
                            Institute for Habsburg and Balkan Studies<br/>
                            <br/>       
                            Hollandstraße 11-13<br/>
                            1020 Vienna (Austria)<br/>
                            Apostelgasse 23<br/>
                            1030 Vienna (Austria)
                        </p>
                    </div>
                    <div class="col">
                        <a href="https://www.oeaw.ac.at/ihb/" target="_blank" rel="noopener" aria-label="IHB">
                            <img src="img/ihb-logo-en-text.png" alt="IHB" title="Institut for Habsburg and Balkan Studies"/>
                        </a>
                    </div>
                    <div class="col">
                        <a href="https://www.fwf.ac.at/" target="_blank" rel="noopener" aria-label="FWF">
                            <img src="img/fwf-logo-transparent.png" alt="FWF" title="FWF Science-Fond"/>
                        </a>
                    </div>
                    <div class="col">
                        <a href="https://www.oeaw.ac.at/" target="_blank" rel="noopener" aria-label="OEAW">
                            <img src="img/oeaw-logo-transparent.png" alt="OEAW" title="Austrian Academy of Sciences"/>
                        </a>
                    </div>
                    <div class="col">
                        <a href="https://www.oeaw.ac.at/acdh/" target="_blank" rel="noopener" aria-label="ACDH">
                            <img src="https://shared.acdh.oeaw.ac.at/acdh-common-assets/images/acdh_logo_with_text.svg" alt="ACDH" title="Austrian Centre for Digital Humanities and Cultural Heritage (ACDH-CH) of the Austrian Academy of Sciences"/>
                        </a>                            
                    </div>
                </div>
            </div>
        </div>
        <!-- #wrapper-footer-full -->
        <div class="footer-imprint-bar" id="wrapper-footer-secondary" style="text-align:center; padding:0.4rem 0; font-size: 0.9rem;" >
            <a href="imprint.html">Impressum/Imprint</a>
        </div>
        <script type="text/javascript" src="dist/fundament/vendor/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="dist/fundament/js/fundament.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
        <script type="text/javascript" src="js/dt.js"></script>
    </xsl:template>
</xsl:stylesheet>