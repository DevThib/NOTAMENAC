from . import bddGen
import inspect

def func_name():
    return inspect.currentframe().f_back.f_code.co_name

def get_membresData():
    sql="SELECT * FROM Utilisateur"
    param=None
    return bddGen.selectData(func_name(), sql, param, None)

def add_membreData(nom,prenom,login,motdepasse):
    sql = """INSERT INTO Utilisateur
    (nom, prenom, login, motdepasse, admin)
    VALUES (%s, %s, %s, %s, %s); """
    param = (nom, prenom, login, motdepasse,1)
    return bddGen.addData(func_name(), sql, param,None)

def verifAuthData(login,motdepasse):
    sql = "SELECT * FROM Utilisateur WHERE login=%s and motdepasse=%s"
    param=(login,motdepasse)
    return bddGen.selectOneData(func_name(),sql, param, None)