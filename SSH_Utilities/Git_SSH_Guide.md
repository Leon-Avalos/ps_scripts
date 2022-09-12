## Configuracion de autenticacion de Github con SSH 

1. Configurar credenciales
	global: 
		```git config —global user.name “user_name"```
		```git config —global user.email “email@email.com”```

	local: 
		```git config —local user.name “user_name”```
		```git config —local user.email “email@email.com”```

2. Crear llave SSH 
	```ssh-keygen -t 25519 -C “comment”```

3. Copiar al gitthub
	```nano /path-to-key```


4. Cambiar URL remota 
	```git remote set-url origin <ssh-url>```