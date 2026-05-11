from flask import Flask,render_template,session,request,flash,redirect
from .model import bdd

app=Flask(__name__)
app.template_folder="template"
app.static_folder="static"
app.config.from_object('application.config')

@app.route("/login")
def login():
    return render_template("login.html")


@app.route("/register")
def register():
    return render_template("register.html")


@app.route("/webmasters")
def webmasters():
    return render_template("webmasters.html")

@app.route("/")
def index():
    return render_template("index.html")

#authentification
@app.route("/connecter", methods=["POST"])
def connect():
    login = request.form['login']
    mdp = request.form['mdp']
    user = bdd.verifAuthData(login,mdp)
    print(user)
    try:
        #authentification réussie
        session["idutilisateur"] = user["idutilisateur"]
        session["nom"] = user["nom"]
        session["prenom"] = user["prenom"]
        session["login"] = user["login"]
        session["motdepasse"] = user["motdepasse"]
        session["admin"] = user["admin"]
        flash("Authentification réussie", "success")
        return redirect("/")
    
    except TypeError as err:
        #authentification refusée
        flash("Authentification refusée", "danger")
        return redirect("/login")
