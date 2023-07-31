<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar" >
            <a class="skip-link screen-reader-text sr-only" href="#content">Skip to content</a>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container" >
                    <!-- Your site title as branding in the menu -->
                    <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url"><img src="{$project_logo}" class="img-fluid" title="{$project_short_title}" alt="{$project_short_title}" itemprop="logo" /></a><!-- end custom logo -->
                    <a class="navbar-brand site-title-with-logo" rel="home" href="index.html" title="{$project_short_title}" itemprop="url"><xsl:value-of select="$project_short_title"/></a>
                    <span style="margin-left:-1.7em;" class="badge bg-light text-dark">in development</span>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                        <!-- Your menu goes here -->
                        <ul id="main-menu" class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a title="Papers" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle" data-i18n="navbar__project"><span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a href="projekt.html" class="nav-link" data-i18n="navbar__about"></a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a href="ueberlieferung.html" class="nav-link" data-i18n="navbar__tradition"></a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a href="chiffre.html" class="nav-link" data-i18n="navbar__cipher"></a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a href="richtlinien.html" class="nav-link" data-i18n="navbar__edition"></a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a href="rss.html" class="nav-link" data-i18n="navbar__blog"></a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a href="https://github.com/emt-project/emt-static/" class="nav-link" data-i18n="navbar__sourcecode"></a>
                                    </li>
                                </ul>                                
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="calendar.html" data-i18n="navbar__calendar"></a>
                            </li>
                            <li class="nav-item"><a title="Briefverzeichnis" href="toc.html" class="nav-link" data-i18n="navbar__letterindex"></a></li>
                            <li class="nav-item dropdown">
                                <a title="Indexes" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle" data-i18n="navbar__register"><span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Personen" href="listperson.html" class="nav-link" data-i18n="navbar__persons"></a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Orte" href="listplace.html" class="nav-link" data-i18n="navbar__places"></a>
                                    </li>
                                </ul>                               
                            </li>
                        </ul>                        
                        <a title="Suche" href="search.html" class="nav-link" data-i18n="navbar__search"></a>
                        <select name="language" id="languageSwitcher"></select>
                    </div>
                    <!-- .collapse navbar-collapse -->
                </div>
                <!-- .container -->
            </nav>
            <!-- .site-navigation -->
        </div>
    </xsl:template>
</xsl:stylesheet>