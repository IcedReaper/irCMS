<cfoutput>
    <div class="login">
        <cfif request.userId eq 0>
            <a href="##">Login</a>
            <div class="loginForm">
                <form action="?login" method="post" autocomplete="false">
                    <input name="username" placeholder="username"><br>
                    <input name="password" type="password" placeholder="password"><br>
                    
                    <button type="submit" value="login">Einloggen</button>
                    <button type="submit" value="register">Registrieren</button>
                </form>
            </div>
        <cfelse>
    		Sie sind momentan Eingeloggt als #request.actualUser.getUsername()#<br>
    		<a href="?logout">Ausloggen</a>
    	</cfif>
    </div>
</cfoutput>