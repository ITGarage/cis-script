#!/usr/bin/env bash
logfile='report.txt'
report_html='log.html'

rm $report_html
echo '<!DOCTYPE html>' >>$report_html
echo '<html lang="en">' >>$report_html
echo '<head>' >>$report_html
echo '<meta charset="utf-8">' >>$report_html
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >>$report_html
echo '<meta http-equiv="x-ua-compatible" content="ie=edge">' >>$report_html
echo '<title>cis ubuntu linux 20.04 lts benchmark report</title>' >>$report_html
echo '</head>' >>$report_html
echo '<body>' >>$report_html
echo '<h2>cis ubuntu linux 20.04 lts benchmark report</h2>' >>$report_html
echo '<hr>' >>$report_html
# echo '<pre>' >>$report_html
awk '
BEGIN { ORS=" " }
    c&&!--c;/__________________________________________________________________________________________________________________/{c=2}

    /- Description:/{flag=1}
    /- Rationale:/{flag=0}

    /- Rationale:/{flag=2}
    /current settings is:/{flag=0}

    /current settings is:/{flag=3}
    /score pattern is:/{flag=0} 

    {print "<div>"}; flag; {print "</div>"}

    $0=="scored" {print "<p style=\"color:green\"><b>" $0 "</b></p>"}
    $0~/not scored/ {print "<p style=\"color:red\"><b>" $0 "</b></p>"}

    ' $logfile >>$report_html
# echo '</pre>' >>$report_html
echo '</body>' >>$report_html
echo '</html>' >>$report_html
