<cfoutput>
    <tr>
        <td><a href="/Admin/Pages/#attributes.navigationId#/#attributes.version#">#attributes.pageName#</a></td>
        <td><a href="#attributes.sesLink#" target="_blank">#attributes.sesLink#</a></td>
        <td>#attributes.status#</td>
        <td>#attributes.version#</td>
        <td>
            #dateFormat(dateConvert('utc2local', attributes.lastChangeAt), "DD. MMM YYYY")#
            #timeFormat(dateConvert('utc2local', attributes.lastChangeAt), "HH:MM:SS")#
            von <a href="/User/#attributes.lastChangeBy#" target="_blank" title="Profilseite von #attributes.lastChangeBy#">#attributes.lastChangeBy#</a>
        </td>
        <td>
            <div class="btn-group">
                <a class="btn btn-default" title="Diese Version des Artikels bearbeiten" href="/Admin/Pages/#attributes.navigationId#/#attributes.version#/Bearbeiten"><span class="glyphicon glyphicon-pencil"></span></a>
                <a class="btn btn-success" title="Diese Version freigeben" href="/Admin/Pages/#attributes.navigationId#/#attributes.version#/Freigeben"><span class="glyphicon glyphicon-ok"></span></a>
                <a class="btn btn-danger"  title="Diese Version löschen" href="/Admin/Pages/#attributes.navigationId#/#attributes.version#/Löschen"><span class="glyphicon glyphicon-remove"></span></a>
            </div>
        </td>
    </tr>
</cfoutput>