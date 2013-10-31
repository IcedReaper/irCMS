<cfoutput>
    <tr>
        <td>#attributes.pageName#</td>
        <td>#attributes.sesLink#</td>
        <td>#attributes.status#</td>
        <td>#attributes.version#</td>
        <td>#dateFormat(dateConvert('utc2local', attributes.lastChangeAt), "DD. MMM YYYY")# #timeFormat(dateConvert('utc2local', attributes.lastChangeAt), "HH:MM:SS")# von <a href="/User/#attributes.lastChangeBy#" target="_blank" title="Profilseite von #attributes.lastChangeBy#">#attributes.lastChangeBy#</a></td>
    </tr>
</cfoutput>