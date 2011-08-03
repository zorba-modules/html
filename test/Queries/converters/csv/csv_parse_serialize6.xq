(:
Parse a csv file with subheaders and a limited range of data, 
then serialize back to the same format.
Note the character escaping for the QNames. Also the empty line from subheader is ignored.
The csv has been taken from http://data.gov.
:)
import schema namespace csv-options="http://www.zorba-xquery.com/modules/converters/csv-options";
import module namespace csv = "http://www.zorba-xquery.com/modules/converters/csv";
import module namespace file="http://expath.org/ns/file";

let $options := 
validate{
<csv-options:options>
  <first-row-is-header line="5-8"/>
  <start-from-row line="    9 - 75 "/>
  <csv separator=","
       quote-char="&quot;"
       quote-escape="&quot;&quot;"/>
</csv-options:options> }
return
csv:serialize(
        csv:parse(file:read-text(fn:resolve-uri("Hospital Outpatient Payments for 61 Commonly Performed Procedures, CY 2008 Data.csv")),
                        $options),
        $options) 


(:

Example csv input:

OUTPATIENT HOSPITAL PAYMENTS FOR 61 COMMONLY PERFORMED PROCEDURES,,,,,,
2008 CALENDAR YEAR CLAIMS PROCESSED THROUGH JUNE 2009,,,,,,
SOURCE:  NATIONAL CLAIMS HISTORY,,,,,,
14-Oct-09,,,,,,
 STATE,COUNTY,HOSPITAL NAME,Removal of damaged skin and underlying tissue,,Breast biopsy through skin with sampling device,,
,,,CPT 11042,,CPT 19103,
,,,,,,
,,,Allowed Services+,Range of Payment Rates by County+,Allowed Services+,Range of Payment Rates by County+
NATIONAL,,,"622,289",102 - 228,"60,717"
California,Los Angeles, ,"12,831",187,"1,037",955
California,Los Angeles,ALHAMBRA HOSPITAL MEDICAL CENTER,0,,0,

---------------------------------------------------------------

Intermediate output from parsing:

<row>
  <_STATE>NATIONAL</_STATE>
  <COUNTY/>
  <HOSPITAL_NAME/>
  <Removal_of_damaged_skin_and_underlying_tissue>
    <CPT_11042>
      <Allowed_Services_>622,289</Allowed_Services_>
      <Range_of_Payment_Rates_by_County_>102 - 228</Range_of_Payment_Rates_by_County_>
    </CPT_11042>
  </Removal_of_damaged_skin_and_underlying_tissue>
  <Breast_biopsy_through_skin_with_sampling_device>
    <CPT_19103>
      <Allowed_Services_>60,717</Allowed_Services_>
      <Range_of_Payment_Rates_by_County_>536 - 1147</Range_of_Payment_Rates_by_County_>
    </CPT_19103>
  </Breast_biopsy_through_skin_with_sampling_device>
</row><row>
  <_STATE>California</_STATE>
  <COUNTY>Los Angeles</COUNTY>
  <HOSPITAL_NAME> </HOSPITAL_NAME>
  <Removal_of_damaged_skin_and_underlying_tissue>
    <CPT_11042>
      <Allowed_Services_>12,831</Allowed_Services_>
      <Range_of_Payment_Rates_by_County_>187</Range_of_Payment_Rates_by_County_>
    </CPT_11042>
  </Removal_of_damaged_skin_and_underlying_tissue>
  <Breast_biopsy_through_skin_with_sampling_device>
    <CPT_19103>
      <Allowed_Services_>1,037</Allowed_Services_>
      <Range_of_Payment_Rates_by_County_>955</Range_of_Payment_Rates_by_County_>
    </CPT_19103>
  </Breast_biopsy_through_skin_with_sampling_device>
</row><row>
  <_STATE>California</_STATE>
  <COUNTY>Los Angeles</COUNTY>
  <HOSPITAL_NAME>ALHAMBRA HOSPITAL MEDICAL CENTER</HOSPITAL_NAME>
  <Removal_of_damaged_skin_and_underlying_tissue>
    <CPT_11042>
      <Allowed_Services_>0</Allowed_Services_>
      <Range_of_Payment_Rates_by_County_/>
    </CPT_11042>
  </Removal_of_damaged_skin_and_underlying_tissue>
  <Breast_biopsy_through_skin_with_sampling_device>
    <CPT_19103>
      <Allowed_Services_>0</Allowed_Services_>
      <Range_of_Payment_Rates_by_County_/>
    </CPT_19103>
  </Breast_biopsy_through_skin_with_sampling_device>
</row>

-----------------------------------------------------------------------

Final output from serialization:

_STATE,COUNTY,HOSPITAL_NAME,Removal_of_damaged_skin_and_underlying_tissue,,Breast_biopsy_through_skin_with_sampling_device,
,,,CPT_11042,,CPT_19103,
,,,Allowed_Services_,Range_of_Payment_Rates_by_County_,Allowed_Services_,Range_of_Payment_Rates_by_County_
NATIONAL,,,"622,289",102 - 228,"60,717",536 - 1147
California,Los Angeles,,"12,831",187,"1,037",955
California,Los Angeles,ALHAMBRA HOSPITAL MEDICAL CENTER,0,,0,

:)

