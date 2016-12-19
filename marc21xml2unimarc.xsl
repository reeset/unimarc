<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim" version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="marc">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<collection>
			<xsl:for-each select="marc:collection">
				<xsl:for-each select="marc:record">
					<record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
						xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/ standards/marcxml/schema/MARC21slim.xsd"
						xmlns="http://www.loc.gov/MARC21/slim">
						<xsl:for-each select="marc:leader">
							<leader>
								<!-- To calculate, but how? -->
								<xsl:variable name="recordLenght">00000</xsl:variable>
								<xsl:variable name="recordStatus">
									<xsl:choose>
										<xsl:when test="substring(text(), 6, 1) = 'a'">c</xsl:when>
										<xsl:when test="substring(text(), 6, 1) = 'p'">c</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="substring(text(), 6, 1)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="recordType">
									<xsl:choose>
										<xsl:when test="substring(text(), 7, 1) = 'o'">m</xsl:when>
										<xsl:when test="substring(text(), 7, 1) = 'p'">m</xsl:when>
										<xsl:when test="substring(text(), 7, 1) = 't'">b</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="substring(text(), 7, 1)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="bibLvl">
									<xsl:choose>
										<xsl:when test="substring(text(), 8, 1) = 'b'">a</xsl:when>
										<xsl:when test="substring(text(), 8, 1) = 'd'">a</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="substring(text(), 8, 1)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="controlType">
									<xsl:value-of select="substring(text(), 9, 1)"/>
								</xsl:variable>
								<!-- To calculate, but how? -->
								<xsl:variable name="baod">02200</xsl:variable>
								<xsl:variable name="encLvl">
									<xsl:choose>
										<xsl:when test="substring(text(), 18, 1) = '8'">2</xsl:when>
										<xsl:when test="substring(text(), 18, 1) = '5'">3</xsl:when>
										<xsl:when test="substring(text(), 18, 1) = '7'">3</xsl:when>
										<xsl:when test="substring(text(), 18, 1) = '2'">1</xsl:when>
										<xsl:when test="substring(text(), 18, 1) = '3'">1</xsl:when>
										<xsl:when test="substring(text(), 18, 1) = '4'">1</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="substring(text(), 18, 1)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="dcf">
									<xsl:choose>
										<xsl:when test="substring(text(), 19, 1) = ' '">n</xsl:when>
										<xsl:when test="substring(text(), 19, 1) = 'c'"> </xsl:when>
										<xsl:when test="substring(text(), 19, 1) = 'u'">i</xsl:when>
										<xsl:when test="substring(text(), 19, 1) = 'a'">n</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="' '"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:value-of
									select="concat($recordLenght, $recordStatus, $recordType, $bibLvl, ' ', $controlType, '22', $baod, $encLvl, $dcf, ' 450 ')"
								/>
							</leader>
						</xsl:for-each>
						<xsl:for-each select="marc:controlfield[@tag = '001']">
							<controlfield tag="001">
								<xsl:value-of select="text()"/>
							</controlfield>
						</xsl:for-each>
						<xsl:for-each select="marc:controlfield[@tag = '005']">
							<controlfield tag="005">
								<xsl:value-of select="text()"/>
							</controlfield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '020']">
							<datafield tag="010">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<!-- this code code removes all non-numeric characters -->
										<xsl:value-of select="translate(text(),translate(text(),'0123456789-',''),'')"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="z">
										<xsl:value-of select="translate(text(),translate(text(),'0123456789-',''),'')"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '022']">
							<datafield tag="011">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='?']"><subfield code="b"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='?']"><subfield code="d"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='z']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
							</datafield>
						</xsl:for-each>
						<!--<xsl:for-each select="marc:datafield[@tag='024']">
					<datafield tag="012">
						<xsl:attribute name="ind1"><xsl:value-of select="@ind1" /></xsl:attribute>
						<xsl:attribute name="ind2"><xsl:value-of select="@ind2" /></xsl:attribute>
						<xsl:for-each select="marc:subfield[@code='a']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>
						<xsl:for-each select="marc:subfield[@code='b']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>
						<xsl:for-each select="marc:subfield[@code='z']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>
					</datafield>
				</xsl:for-each>-->
						<xsl:for-each select="marc:datafield[@tag = '015']">
							<datafield tag="020">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '017']">
							<datafield tag="021">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '086']">
							<datafield tag="022">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '030']">
							<datafield tag="040">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '028']">
							<datafield tag="071">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:choose>
										<xsl:when test="@ind2 = 0">0</xsl:when>
										<xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:controlfield[@tag = '008']">
							<!-- FIXME: Dummy indicators -->
							<datafield tag="100">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<subfield code="a">
									<xsl:variable name="deof">
										<xsl:choose>
											<xsl:when test="substring(text(), 1, 2) &lt; 70">
												<xsl:value-of
												select="concat('20', substring(text(), 1, 6))"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of
												select="concat('19', substring(text(), 1, 6))"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="typeofPubDate">
										<xsl:choose>
											<xsl:when test="substring(text(), 7, 1) = 'c'">a</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'd'">b</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'u'">c</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 's'">d</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'r'">e</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'q'">f</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'm'">g</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 't'">h</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'p'">i</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'e'">j</xsl:when>
											<xsl:when test="substring(text(), 7, 1) = 'b'">u</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="' '"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="d1" select="substring(text(), 8, 4)"/>
									<xsl:variable name="d2" select="substring(text(), 12, 4)"/>
									<xsl:variable name="targetAudience">
										<xsl:choose>
											<xsl:when test="substring(text(), 23, 1) = 'a'">b||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = 'b'">c||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = 'j'">a||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = 'c'">d||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = 'd'">e||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = 'e'">k||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = 'g'">m||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = '|'">|||</xsl:when>
											<xsl:when test="substring(text(), 23, 1) = ' '">u||</xsl:when>
											<xsl:otherwise>u||</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="governmentPublication">
										<xsl:choose>
											<xsl:when test="substring(text(), 29, 1) = 'f'">a</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 's'">b</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'l'">d</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'c'">e</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'i'">f</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'z'">g</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'o'">h</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'u'">u</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = ' '">y</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = 'z'">z</xsl:when>
											<xsl:when test="substring(text(), 29, 1) = '|'">|</xsl:when>
											<xsl:otherwise>y</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="mrc">
										<xsl:choose>
											<xsl:when test="substring(text(), 39, 1) = ' '">0</xsl:when>
											<xsl:otherwise>1</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="loc">
										<xsl:choose>
											<xsl:when
												test="datafield[@tag = '040']/subfield[@code = 'b']">
												<xsl:value-of
												select="marc:datafield[@tag = '040']/subfield[@code = 'b']"
												/>
											</xsl:when>
											<xsl:otherwise>
												<!-- Expected default for MARC21 -->
												<xsl:value-of select="'eng'"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="tc">
										<xsl:choose>
											<xsl:when test="substring(text(), 39, 1) = 'o'"
												>b</xsl:when>
											<xsl:otherwise>y</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="coding">
										<xsl:choose>
											<xsl:when test="substring(../marc:leader, 10, 1) = 'a'">50  </xsl:when>
											<!-- what if MARC-8 encoding, and not UTF8? -->
											<xsl:otherwise>
												<xsl:value-of select="'    '"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="acs">
										<xsl:value-of select="'    '"/>
									</xsl:variable>
									<xsl:variable name="aot" select="substring(text(), 34, 1)"/>
									<xsl:value-of
										select="concat($deof, $typeofPubDate, $d1, $d2, $targetAudience, $governmentPublication, $mrc, $loc, $tc, $coding, $acs, $aot)"
									/>
								</subfield>
							</datafield>
							<datafield tag="105">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<subfield code="a">
									<xsl:variable name="ic">
										<xsl:value-of select="substring(text(), 19, 4)"/>
									</xsl:variable>
									<xsl:variable name="focc">
										<xsl:value-of select="translate (substring(text(), 25, 4), 'bciaderyspltnwfgv', 
																								   'abcdefghijnprnzzz')"/>
									</xsl:variable>
									<xsl:variable name="cc">
										<xsl:value-of select="substring(text(), 30, 1)"/>
									</xsl:variable>
									<xsl:variable name="fi">
										<xsl:value-of select="substring(text(), 31, 1)"/>
									</xsl:variable>
									<xsl:variable name="ii">
										<xsl:value-of select="substring(text(), 32, 1)"/>
									</xsl:variable>
									<xsl:variable name="lc">
										<xsl:choose>
											<xsl:when test="substring(text(), 34, 1) = '1'"
												>a</xsl:when>
											<xsl:otherwise>|</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="bc">
										<xsl:choose>
											<xsl:when test="substring(text(), 35, 1) = ' '"
												>y</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="substring(text(), 35, 1)"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:value-of
										select="concat($ic, $focc, $cc, $fi, $ii, $lc, $bc)"/>
								</subfield>
							</datafield>
							<datafield tag="106">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<subfield code="a">
									<xsl:choose>
										<xsl:when test="substring(text(), 24, 1) = ' '">y</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="substring(text(), 24, 1)"/>
										</xsl:otherwise>
									</xsl:choose>
								</subfield>
							</datafield>
							<xsl:choose>
								<xsl:when test="substring(../marc:leader, 8, 1) = 's'">
									<datafield tag="110">
										<xsl:attribute name="ind1">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<xsl:attribute name="ind2">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<subfield code="a">
											<xsl:variable name="tos">
												<xsl:choose>
													<xsl:when test="substring(text(), 22, 1) = 'p'"
														>a</xsl:when>
													<xsl:when test="substring(text(), 22, 1) = 'm'"
														>b</xsl:when>
													<xsl:when test="substring(text(), 22, 1) = 'n'"
														>c</xsl:when>
													<xsl:when test="substring(text(), 22, 1) = ' '"
														>z</xsl:when>
													<xsl:when test="substring(text(), 22, 1) = '|'"
														>|</xsl:when>
													<xsl:otherwise>z</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="foi">
												<xsl:choose>
													<xsl:when test="substring(text(), 19, 1) = 'd'"
														>a</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'c'"
														>b</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'w'"
														>c</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'e'"
														>d</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 's'"
														>e</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'm'"
														>f</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'b'"
														>g</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'q'"
														>h</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 't'"
														>i</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'f'"
														>j</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'a'"
														>k</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'g'"
														>l</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'h'"
														>m</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'i'"
														>n</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'j'"
														>o</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'u'"
														>u</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = ' '"
														>y</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'z'"
														>z</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = '|'"
														>|</xsl:when>
													<xsl:when test="substring(text(), 19, 1) = 'n'"
														>|</xsl:when>
													<xsl:otherwise>y</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="r">
												<xsl:choose>
													<xsl:when test="substring(text(), 20, 1) = 'r'"
														>a</xsl:when>
													<xsl:when test="substring(text(), 20, 1) = 'n'"
														>b</xsl:when>
													<xsl:when test="substring(text(), 20, 1) = 'u'"
														>u</xsl:when>
													<xsl:when test="substring(text(), 20, 1) = 'x'"
														>y</xsl:when>
													<xsl:when test="substring(text(), 20, 1) = '|'"
														>|</xsl:when>
													<xsl:when test="substring(text(), 20, 1) = ' '"
														>|</xsl:when>
													<xsl:otherwise>u</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="tomc">
												<xsl:choose>
													<xsl:when test="substring(text(), 25, 1) = 'b'"
														>a</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'c'"
														>b</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'i'"
														>c</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'a'"
														>d</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'd'"
														>e</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'e'"
														>f</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'r'"
														>g</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'y'"
														>h</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 's'"
														>i</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'p'"
														>j</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'o'"
														>k</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'l'"
														>l</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'w'"
														>m</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'g'"
														>n</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'v'"
														>o</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'h'"
														>p</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = 'n'"
														>r</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = ' '"
														>z</xsl:when>
													<xsl:when test="substring(text(), 25, 1) = '|'"
														>|</xsl:when>
													<xsl:otherwise>z</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="nocc">
												<xsl:value-of select="substring(text(), 26, 3)"/>
											</xsl:variable>
											<xsl:variable name="ci">
												<xsl:value-of select="substring(text(), 30, 1)"/>
											</xsl:variable>
											<xsl:variable name="tpa">|</xsl:variable>
											<xsl:variable name="iac">|</xsl:variable>
											<xsl:variable name="cia">|</xsl:variable>
											<xsl:value-of
												select="concat($tos, $foi, $r, $tomc, $nocc, $ci, $tpa, $iac, $cia)"
											/>
										</subfield>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '041']">
							<datafield tag="101">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'h']">
									<subfield code="c">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '044']">
							<datafield tag="102">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='b']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '245']">
							<datafield tag="200">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
									<xsl:if test="contains(text(), ' = ')">
										<subfield code="d">
											<xsl:value-of
												select="concat('=', substring-after(text(), ' ='))"
											/>
										</subfield>
									</xsl:if>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<xsl:choose>
										<xsl:when test="contains(text(), ' ; ')">
											<subfield code="f">
												<xsl:value-of
												select="substring-before(text(), ' ; ')"/>
											</subfield>
											<xsl:call-template name="tokenizeSubfield">
												<xsl:with-param name="list" select="substring-after(text(), ' ; ')"/>
												<xsl:with-param name="delimiter" select="' ; '"/>
												<xsl:with-param name="code" select="'g'"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<subfield code="f">
												<xsl:call-template name="removeEndPuctuation">
													<xsl:with-param name="text" select="text()"/>
												</xsl:call-template>
											</subfield>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
							<!-- FIXME -->
							<!--
					<datafield tag="204">
						<xsl:attribute name="ind1"><xsl:value-of select="' '" /></xsl:attribute>
						<xsl:attribute name="ind2"><xsl:value-of select="' '" /></xsl:attribute>
						<xsl:for-each select="marc:subfield[@code='h']"><subfield code="a"><xsl:value-of select="text()" /></subfield></xsl:for-each>
					</datafield>
					-->
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '250']">
							<datafield tag="205">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '254']">
							<datafield tag="208">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '260']">
							<datafield tag="210">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="c">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="d">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="e">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="g">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '263']">
							<datafield tag="211">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '300']">
							<datafield tag="215">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="c">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="d">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="e">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '490']">
							<datafield tag="225">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'v']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '256']">
							<datafield tag="230">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '500']">
							<datafield tag="300">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '525']">
							<datafield tag="300">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '555']">
							<datafield tag="300">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '504']">
							<datafield tag="320">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '505']">
							<datafield tag="327">
								<!-- FIXME: Dummy indicators -->
								<!--<xsl:attribute name="ind1"><xsl:value-of select="@ind1" /></xsl:attribute>-->
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<!--<xsl:attribute name="ind2"><xsl:value-of select="@ind2" /></xsl:attribute>-->
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<subfield code="a">bla</subfield>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '502']">
							<datafield tag="328">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '520']">
							<datafield tag="330">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '524']">
							<datafield tag="332">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '521']">
							<datafield tag="333">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '500']">
							<xsl:choose>
								<xsl:when test="contains(marc:subfield[@code = 'a'], 'file')">
									<datafield tag="336">
										<xsl:attribute name="ind1">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<xsl:attribute name="ind2">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<xsl:for-each select="marc:subfield[@code = 'a']">
											<subfield code="a">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '538']">
							<datafield tag="337">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '037']">
							<datafield tag="345">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="c">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '760']">
							<datafield tag="410">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '762']">
							<datafield tag="411">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '770']">
							<datafield tag="421">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '772']">
							<datafield tag="422">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '777']">
							<datafield tag="423">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '780']">
							<datafield tag="430">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '785']">
							<datafield tag="440">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '775']">
							<datafield tag="451">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '776']">
							<datafield tag="452">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '767']">
							<datafield tag="453">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '765']">
							<datafield tag="454">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '787']">
							<datafield>
								<xsl:choose>
									<xsl:when
										test="contains(subfield[@code = 'i'], 'Reproduction of:')">
										<xsl:attribute name="tag">
											<xsl:value-of select="455" />
										</xsl:attribute>
									</xsl:when>
									<xsl:when
										test="contains(subfield[@code = 'i'], 'Reproduced as:')">
										<xsl:attribute name="tag">
											<xsl:value-of select="456" />
										</xsl:attribute>
									</xsl:when>
									<xsl:when
										test="contains(subfield[@code = 'i'], 'Item reviewed:')">
										<xsl:attribute name="tag">
											<xsl:value-of select="470" />
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="tag">
											<xsl:value-of select="488" />
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '774']">
							<datafield>
								<xsl:choose>
									<xsl:when test="subfield[@code = 'i']">
										<xsl:attribute name="tag">
											<xsl:value-of select="462" />
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="tag">
											<xsl:value-of select="461" />
										</xsl:attribute> 
									</xsl:otherwise>
								</xsl:choose>
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '773']">
							<datafield tag="463">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '774']">
							<datafield tag="464">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="translate(@ind1, '10', '01')"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'w']">
									<subfield code="3">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '130']">
							<datafield tag="500">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="1"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="n">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="k">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="n">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="j">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'l']">
									<subfield code="m">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'm']">
									<subfield code="r">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'o']">
									<subfield code="w">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'r']">
									<subfield code="u">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 's']">
									<subfield code="q">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '240']">
							<datafield tag="500">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="0"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="n">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="k">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="n">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="j">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'l']">
									<subfield code="m">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'm']">
									<subfield code="r">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'o']">
									<subfield code="w">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'r']">
									<subfield code="u">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 's']">
									<subfield code="q">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<!-- Tag 730 is not on UNIMARC to MARC 21 Conversion Specifications -->
						<xsl:for-each select="marc:datafield[@tag = '730']">
							<datafield tag="500">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="n">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="k">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="n">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="j">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'l']">
									<subfield code="m">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'm']">
									<subfield code="r">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'o']">
									<subfield code="w">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'r']">
									<subfield code="u">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 's']">
									<subfield code="q">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '243']">
							<datafield tag="501">
								<xsl:attribute name="ind1">1</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="k">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'l']">
									<subfield code="m">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '247']">
							<datafield tag="520">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="n">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="j">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '222']">
							<datafield tag="530">
								<xsl:attribute name="ind1">0</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '210']">
							<datafield tag="531">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '246']">
							<datafield tag="532">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">0</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '242']">
							<datafield tag="541">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '773']">
							<datafield tag="545">
								<xsl:attribute name="ind1">
									<xsl:choose>
										<xsl:when test="@ind1 = 0">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '600']">
							<xsl:choose>
								<xsl:when test="@ind1 != 3" >
									<datafield tag="600">
										<xsl:attribute name="ind1">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<xsl:attribute name="ind2">
											<xsl:choose>
												<xsl:when test="@ind1 = 0">0</xsl:when>
												<xsl:otherwise>1</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:call-template name="convertSubjectHeading">
											<xsl:with-param name="ind" select="@ind2"/>
										</xsl:call-template>
										<xsl:for-each select="marc:subfield[@code = 'a']">
											<xsl:choose>
												<xsl:when test="contains(text(), ', ')">
													<subfield code="a">
														<xsl:value-of select="substring-before(text(), ', ')"/>
													</subfield>
													<subfield code="b">
														<xsl:call-template name="removeEndPuctuation">
															<xsl:with-param name="text" select="substring-after(text(), ', ')"/>
														</xsl:call-template>
													</subfield>
												</xsl:when>
												<xsl:otherwise>
													<subfield code="a">
														<xsl:call-template name="removeEndPuctuation">
															<xsl:with-param name="text" select="text()"/>
														</xsl:call-template>
													</subfield>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'c']">
											<subfield code="c">
												<xsl:call-template name="removeEndPuctuation">
													<xsl:with-param name="text" select="text()"/>
												</xsl:call-template>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'b']">
											<subfield code="d">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'd']">
											<subfield code="f">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 't']">
											<subfield code="t">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'x']">
											<subfield code="x">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'z']">
											<subfield code="y">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'y']">
											<subfield code="z">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = '2']">
											<subfield code="2">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
									</datafield>
								</xsl:when>
								<xsl:when test="@ind1 = 3" >
									<datafield tag="602" ind1=" " ind2=" ">
										<xsl:for-each select="marc:subfield[@code = 'a']">
											<subfield code="a">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 't']">
											<subfield code="t">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'x']">
											<subfield code="x">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'z']">
											<subfield code="y">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'y']">
											<subfield code="z">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = '2']">
											<subfield code="2">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '610']">
							<datafield tag="601">
								<xsl:attribute name="ind1">
									<xsl:value-of select="0"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:call-template name="convertSubjectHeading">
									<xsl:with-param name="ind" select="@ind2"/>
								</xsl:call-template>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
									<subfield code="c">
										<xsl:value-of
											select="substring-before(substring-after(text(), '('), ')')"
										/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="f">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='f']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='g']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="j">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='l']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='m']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='o']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='p']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='r']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='s']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='t']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='u']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='?']"><subfield code="3"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '611']">
							<datafield tag="601">
								<xsl:attribute name="ind1">
									<xsl:value-of select="1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:call-template name="convertSubjectHeading">
									<xsl:with-param name="ind" select="@ind2"/>
								</xsl:call-template>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
									<subfield code="c">
										<xsl:value-of
											select="substring-before(substring-after(text(), '('), ')')"
										/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="f">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='f']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='g']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="j">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='l']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='p']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<!--<xsl:for-each select="marc:subfield[@code='s']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 't']">
									<subfield code="t">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='u']"><subfield code="?"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<!--<xsl:for-each select="marc:subfield[@code='?']"><subfield code="3"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '630']">
							<datafield tag="605" ind1=" " ind2=" ">
								<xsl:call-template name="convertSubjectHeading">
									<xsl:with-param name="ind" select="@ind2"/>
								</xsl:call-template>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="h">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'p']">
									<subfield code="i">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'f']">
									<subfield code="k">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'k']">
									<subfield code="l">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'l']">
									<subfield code="m">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'g']">
									<subfield code="n">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 's']">
									<subfield code="q">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'r']">
									<subfield code="r">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="s">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'o']">
									<subfield code="t">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'r']">
									<subfield code="u">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="2">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '650']">
							<datafield tag="606" ind1=" " ind2=" ">
								<xsl:call-template name="convertSubjectHeading">
									<xsl:with-param name="ind" select="@ind2"/>
								</xsl:call-template>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="2">
										<xsl:call-template name="removeEndPuctuation">
											<xsl:with-param name="text" select="text()"/>
										</xsl:call-template>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '651']">
							<datafield tag="607" ind1=" " ind2=" ">
								<xsl:call-template name="convertSubjectHeading">
									<xsl:with-param name="ind" select="@ind2"/>
								</xsl:call-template>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="substring-before(text(), ', ')"/>
									</subfield>
									<subfield code="b">
										<xsl:value-of select="substring-after(text(), ', ')"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'x']">
									<subfield code="x">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'z']">
									<subfield code="y">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'y']">
									<subfield code="z">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="2">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '653']">
							<datafield tag="610">
								<xsl:attribute name="ind1">
									<xsl:choose>
										<xsl:when test="@ind1 = ' '">0</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="@ind1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '752']">
							<datafield tag="620">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield">
									<subfield code="@code">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '753']">
							<datafield tag="626">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield">
									<subfield code="@code">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '043']">
							<datafield tag="660">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '045']">
							<datafield tag="661">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '886']">
							<datafield tag="670">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="c">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '080']">
							<datafield tag="675">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '082']">
							<datafield tag="676">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="v">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '050']">
							<datafield tag="680">
								<xsl:attribute name="ind1">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="' '"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '084']">
							<datafield tag="686" ind1=" " ind2=" ">
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '2']">
									<subfield code="2">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '100']">
							<xsl:choose>
								<xsl:when test="@ind1 != 3" >
									<datafield tag="700" ind1=" ">
										<xsl:call-template name="convertPersonalNameSubfields">
											<xsl:with-param name="field" select="."/>
										</xsl:call-template>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '700']">
							<datafield tag="701" ind1=" ">
								<xsl:choose>
									<xsl:when test="@ind1 != 3" >
										<xsl:call-template name="convertPersonalNameSubfields">
											<xsl:with-param name="field" select="."/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '110']">
							<datafield tag="710">
								<xsl:attribute name="ind1">0</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="f">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'u']">
									<subfield code="p">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '4']">
									<subfield code="4">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '111']">
							<datafield tag="710">
								<xsl:attribute name="ind1">1</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="f">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'u']">
									<subfield code="p">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '4']">
									<subfield code="4">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '710']">
							<datafield tag="711">
								<xsl:attribute name="ind1">0</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'b']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="f">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'u']">
									<subfield code="p">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '4']">
									<subfield code="4">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '711']">
							<datafield tag="711">
								<xsl:attribute name="ind1">1</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'e']">
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'n']">
									<subfield code="d">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'c']">
									<subfield code="e">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'd']">
									<subfield code="f">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = 'u']">
									<subfield code="p">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
								<xsl:for-each select="marc:subfield[@code = '4']">
									<subfield code="4">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '100']">
							<xsl:choose>
								<xsl:when test="@ind1 = 3" >
									<datafield tag="720" ind1=" " ind2=" ">
										<xsl:for-each select="marc:subfield[@code = 'a']">
											<subfield code="a">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'd']">
											<subfield code="f">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = '4']">
											<subfield code="4">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '700']">
							<xsl:choose>
								<xsl:when test="@ind1 = 3" >
									<datafield tag="721" ind1=" " ind2=" ">
										<xsl:for-each select="marc:subfield[@code = 'a']">
											<subfield code="a">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = 'd']">
											<subfield code="f">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
										<xsl:for-each select="marc:subfield[@code = '4']">
											<subfield code="4">
												<xsl:value-of select="text()"/>
											</subfield>
										</xsl:for-each>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:for-each select="marc:datafield[@tag = '040']">
							<xsl:for-each select="marc:subfield[@code = 'a']">
								<datafield tag="801" ind1=" " ind2="0">
									<subfield code="a">
										<xsl:call-template name="getCountryFromMarcOrgCode">
											<xsl:with-param name="marcOrgCode" select="text()" />
										</xsl:call-template>
									</subfield>
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</datafield>
							</xsl:for-each>
							<xsl:for-each select="marc:subfield[@code = 'c']">
								<datafield tag="801" ind1=" " ind2="1">
									<subfield code="a">
										<xsl:call-template name="getCountryFromMarcOrgCode">
											<xsl:with-param name="marcOrgCode" select="text()" />
										</xsl:call-template>
									</subfield>
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</datafield>
							</xsl:for-each>
							<xsl:for-each select="marc:subfield[@code = 'd']">
								<datafield tag="801" ind1=" " ind2="2">
									<subfield code="a">
										<xsl:call-template name="getCountryFromMarcOrgCode">
											<xsl:with-param name="marcOrgCode" select="text()" />
										</xsl:call-template>
									</subfield>
									<subfield code="b">
										<xsl:value-of select="text()"/>
									</subfield>
								</datafield>
							</xsl:for-each>
						</xsl:for-each>
						<xsl:for-each select="marc:controlfield[@tag = '008']">
							<xsl:choose>
								<xsl:when test="substring(../marc:leader, 8, 1) = 's'">
									<datafield tag="802">
										<xsl:attribute name="ind1">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<xsl:attribute name="ind2">
											<xsl:value-of select="' '"/>
										</xsl:attribute>
										<subfield code="a">
											<xsl:choose>
												<xsl:when test="substring(text(), 21, 1) = '0'"
													>00</xsl:when>
												<xsl:when test="substring(text(), 21, 1) = '1'"
													>01</xsl:when>
												<xsl:when test="substring(text(), 21, 1) = '4'"
													>04</xsl:when>
												<xsl:when test="substring(text(), 21, 1) = '#'"
													>uu</xsl:when>
												<xsl:when test="substring(text(), 21, 1) = 'z'"
													>zz</xsl:when>
												<xsl:otherwise>zz</xsl:otherwise>
											</xsl:choose>
										</subfield>
									</datafield>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:call-template name="datafield856" />
						<xsl:for-each select="marc:datafield[@tag = '590']">
							<datafield tag="900">
								<xsl:attribute name="ind1">
									<xsl:value-of select="@ind1"/>
								</xsl:attribute>
								<xsl:attribute name="ind2">
									<xsl:value-of select="@ind2"/>
								</xsl:attribute>
								<xsl:for-each select="marc:subfield[@code = 'a']">
									<subfield code="a">
										<xsl:value-of select="text()"/>
									</subfield>
								</xsl:for-each>
							</datafield>
						</xsl:for-each>
						
						
						<xsl:call-template name="selects">
							<xsl:with-param name="i">900</xsl:with-param>
							<xsl:with-param name="count">1000</xsl:with-param>
						</xsl:call-template>
						
					</record>
				</xsl:for-each>
			</xsl:for-each>
		</collection>
	</xsl:template>
	
	<xsl:template name="convertPersonalNameSubfields">
		<xsl:param name="field"></xsl:param>
		<xsl:attribute name="ind2">
			<xsl:value-of select="@ind1"/>
		</xsl:attribute>
		<xsl:for-each select="marc:subfield[@code = 'a']">
			<xsl:choose>
				<xsl:when test="contains(text(), ', ')">
					<subfield code="a" xmlns="http://www.loc.gov/MARC21/slim">
						<xsl:value-of select="substring-before(text(), ', ')"/>
					</subfield>
					<subfield code="b" xmlns="http://www.loc.gov/MARC21/slim">
						<xsl:call-template name="removeEndPuctuation">
							<xsl:with-param name="text" select="substring-after(text(), ', ')"/>
						</xsl:call-template>
					</subfield>
				</xsl:when>
				<xsl:otherwise>
					<subfield code="a" xmlns="http://www.loc.gov/MARC21/slim">
						<xsl:call-template name="removeEndPuctuation">
							<xsl:with-param name="text" select="text()"/>
						</xsl:call-template>
					</subfield>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code = 'b']">
			<subfield code="d" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:call-template name="removeEndPuctuation">
					<xsl:with-param name="text" select="text()"/>
				</xsl:call-template>
			</subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code = 'c']">
			<subfield code="c" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:value-of select="text()"/>
			</subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code = 'd']">
			<subfield code="f" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:call-template name="removeEndPuctuation">
					<xsl:with-param name="text" select="text()"/>
				</xsl:call-template>
			</subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code = 'e']">
			<subfield code="4" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:value-of select="text()"/>
			</subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code = 'q']">
			<subfield code="g" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:value-of select="text()"/>
			</subfield>
		</xsl:for-each>
		<xsl:for-each select="marc:subfield[@code = 'u']">
			<subfield code="p" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:value-of select="text()"/>
			</subfield>
		</xsl:for-each>
		<!--<xsl:for-each select="marc:subfield[@code='?']"><subfield code="3"><xsl:value-of select="text()" /></subfield></xsl:for-each>-->
		<xsl:for-each select="marc:subfield[@code = '4']">
			<subfield code="4" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:value-of select="text()"/>
			</subfield>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="tokenizeSubfield">
		<!--passed template parameter -->
		<xsl:param name="list"/>
		<xsl:param name="delimiter"/>
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="contains($list, $delimiter) and substring-after($list,$delimiter) != ''">
				<subfield xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:attribute name="code">
						<xsl:value-of select="$code" />
					</xsl:attribute>
					<!-- get everything in front of the first delimiter -->
					<xsl:value-of select="substring-before($list,$delimiter)"/>
				</subfield>
				<xsl:call-template name="tokenizeSubfield">
					<!-- store anything left in another variable -->
					<xsl:with-param name="list" select="normalize-space(substring-after($list,$delimiter))"/>
					<xsl:with-param name="delimiter" select="$delimiter"/>
					<xsl:with-param name="code" select="$code"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$list = ''"/>
					<xsl:otherwise>
						<subfield xmlns="http://www.loc.gov/MARC21/slim">
							<xsl:attribute name="code">
								<xsl:value-of select="$code" />
							</xsl:attribute>
							<xsl:call-template name="removeEndPuctuation">
								<xsl:with-param name="text" select="$list"/>
							</xsl:call-template>
							
						</subfield>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="removeEndPuctuation">
		<xsl:param name="text"/>
		<xsl:choose>
			<xsl:when test="string-length(translate(substring($text, string-length($text)), ' ,.:;/', '')) = 0">
				<xsl:value-of
					select="normalize-space(substring($text, 1, string-length($text)-1))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="convertSubjectHeading">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$ind = 0">
				<subfield code="2" xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:value-of select="'lc'"/>
				</subfield>
			</xsl:when>
			<xsl:when test="$ind = 1">
				<subfield code="2" xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:value-of select="'lcch'"/>
				</subfield>
			</xsl:when>
			<xsl:when test="$ind = 2">
				<subfield code="2" xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:value-of select="'mesh'"/>
				</subfield>
			</xsl:when>
			<xsl:when test="$ind = 3">
				<subfield code="2" xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:value-of select="'nal'"/>
				</subfield>
			</xsl:when>
			<!-- What to do if thesaurus source is not specified (ind2 = 4)? --> 
			<xsl:when test="$ind = 5">
				<subfield code="2" xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:value-of select="'cae'"/>
				</subfield>
			</xsl:when>
			<xsl:when test="$ind = 6">
				<subfield code="2" xmlns="http://www.loc.gov/MARC21/slim">
					<xsl:value-of select="'caf'"/>
				</subfield>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="datafield856">
		<xsl:for-each select="marc:datafield[@tag=856]">
			<datafield tag="856" xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:attribute name="ind1">
					<xsl:value-of select="@ind1"/>
				</xsl:attribute>
				<xsl:attribute name="ind2">
					<xsl:value-of select="@ind2"/>
				</xsl:attribute>
				<xsl:for-each select="marc:subfield[@code]">
					<subfield>
						<xsl:attribute name="code">
							<xsl:choose>
								<xsl:when test="@code = 3">
									<xsl:value-of select="2" />
								</xsl:when>
								<xsl:when test="@code = 2">
									<xsl:value-of select="y" />
								</xsl:when>
								<xsl:when test="@code = y">
									<xsl:value-of select="2" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@code" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:value-of select="text()"/>
					</subfield>
				</xsl:for-each>
			</datafield>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="getCountryFromMarcOrgCode">
		<xsl:param name="marcOrgCode" select="text()" />
		<xsl:choose>
			<xsl:when test="substring($marcOrgCode, 3, 1) = '-'">
				<xsl:value-of select="substring($marcOrgCode, 1, 2)"/>
			</xsl:when>
			<xsl:when test="$marcOrgCode = 'DLC'">
				<xsl:value-of select="'US'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="selects">
		<xsl:param name="i" />
		<xsl:param name="count" />
		
		<xsl:if test="$i &lt;= $count">
			<xsl:for-each select="marc:datafield[@tag=$i]">
			<datafield xmlns="http://www.loc.gov/MARC21/slim">
				<xsl:attribute name="tag"><xsl:value-of select="@tag" /></xsl:attribute>
				<xsl:attribute name="ind1">
					<xsl:value-of select="@ind1"/>
				</xsl:attribute>
				<xsl:attribute name="ind2">
					<xsl:value-of select="@ind2"/>
				</xsl:attribute>
				<xsl:for-each select="marc:subfield[@code]">
					<subfield>
						<xsl:attribute name="code">
							<xsl:value-of select="@code" />
						</xsl:attribute>
						<xsl:value-of select="text()"/>
					</subfield>
				</xsl:for-each>
			</datafield>
			</xsl:for-each>
		</xsl:if>
		
		<!--begin_: RepeatTheLoopUntilFinished-->
		<xsl:if test="$i &lt; $count">
			<xsl:call-template name="selects">
				<xsl:with-param name="i">
					<xsl:value-of select="$i + 1"/>
				</xsl:with-param>
				<xsl:with-param name="count">
					<xsl:value-of select="$count"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
