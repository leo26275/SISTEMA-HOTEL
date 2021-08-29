<%-- 
    Document   : Login
    Created on : 04-21-2019, 10:01:45 AM
    Author     : leo_g
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
	<title>Inicio de Sesión | Hotel Notre Dame</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="sources/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="sources/css/util.css">
	<link rel="stylesheet" type="text/css" href="sources/css/main.css">
<!--===============================================================================================-->
</head>
<body>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20">
                            <form class="login100-form validate-form" action="IniciarSesion.do" method="GET">
					<span class="login100-form-title p-b-70">
						Bienvenido a NOTRE DAME
					</span>
					<span class="login100-form-avatar">
						<img src="images/logo login.png" alt="Imagen usuario">
					</span>

					<div class="wrap-input100 validate-input m-t-85 m-b-35" data-validate = "Ingrese un Usuario">
						<input class="input100" type="text" name="username">
						<span class="focus-input100" data-placeholder="Usuario"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-50" data-validate="Ingrese una contraseña">
						<input class="input100" type="password" name="pass">
						<span class="focus-input100" data-placeholder="Contraseña"></span>
					</div>

					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Iniciar sesión
						</button>
					</div>

					<br>
						<!--<li class="m-b-8">
							<span class="txt1">
								Olvidó
							</span>

							<a href="#" class="txt2">
								Usuario / Contraseña?
							</a>
						</li>

						<li>
							<span class="txt1">
						¿No tienes una cuenta?
							</span>

							<a href="#" class="txt2">
								Regístrate
							</a>
						</li>-->

				</form>
			</div>
		</div>
	</div>


	<div id="dropDownSelect1"></div>

<!--===============================================================================================-->
	<script src="sources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="sources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="sources/vendor/bootstrap/js/popper.js"></script>
	<script src="sources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="sources/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="sources/vendor/daterangepicker/moment.min.js"></script>
	<script src="sources/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="sources/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="sources/js/main.js"></script>

</body>
