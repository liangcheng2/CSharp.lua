-- Generated by CSharp.lua Compiler 1.0.0.0
local System = System
local CSharpLuaLuaAst
System.usingDeclare(function (global) 
  CSharpLuaLuaAst = CSharpLua.LuaAst
end)
System.namespace("CSharpLua.LuaAst", function (namespace) 
  namespace.class("LuaWrapFunctionStatementSynatx", function (namespace) 
    local UpdateIdentifiers, getBody, AddMemberDeclaration, Render, __init__, __ctor__
    __init__ = function (this) 
      this.function_ = CSharpLuaLuaAst.LuaFunctionExpressionSyntax()
    end
    __ctor__ = function (this) 
      __init__(this)
      CSharpLuaLuaAst.LuaStatementSyntax.__ctor__(this)
    end
    UpdateIdentifiers = function (this, name, target, memberName, parameter) 
      local memberAccess = CSharpLuaLuaAst.LuaMemberAccessExpressionSyntax(target, memberName, false)
      local invoke = CSharpLuaLuaAst.LuaInvocationExpressionSyntax:new(1, memberAccess)
      invoke:AddArgument(CSharpLuaLuaAst.LuaStringLiteralExpressionSyntax(name))
      invoke:AddArgument(this.function_)
      if parameter ~= nil then
        this.function_:AddParameter1(parameter)
      end
      this.Statement = CSharpLuaLuaAst.LuaExpressionStatementSyntax(invoke)
    end
    getBody = function (this) 
      return this.function_.Body
    end
    AddMemberDeclaration = function (this, statement) 
      if statement == nil then
        System.throw(System.ArgumentNullException("statement" --[[nameof(statement)]]))
      end
      getBody(this).Statements:Add(statement)
    end
    Render = function (this, renderer) 
      renderer:Render1(this)
    end
    return {
      __inherits__ = function (global) 
        return {
          global.CSharpLua.LuaAst.LuaStatementSyntax
        }
      end, 
      UpdateIdentifiers = UpdateIdentifiers, 
      getBody = getBody, 
      AddMemberDeclaration = AddMemberDeclaration, 
      Render = Render, 
      __ctor__ = __ctor__
    }
  end)
  namespace.class("LuaNamespaceDeclarationSyntax", function (namespace) 
    local __ctor__
    __ctor__ = function (this, name, isContained) 
      this.__base__.__ctor__(this)
      local default
      if isContained then
        default = CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace
      else
        default = CSharpLuaLuaAst.LuaIdentifierNameSyntax.System
      end
      this:UpdateIdentifiers(name, default, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace, CSharpLuaLuaAst.LuaIdentifierNameSyntax.Namespace)
    end
    return {
      __inherits__ = function (global) 
        return {
          global.CSharpLua.LuaAst.LuaWrapFunctionStatementSynatx
        }
      end, 
      __ctor__ = __ctor__
    }
  end)
end)
