<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" encoding="UTF-8"/>

    <xsl:variable name="prefix" select="'NAQ'"/>

    <xsl:template match="/">
        <PublicationDelivery>

            <PublicationTimestamp>
                <xsl:value-of select="current-dateTime()"/>
            </PublicationTimestamp>
            <ParticipantRef>
                <xsl:value-of select="$prefix"/>
            </ParticipantRef>

            <dataObjects>
                <SiteFrame version="1">
                    <xsl:attribute name="id">
                        <xsl:value-of disable-output-escaping="yes" select="concat($prefix, ':SiteFrame:1')"/>
                    </xsl:attribute>
                    <FrameDefaults>
                        <DefaultLocale>
                            <TimeZone>Europe/Paris</TimeZone>
                            <DefaultLanguage>fr</DefaultLanguage>
                        </DefaultLocale>
                    </FrameDefaults>
                    <topographicPlaces>
                        <xsl:for-each-group select="/*:PublicationDelivery/*:dataObjects/*:SiteFrame/*:topographicPlaces/*:TopographicPlace"
                                            group-by="concat(@id,'|',@version)">
                            <xsl:sequence select="."/>
                        </xsl:for-each-group>
                    </topographicPlaces>
                </SiteFrame>
            </dataObjects>
        </PublicationDelivery>
    </xsl:template>
</xsl:transform>