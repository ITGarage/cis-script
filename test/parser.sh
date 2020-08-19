#awk '/__________________________________________________________________________________________________________________/{flag=1} /- Rationale:/{flag=0} flag' report.txt
#awk '/__________________________________________________________________________________________________________________/{nr[NR]; nr[NR+2]}; NR in nr' report.txt
#awk '/__________________________________________________________________________________________________________________/{nr[NR]; nr[NR+1]}; NR in nr' report.txt


# export names
awk 'c&&!--c;/__________________________________________________________________________________________________________________/{c=2}' report.txt

# export description
awk '/- Description:/{flag=1} /- Rationale:/{flag=0} flag' report.txt

# export rationale
awk '/- Rationale:/{flag=1} /current settings is:/{flag=0} flag' report.txt

# export current settings
awk '/current settings is:/{flag=1} /score pattern is:/{flag=0} flag' report.txt
# awk '/current settings is:/{nr[NR]; nr[NR+1]}; NR in nr' report.txt

# export score pattern
awk '/score pattern is:/{nr[NR]; nr[NR+1]}; NR in nr' report.txt


# awk '$1=="__________________________________________________________________________________________________________________" && $2>1 {print f} {f=$1}' report.txt
# awk '/__________________________________________________________________________________________________________________/{nr[NR]; nr[NR-2]}; NR in nr' report.txt
# awk '/__________________________________________________________________________________________________________________/ { print ; for(n=0; n<2; n++) { getline ; print } }' report.txt
# awk 'c&&!--c;/__________________________________________________________________________________________________________________/{c=2}' report.txt

sed -n '/__________________________________________________________________________________________________________________/,/__________________________________________________________________________________________________________________/{//!p;}' report.txt >> par.txt 

awk 'BEGIN{print "<table>"} {print "<tr>"; for(i=1;i<=NF;i++)print "<td>" $i"</td>";print "</tr>"} END{print "</table>"}' report.txt >> email.html
awk 'BEGIN{print "<table>"} {print "<tr>";print "<td>"; action ; "</td>";print "</tr>"} END{print "</table>"}' report.txt >> email.html

awk 'BEGIN{print "<table>"} {print "<tr>"; /- Description:/{flag=1} /- Rationale:/{flag=0} flag ;print "</tr>"} END{print "</table>"}' report.txt >> email.html

awk -f myscript.awk report.txt