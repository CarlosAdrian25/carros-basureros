# routes/web/general_routes.py
from flask import Blueprint, render_template, redirect, url_for, request, session, flash
from werkzeug.security import check_password_hash
from models.user_model import User
import jwt
from datetime import datetime, timedelta

web_bp = Blueprint('web_bp', __name__, url_prefix='/web')
SECRET_KEY = "tu_clave_secreta_jwt"

@web_bp.route('/')
def index():
    # Verificar si hay un token en la sesión
    if 'token' not in session:
        # Si no hay token, redirigir a la página de inicio de sesión
        return redirect(url_for('web_bp.auth_login'))
    
    # Si hay token, mostrar el index o la página principal
    return render_template('index.html')

@web_bp.route('/auth/login', methods=['GET', 'POST'])
def auth_login():
    if request.method == 'POST':
        carnet_identidad = request.form.get("username")
        password = request.form.get("password")

        # Buscar usuario por carnet de identidad
        user_data = User.find_by_carnet(carnet_identidad)
        if not user_data:
            flash("Usuario no encontrado", "error")
            return render_template('login.html')

        # Verificar la contraseña
        if not check_password_hash(user_data["password"], password):
            flash("Contraseña incorrecta", "error")
            return render_template('login.html')

        # Validación de rol para acceso en la web
        if user_data["rol"] not in ["superadmin", "admin"]:
            flash("Acceso denegado: solo administradores pueden iniciar sesión en la web", "error")
            return render_template('login.html')

        # Generar el token JWT
        token = jwt.encode({
            "carnet_identidad": user_data["carnet_identidad"],
            "rol": user_data["rol"],
            "exp": datetime.utcnow() + timedelta(hours=2)
        }, SECRET_KEY, algorithm="HS256")

        # Guardar el token en la sesión y redirigir al dashboard
        session['token'] = token
        flash("Inicio de sesión exitoso", "success")
        return redirect(url_for('web_bp.dashboard'))

    return render_template('login.html')

@web_bp.route('/dashboard')
def dashboard():
    # Verificación de la existencia del token en la sesión
    if 'token' not in session:
        return redirect(url_for('web_bp.auth_login'))

    # Decodificación y verificación del token JWT
    try:
        decoded_token = jwt.decode(session['token'], SECRET_KEY, algorithms=["HS256"])
        return render_template('dashboard.html', user=decoded_token)
    except jwt.ExpiredSignatureError:
        flash("Sesión expirada. Por favor, inicie sesión de nuevo.", "error")
        return redirect(url_for('web_bp.auth_login'))
    except jwt.InvalidTokenError:
        flash("Token inválido. Inicie sesión de nuevo.", "error")
        return redirect(url_for('web_bp.auth_login'))
