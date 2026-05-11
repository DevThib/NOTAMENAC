from . import bddGen
import inspect

def func_name():
    return inspect.currentframe().f_back.f_code.co_name

def verifAuthData(login, mdp):
    sql = "SELECT * FROM Utilisateur WHERE login=%s and motdepasse=%s"
    param=(login,mdp)
    return bddGen.selectOneData(func_name(),sql,param,None)