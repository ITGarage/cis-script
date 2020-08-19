#!/usr/bin/env bash
logfile='report.txt'
report_html='log.html'

echo '<!DOCTYPE html>' >$report_html
echo '<html lang="en">' >>$report_html
echo '<head>' >>$report_html
echo '<meta charset="utf-8">' >>$report_html
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >>$report_html
echo '<meta http-equiv="x-ua-compatible" content="ie=edge">' >>$report_html
echo '<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha512-M5KW3ztuIICmVIhjSqXe01oV2bpe248gOxqmlcYrEzAvws7Pw3z6BK0iGbrwvdrUQUhi3eXgtxp5I8PDo9YfjQ==" crossorigin="anonymous"></script>' >>$report_html
echo '<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>' >>$report_html
echo '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha512-MoRNloxbStBcD8z3M/2BmnT+rg4IsMxPkXaGh2zD6LGNNFE80W3onsAhRcMAMrSoyWL9xD7Ert0men7vR8LUZg==" crossorigin="anonymous" />' >>$report_html
echo '<title>cis ubuntu linux 20.04 lts benchmark report</title>' >>$report_html
echo '</head>' >>$report_html
echo '<body>' >>$report_html
echo '<h2 class="text-center">cis ubuntu linux 20.04 lts benchmark report</h2>' >>$report_html
echo '<hr>' >>$report_html
# echo '<pre>' >>$report_html
awk '
BEGIN { ORS="" }
    $0=="scored" {val1=$0; print "<div class=\"text-center container badge-success\">" val1 "</div>"} 
    $0~/not scored/ {val1=$0; print "<div class=\"text-center container badge-danger\">" val1 "</div>"}
    $0~/___________/ {getline; getline; print "<div class=\"container\">" $0 "</div>"} # get 2nd line after match
    /- Description:/{flag=1; next} 
    /- Result:/{flag=0}
    {print "<div class=\"container\">"}; flag; {print "</div>"}
    ' $logfile >>$report_html
# echo '</pre>' >>$report_html
echo '</body>' >>$report_html
echo '</html>' >>$report_html




    # /__________________________________________________________________________________________________________________/{flag=1}
    # # /__________________________________________________________________________________________________________________/{flag=0}
    # /__________________________________________________________________________________________________________________/{flag=1; next} 
    # /- Result:/{flag=0}

    # /- Description:/,/- Result:/{val1=$0; print "<pre>" val1 "</pre>"}
    
    # /- Description:/{flag=1}
    # /- Rationale:/{flag=0}

    # /- Rationale:/{flag=1}
    # /- Current settings:/{flag=0}
    
    # /- Current settings:/{flag=1}
    # /- Score pattern:/{flag=0} 