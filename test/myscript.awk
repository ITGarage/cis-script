#!/usr/bin/env bash
awk '
BEGIN{print "<table>"}

    {print "<tr>";
        (/- Description:/{flag=1} /- Rationale:/{flag=0} flag) print "<td>" $i"</td>";
    print "</tr>"}

END{print "</table>"}