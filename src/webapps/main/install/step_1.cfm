<!DOCTYPE html>
<html lang="de">
    <head>
        <title>Willkommen bei der Installation des irCMS</title>
    </head>
    <body>
        <h1>Willkommen bei der Installation des irCMS</h1>
        <form action="step_2.cfm" method="post">
            <input name="datasource" placeholder="Name of the default (select) datasource">
            <input name"datasourceAdmin" placeholder="Name of the admin (update/insert) datasource">
            <input name="username" placeholder="Username of the Adminuser">
            <input name="userEmail" placeholder"Email adress of the Admin">
            <input name"defaultThemename" placeholder="Default Themename (Default: icedreaper)" default="icedreaper">
            
            <submit>Install irCMS</submit>
        </form>
    </body>
</html>