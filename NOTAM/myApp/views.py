import secrets
import string
import hashlib
from flask import Flask, render_template, redirect, request, session, flash
from .model import bdd
app = Flask(__name__)
app.template_folder = "template"
app.static_folder = "static"
app.config.from_object('myApp.config')

@app.route("/")
def index():
    return render_template("index.html")



@app.route("/espace_administrateur")
def espace_administrateur():
    return render_template("espace_admin.html")

@app.route("/deconnexion")
def deconnexion():
    session.clear()
    return redirect('/')

@app.route("/sgbd")
def sgbd():
    listeMembres=bdd.get_membresData()
    params={'liste':listeMembres}
    return render_template("sgbd.html",**params)

@app.route("/suppMembre/<idUser>")
def suppMembre(idUser):
    
    msg=""
    bdd.del_membreData(idUser,msg)
    return redirect("/sgbd")

@app.route("/compte")
def connect():
    return render_template("compte.html")

@app.route("/creation", methods=['GET','POST'])
def creation():
    nom=request.form['nom']
    prenom=request.form['prenom']
    login=request.form['login']
    caracteres = string.ascii_letters + string.digits
    mdp = ''.join(secrets.choice(caracteres) for _ in range(5))
    print("Mot de passe généré :",mdp)
    motdepasse = hashlib.sha256(mdp.encode()).hexdigest()
    print("Mot de passe chiffré :",motdepasse)
    bdd.add_membreData(nom,prenom,login,motdepasse)
    user=bdd.verifAuthData(login,motdepasse)
    session["login"] = user["login"]
    session["motdepasse"] = user["motdepasse"]
    flash(mdp,"success")
    return redirect("/logout.html")


@app.route("/login")
def login():
    return render_template("login.html")

@app.route("/connexion", methods=['GET','POST'])
def connexion():
    login=request.form['login']
    motdepasse=request.form['motdepasse']
    user=bdd.verifAuthData(login,motdepasse)
    print (user)
    try :
        session["login"] = user["login"]
        session["motdepasse"] = user["motdepasse"]
        flash("Authentification réussie", "success")
        return redirect("/")
    
    except TypeError as err :
        flash("Authentification refusée", "danger")
        return redirect("/login.html")
    