import schema namespace csv-options="http://www.zorba-xquery.com/modules/converters/csv-options";
import module namespace csv = "http://www.zorba-xquery.com/modules/converters/csv";

csv:parse(
'f1, f2, f3, f4, f10, f11
f5, f6, "f7", "f8
""f9",f8', 
validate{
<csv-options:options2>
  <first-row-is-header/>
  <csv separator=","
       quote-char="&quot;"
       quote-escape="&quot;&quot;"/>
</csv-options:options2>}
)
