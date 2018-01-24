<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:kml="http://www.opengis.net/kml/2.2"
               xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:output indent="yes" encoding="UTF-8"/>

    <xsl:variable name="prefix" select="'NAQ'"/>

    <xsl:template match="/">
        <PublicationDelivery xmlns="http://www.netex.org.uk/netex">
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
                        <xsl:for-each select="kml:kml/kml:Document/kml:Placemark">
                            <TopographicPlace version="1">
                                <xsl:attribute name="id">
                                    <xsl:value-of disable-output-escaping="yes"
                                                  select="concat($prefix, ':TopographicPlace:',kml:ExtendedData/kml:SchemaData/kml:SimpleData[@name='code_insee'])"/>
                                </xsl:attribute>
                                <Description>
                                    <xsl:value-of disable-output-escaping="yes" select="kml:ExtendedData/kml:SchemaData/kml:SimpleData[@name='nom']"/>
                                </Description>
                                <Descriptor>
                                    <Name>
                                    </Name>
                                </Descriptor>
                                <TopographicPlaceType>province</TopographicPlaceType>
                                <gml:Polygon xmlns:gml="http://www.opengis.net/gml/3.2" srsName="EPSG:4326" srsDimension="2">
                                    <xsl:attribute name="gml:id">
                                        <xsl:value-of disable-output-escaping="yes" select="concat($prefix, position())"/>
                                    </xsl:attribute>
                                    <gml:exterior>
                                        <gml:LinearRing>
                                            <gml:posList>
                                                <xsl:call-template name="polygon"/>
                                            </gml:posList>
                                        </gml:LinearRing>
                                    </gml:exterior>
                                </gml:Polygon>
                            </TopographicPlace>
                        </xsl:for-each>
                    </topographicPlaces>
                </SiteFrame>
            </dataObjects>
        </PublicationDelivery>
    </xsl:template>

    <xsl:template match="/kml:MultiGeometry/kml:Polygon/kml:outerBoundaryIs/kml:LinearRing/kml:coordinates" name="polygon">
        <xsl:for-each select="kml:Polygon/kml:outerBoundaryIs/kml:LinearRing/kml:coordinates">
            <xsl:value-of disable-output-escaping="yes"
                          select="fn:replace(., '(-?\d+\.?[0-9]+([eE][-+]?[0-9]+)?),(-?\d+\.?[0-9]+([eE][-+]?[0-9]+)?)\s*', '$3 $1 ')"/>
        </xsl:for-each>
    </xsl:template>
</xsl:transform>
